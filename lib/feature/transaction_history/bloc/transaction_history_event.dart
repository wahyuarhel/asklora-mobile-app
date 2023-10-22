part of 'transaction_history_bloc.dart';

abstract class TransactionHistoryEvent extends Equatable {
  const TransactionHistoryEvent();

  @override
  List<Object> get props => [];
}

class FetchAllTransaction extends TransactionHistoryEvent {}

class FetchBotTransaction extends TransactionHistoryEvent {}

class FetchTransferTransaction extends TransactionHistoryEvent {}

class FetchBalance extends TransactionHistoryEvent {}
