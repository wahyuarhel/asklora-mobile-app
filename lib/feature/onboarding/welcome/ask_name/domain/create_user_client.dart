import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../core/data/remote/ppi_api_client.dart';
import '../../../../../core/domain/endpoints.dart';
import 'add_user_request.dart';

class CreateUserClient {
  Future<Response> addUser(AddUserRequest request) async => await PpiApiClient()
      .post(endpoint: endpointGetUser, payload: json.encode(request.toJson()));
}
