import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../domain/endpoints.dart';
import '../../domain/token/model/token_refresh_response.dart';
import '../../domain/token/model/token_verify_request.dart';
import '../../domain/token/repository/repository.dart';
import '../../domain/token/repository/token_repository.dart';
import '../../domain/validation_enum.dart';
import '../../utils/build_configs/build_config.dart';
import '../../utils/header_util.dart';
import '../../utils/logging_interceptor.dart';
import 'asklora_error.dart';

class BaseApiClient {
  late Dio _dio;

  BaseApiClient() {
    _dio = _createDio();
  }

  Future<Response> post(
          {required String endpoint,
          required String payload,
          Map<String, dynamic>? queryParameters}) async =>
      _dio.post(endpoint, data: payload, queryParameters: queryParameters);

  Future<Response> get(
          {required String endpoint,
          Map<String, dynamic>? queryParameters}) async =>
      _dio.get(endpoint, queryParameters: queryParameters);

  Future<Response> patch(
          {required String endpoint, required String payload}) async =>
      _dio.patch(endpoint, data: payload);

  String get baseUrl => Environment().config.askLoraApiBaseUrl;

  Map<String, String> get headers => {};

  String? get token => null;

  final Duration timeOutDuration = const Duration(seconds: 60);

  Dio _createDio() {
    var dio = Dio(BaseOptions(
        connectTimeout: timeOutDuration,
        sendTimeout: timeOutDuration,
        receiveTimeout: timeOutDuration,
        baseUrl: baseUrl,
        followRedirects: false,
        validateStatus: (status) {
          if (status != null && status < 300) {
            return true;
          }
          return false;
        },
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          ...headers
        }));

    if (kDebugMode) {
      dio.interceptors.add(LoggingInterceptor());
    }
    dio.interceptors.add(AppInterceptors(TokenRepository(), dio, token));
    return dio;
  }
}

class AppInterceptors extends Interceptor {
  final Repository _storage;
  final Dio _dio;
  String? _deviceId;
  String? _userAgent;
  String? token;

  Future<String?> _loadDeviceId() async {
    _deviceId = await getDeviceId();
    return _deviceId;
  }

  Future<String?> _loadDeviceAgent() async {
    _userAgent = await getDeviceAgent();
    return _userAgent;
  }

  AppInterceptors(this._storage, this._dio, this.token);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var accessToken = await _storage.getAccessToken();
    if (token == null) {
      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    } else {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['X-Device-id'] = _deviceId ?? await _loadDeviceId();
    options.headers['X-Device-User-Agent'] =
        _userAgent ?? await _loadDeviceAgent();
    return handler.next(options);
  }

  Future<void> _handleExpiredToken(
      DioException error, ErrorInterceptorHandler handler) async {
    final accessToken = await _refreshToken();

    if (accessToken.isNotEmpty) {
      /// Check if the last API call was `auth/verify/`. If, then replace the old token
      /// with the new (refreshed) one.
      final requestOptions = error.requestOptions;

      if (requestOptions.path == endpointTokenVerify) {
        requestOptions.data = TokenVerifyRequest(accessToken).toJson();
      }

      return handler.resolve(await _retry(error.requestOptions));
    }
    handler.next(error);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return _dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<String> _refreshToken() async {
    var accessToken = '';
    try {
      final refreshToken = await _storage.getRefreshToken();
      final refreshTokenUrl =
          Environment().config.askLoraApiBaseUrl + endpointTokenRefresh;
      final response =
          await _dio.post(refreshTokenUrl, data: {'refresh': refreshToken});

      if (response.statusCode == 200) {
        var refreshResponse = TokenRefreshResponse.fromJson(response.data);
        accessToken = refreshResponse.access!;
        await _storage.saveAccessToken(accessToken);
        return accessToken;
      } else {
        await _storage.deleteAll();
        return accessToken;
      }
    } catch (e) {
      return accessToken;
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw DeadlineExceededException(
            err.requestOptions, const AskloraError());
      case DioExceptionType.badResponse:
        final askloraError = err.response != null
            ? AskloraError.fromJson(err.response!.data)
            : AskloraError(detail: '', code: ValidationCode.unknown.code);
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions, askloraError);
          case 401:

            /// TODO: Remove `Token invalid` and `Token invalid` checks once the BE apply this new code all across the place.

            final aiErrorMessage = err.response?.data['detail'];

            final message = err.response?.data['message'];
            if (message == 'Token invalid' ||
                message == 'Token invalid / expired' ||
                aiErrorMessage == 'Unauthorized' ||
                askloraError.type == ValidationCode.invalidToken) {
              _handleExpiredToken(err, handler);
              return;
            } else {
              throw UnauthorizedException(err.requestOptions, askloraError);
            }
          case 403:
            throw ForbiddenException(err.requestOptions, askloraError);
          case 404:
            throw NotFoundException(err.requestOptions, askloraError);
          case 406:
            throw NotAcceptableException(err.requestOptions, askloraError);
          case 409:
            throw ConflictException(err.requestOptions, askloraError);
          case 451:
            throw LegalReasonException(err.requestOptions, askloraError);
          case 500:
            throw InternalServerErrorException(
                err.requestOptions, askloraError);
        }
        break;
      case DioExceptionType.cancel:
        throw AskloraApiClientException(err.requestOptions,
            askloraError: const AskloraError());
      case DioExceptionType.unknown:
        throw NoInternetConnectionException(err.requestOptions,
            AskloraError(code: ValidationCode.noInternetConnection.code));
      case DioExceptionType.badCertificate:
        throw AskloraApiClientException(err.requestOptions,
            askloraError: const AskloraError());
      case DioExceptionType.connectionError:
        throw AskloraApiClientException(err.requestOptions,
            askloraError: const AskloraError());
      default:
        throw AskloraApiClientException(err.requestOptions,
            askloraError: const AskloraError());
    }

    return handler.next(err);
  }
}

class BadRequestException extends AskloraApiClientException {
  BadRequestException(RequestOptions r, askloraError)
      : super(r, askloraError: askloraError);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class ConflictException extends AskloraApiClientException {
  ConflictException(RequestOptions r, askloraError)
      : super(r, askloraError: askloraError);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends AskloraApiClientException {
  UnauthorizedException(RequestOptions r, askloraError)
      : super(r, askloraError: askloraError);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends AskloraApiClientException {
  NotFoundException(RequestOptions r, askloraError)
      : super(r, askloraError: askloraError);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class ForbiddenException extends AskloraApiClientException {
  ForbiddenException(RequestOptions r, askloraError)
      : super(r, askloraError: askloraError);

  @override
  String toString() {
    return "You don't have permission to access this resource";
  }
}

class LegalReasonException extends AskloraApiClientException {
  LegalReasonException(RequestOptions r, askloraError)
      : super(r, askloraError: askloraError);

  @override
  String toString() {
    return 'The account is suspended, cannot continue';
  }
}

class InternalServerErrorException extends AskloraApiClientException {
  InternalServerErrorException(RequestOptions r, askloraError)
      : super(r, askloraError: askloraError);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class NotAcceptableException extends AskloraApiClientException {
  NotAcceptableException(RequestOptions r, askloraError)
      : super(r, askloraError: askloraError);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends AskloraApiClientException {
  NoInternetConnectionException(RequestOptions r, askloraError)
      : super(r, askloraError: askloraError);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends AskloraApiClientException {
  DeadlineExceededException(RequestOptions r, askloraError)
      : super(r, askloraError: askloraError);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}

class AskloraApiClientException extends DioException {
  AskloraApiClientException(RequestOptions r, {required this.askloraError})
      : super(requestOptions: r);

  final AskloraError askloraError;

  @override
  String toString() {
    return 'Something went wrong while fetching the api.';
  }
}
