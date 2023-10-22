part of 'bot_transaction_history_detail_bloc.dart';

abstract class BotTransactionHistoryDetailEvent extends Equatable {
  const BotTransactionHistoryDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchBotTransactionDetail extends BotTransactionHistoryDetailEvent {
  final String orderId;

  const FetchBotTransactionDetail(this.orderId);
}
