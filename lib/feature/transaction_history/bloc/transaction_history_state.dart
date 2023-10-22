part of 'transaction_history_bloc.dart';

class TransactionHistoryState extends Equatable {
  const TransactionHistoryState({
    this.allTransactionsResponse = const BaseResponse(),
    this.botTransactionsResponse = const BaseResponse(),
    this.transferTransactionsResponse = const BaseResponse(),
  });

  final BaseResponse<List<GroupedTransactionModel>> allTransactionsResponse;
  final BaseResponse<List<GroupedTransactionModel>> botTransactionsResponse;
  final BaseResponse<List<GroupedTransactionModel>>
      transferTransactionsResponse;

  @override
  List<Object?> get props {
    return [
      allTransactionsResponse,
      botTransactionsResponse,
      transferTransactionsResponse,
    ];
  }

  TransactionHistoryState copyWith(
      {BaseResponse<List<GroupedTransactionModel>>? allTransactionsResponse,
      BaseResponse<List<GroupedTransactionModel>>? botTransactionsResponse,
      BaseResponse<List<GroupedTransactionModel>>?
          transferTransactionsResponse}) {
    return TransactionHistoryState(
        allTransactionsResponse:
            allTransactionsResponse ?? this.allTransactionsResponse,
        botTransactionsResponse:
            botTransactionsResponse ?? this.botTransactionsResponse,
        transferTransactionsResponse:
            transferTransactionsResponse ?? this.transferTransactionsResponse);
  }
}
