import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/base_response.dart';
import '../domain/grouped_transaction_model.dart';
import '../../../core/repository/transaction_repository.dart';

part 'transaction_history_event.dart';

part 'transaction_history_state.dart';

class TransactionHistoryBloc
    extends Bloc<TransactionHistoryEvent, TransactionHistoryState> {
  TransactionHistoryBloc(
      {required TransactionRepository transactionHistoryRepository})
      : _transactionHistoryRepository = transactionHistoryRepository,
        super(const TransactionHistoryState()) {
    on<FetchAllTransaction>(_onFetchAllTransaction);
    on<FetchBotTransaction>(_onFetchBotTransaction);
    on<FetchTransferTransaction>(_onFetchTransferTransaction);
  }

  final TransactionRepository _transactionHistoryRepository;

  _onFetchAllTransaction(
      FetchAllTransaction event, Emitter<TransactionHistoryState> emit) async {
    emit(state.copyWith(allTransactionsResponse: BaseResponse.loading()));
    var transactionHistory =
        await _transactionHistoryRepository.fetchAllTransactionsHistory();
    emit(state.copyWith(
      allTransactionsResponse: transactionHistory,
    ));
  }

  _onFetchBotTransaction(
      FetchBotTransaction event, Emitter<TransactionHistoryState> emit) async {
    emit(state.copyWith(botTransactionsResponse: BaseResponse.loading()));
    var transactionHistory =
        await _transactionHistoryRepository.fetchBotTransactionsHistory();
    emit(state.copyWith(
      botTransactionsResponse: transactionHistory,
    ));
  }

  _onFetchTransferTransaction(FetchTransferTransaction event,
      Emitter<TransactionHistoryState> emit) async {
    emit(state.copyWith(transferTransactionsResponse: BaseResponse.loading()));
    var transactionHistory =
        await _transactionHistoryRepository.fetchTransferTransactionsHistory();
    emit(state.copyWith(
      transferTransactionsResponse: transactionHistory,
    ));
  }
}
