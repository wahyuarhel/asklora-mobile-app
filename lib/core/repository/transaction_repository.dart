import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

import '../../feature/balance/deposit/domain/deposit_request.dart';
import '../../feature/balance/deposit/domain/deposit_response.dart';
import '../../feature/balance/withdrawal/domain/withdrawal_request.dart';
import '../../feature/balance/withdrawal/domain/withdrawal_response.dart';
import '../../feature/transaction_history/utils/transaction_history_util.dart';
import '../domain/base_response.dart';
import '../domain/transaction/transaction_ledger_balance_response.dart';
import '../utils/date_utils.dart';
import '../../feature/transaction_history/bot_order/detail/domain/bot_detail_transaction_history_response.dart';
import '../../feature/transaction_history/domain/grouped_model.dart';
import '../../feature/transaction_history/domain/grouped_transaction_model.dart';
import '../domain/transaction/transaction_balance_response.dart';
import '../domain/transaction/transaction_api_client.dart';
import '../../feature/transaction_history/domain/transaction_history_model.dart';

class TransactionRepository {
  final TransactionApiClient _transactionApiClient = TransactionApiClient();

  Future<BaseResponse<List<GroupedTransactionModel>>>
      fetchAllTransactionsHistory() async {
    try {
      var botTransactionHistory =
          await _transactionApiClient.fetchBotTransactionHistory();
      var transferTransactionHistory =
          await _transactionApiClient.fetchTransferTransactionHistory();

      return BaseResponse.complete(_groupedTransactionModels([
        ...List.from(botTransactionHistory.data
            .map((element) => TransactionHistoryModel.fromJson(element))),
        ...List.from(transferTransactionHistory.data
            .map((element) => TransactionHistoryModel.fromJson(element)))
      ]..sort((a, b) => compareDateTimeDesc(
          a.createdDateTimeFormat, b.createdDateTimeFormat))));
    } catch (e) {
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<List<GroupedTransactionModel>>>
      fetchBotTransactionsHistory() async {
    try {
      var response = await _transactionApiClient.fetchBotTransactionHistory();

      return BaseResponse.complete(_groupedTransactionModels(List.from(response
          .data
          .map((element) => TransactionHistoryModel.fromJson(element)))));
    } catch (e) {
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<List<GroupedTransactionModel>>>
      fetchTransferTransactionsHistory() async {
    try {
      var response =
          await _transactionApiClient.fetchTransferTransactionHistory();

      return BaseResponse.complete(_groupedTransactionModels(List.from(response
          .data
          .map((element) => TransactionHistoryModel.fromJson(element)))));
    } catch (e) {
      return BaseResponse.error();
    }
  }

  List<GroupedTransactionModel> _groupedTransactionModels(
      List<TransactionHistoryModel> transactions) {
    List<GroupedTransactionModel> groupedTransactions = [];
    DateTime dateTimeNow = DateTime.now();
    DateTime dateNow =
        DateTime(dateTimeNow.year, dateTimeNow.month, dateTimeNow.day);
    for (var element in transactions) {
      DateTime createdAt =
          formatDateOnly(formatDateTimeToLocal(element.created));
      if (createdAt.compareTo(dateNow) == 0) {
        int groupIndex = groupedTransactions
            .indexWhere((element) => element.groupType == GroupType.today);
        if (groupIndex >= 0) {
          ///ADD EXISTING GROUP TODAY
          groupedTransactions[groupIndex] = groupedTransactions[groupIndex]
              .copyWith(
                  data: List.from(groupedTransactions[groupIndex].data)
                    ..add(element));
        } else {
          ///CREATE NEW GROUP TODAY
          groupedTransactions.add(GroupedTransactionModel(
              groupType: GroupType.today, groupTitle: '', data: [element]));
        }
      } else {
        ///CREATE OTHER GROUP EACH DATE
        String createdAtFormatted = formatDateTimeAsString(createdAt);
        int groupIndex = groupedTransactions
            .indexWhere((element) => element.groupTitle == createdAtFormatted);
        if (groupIndex >= 0) {
          ///ADD EXISTING GROUP
          groupedTransactions[groupIndex] = groupedTransactions[groupIndex]
              .copyWith(
                  data: List.from(groupedTransactions[groupIndex].data)
                    ..add(element));
        } else {
          ///CREATE NEW GROUP
          groupedTransactions.add(GroupedTransactionModel(
              groupType: GroupType.others,
              groupTitle: createdAtFormatted,
              data: [element]));
        }
      }
    }
    return groupedTransactions;
  }

  Future<BaseResponse<BotDetailTransactionHistoryResponse>>
      fetchBotTransactionsDetail(String orderId) async {
    try {
      var botOrderTransactionHistoryResponse =
          await _transactionApiClient.fetchBotTransactionDetail(orderId);
      BotDetailTransactionHistoryResponse botDetailTransactionHistoryResponse =
          BotDetailTransactionHistoryResponse.fromJson(
              botOrderTransactionHistoryResponse.data);

      return BaseResponse.complete(botDetailTransactionHistoryResponse);
    } catch (e) {
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<TransactionBalanceResponse>> fetchBalance() async {
    try {
      var response = await _transactionApiClient.fetchBalance();
      return BaseResponse.complete(
          TransactionBalanceResponse.fromJson(response.data));
    } catch (e) {
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<TransactionLedgerBalanceResponse>>
      fetchLedgerBalance() async {
    try {
      var response = await _transactionApiClient.fetchLedgerBalance();
      return BaseResponse.complete(
          TransactionLedgerBalanceResponse.fromJson(response.data));
    } catch (e) {
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<DepositResponse>> submitDeposit({
    required double depositAmount,
    required List<PlatformFile> platformFiles,
  }) async {
    List<ProofFile> proofFiles = [];
    for (var element in platformFiles) {
      final bytes = File(element.path!).readAsBytesSync();
      proofFiles.add(ProofFile('data:image/png;base64,${base64Encode(bytes)}'));
    }
    var response = await _transactionApiClient
        .submitDeposit(DepositRequest(depositAmount, proofFiles));

    return BaseResponse.complete(DepositResponse.fromJson(response.data));
  }

  Future<BaseResponse<WithdrawalResponse>> submitWithdrawal({
    required WithdrawalRequest withdrawalRequest,
  }) async {
    var response =
        await _transactionApiClient.submitWithdrawal(withdrawalRequest);
    return BaseResponse.complete(WithdrawalResponse.fromJson(response.data));
  }
}
