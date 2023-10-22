import 'package:equatable/equatable.dart';

import 'validation_enum.dart';

enum ResponseState { success, error, unknown, loading, suspended }

class BaseResponse<T> extends Equatable {
  static const String errorMessage = 'Something went wrong! Please try again.';

  final ResponseState state;
  final T? data;
  final ValidationCode validationCode;
  final String message;

  const BaseResponse(
      {this.state = ResponseState.unknown,
      this.data,
      this.message = '',
      this.validationCode = ValidationCode.empty});

  static BaseResponse<T> unknown<T>() {
    return const BaseResponse(state: ResponseState.unknown);
  }

  static BaseResponse<T> loading<T>({T? previousData}) {
    return BaseResponse(state: ResponseState.loading, data: previousData);
  }

  static BaseResponse<T> complete<T>(T data,
      {String message = '',
      ValidationCode validationCode = ValidationCode.empty}) {
    return BaseResponse(
        state: ResponseState.success,
        data: data,
        message: message,
        validationCode: validationCode);
  }

  static BaseResponse<T> error<T>(
      {String message = BaseResponse.errorMessage,
      ValidationCode? validationCode}) {
    return BaseResponse(
        state: ResponseState.error,
        message: message,
        validationCode: validationCode ?? ValidationCode.unknown);
  }

  static BaseResponse<T> suspended<T>(
      {String message = BaseResponse.errorMessage}) {
    return BaseResponse(state: ResponseState.suspended, message: message);
  }

  BaseResponse<T> copyWith(
      {ResponseState? state,
      T? data,
      String? message,
      ValidationCode? validationCode}) {
    return BaseResponse<T>(
        state: state ?? this.state,
        data: data ?? this.data,
        message: message ?? this.message,
        validationCode: validationCode ?? this.validationCode);
  }

  @override
  List<Object?> get props {
    return [state, data, message, validationCode];
  }
}
