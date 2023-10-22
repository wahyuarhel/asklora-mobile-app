import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/data/remote/asklora_api_client.dart';
import '../../../../core/domain/endpoints.dart';
import '../../../feature/balance/deposit/domain/deposit_request.dart';
import '../../../feature/balance/withdrawal/domain/withdrawal_request.dart';

class TransactionApiClient {
  Future<Response> fetchBotTransactionHistory() async =>
      await AskloraApiClient().get(
        endpoint: endpointBotTransactionHistory,
      );

  Future<Response> fetchTransferTransactionHistory() async =>
      await AskloraApiClient().get(
        endpoint: endpointTransferTransactionHistory,
      );

  Future<Response> fetchBotTransactionDetail(String orderId) async =>
      await AskloraApiClient()
          .get(endpoint: '$endpointBotTransactionHistory/$orderId');

  Future<Response> fetchBalance() async =>
      await AskloraApiClient().get(endpoint: endpointBalance);

  Future<Response> fetchLedgerBalance() async =>
      await AskloraApiClient().get(endpoint: endpointLedgerBalance);

  Future<Response> submitDeposit(DepositRequest request) async =>
      await AskloraApiClient().post(
          endpoint: endpointProofOfRemittance,
          payload: jsonEncode(request.toJson()));

  Future<Response> submitWithdrawal(WithdrawalRequest request) async =>
      await AskloraApiClient().post(
        endpoint: endpointWithdrawal,
        payload: jsonEncode(request.toJson()),
      );
}
