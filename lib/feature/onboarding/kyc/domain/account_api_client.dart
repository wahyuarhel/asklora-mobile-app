import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/data/remote/asklora_api_client.dart';
import '../../../../core/domain/endpoints.dart';
import 'onfido/onfido_result_request.dart';
import 'upgrade_account/personal_info_request.dart';
import 'upgrade_account/upgrade_account_request.dart';

class AccountApiClient {
  static AccountApiClient? _instance;

  factory AccountApiClient() => _instance ??= AccountApiClient._();

  AccountApiClient._();

  Future<Response> getAccount() async =>
      await AskloraApiClient().get(endpoint: endpointGetAccount);

  Future<Response> submitIBKR(UpgradeAccountRequest request) async =>
      await AskloraApiClient().post(
          endpoint: endpointUpgradeAccount,
          payload: jsonEncode(request.toJson()));

  Future<Response> submitPersonalInfo(PersonalInfoRequest request) async =>
      await AskloraApiClient().patch(
          endpoint: endpointPersonalInfo,
          payload: jsonEncode(request.toJson()));

  Future<Response> getOnfidoToken() async =>
      await AskloraApiClient().get(endpoint: endpointGetOnfidoToken);

  Future<Response> submitOnfidoOutcome(OnfidoResultRequest request) async =>
      await AskloraApiClient().post(
          endpoint: endpointOnfidoOutcome,
          payload: jsonEncode(request.toJson()));
}
