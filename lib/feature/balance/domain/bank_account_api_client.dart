import 'package:dio/dio.dart';

import '../../../core/data/remote/asklora_api_client.dart';
import '../../../core/domain/endpoints.dart';

class BankAccountApiClient {
  Future<Response> getBankAccount() async =>
      await AskloraApiClient().get(endpoint: endpointBankAccount);
}
