import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/domain/endpoints.dart';
import '../../data/remote/asklora_api_client.dart';
import 'model/token_refresh_request.dart';
import 'model/token_verify_request.dart';

class TokenApiClient {
  Future<Response> verify(TokenVerifyRequest request) async {
    var response = await AskloraApiClient().post(
        endpoint: endpointTokenVerify, payload: jsonEncode(request.toJson()));
    return response;
  }

  Future<Response> refresh(TokenRefreshRequest request) async {
    var response = await AskloraApiClient().post(
        endpoint: endpointTokenRefresh, payload: jsonEncode(request.toJson()));
    return response;
  }
}
