part of 'portfolio_bloc.dart';

abstract class PortfolioEvent extends Equatable {
  const PortfolioEvent();

  @override
  List<Object> get props => [];
}

class FetchBalance extends PortfolioEvent {}

class ActiveFilterChecked extends PortfolioEvent {
  final bool isChecked;

  const ActiveFilterChecked(this.isChecked);
}

class PendingFilterChecked extends PortfolioEvent {
  final bool isChecked;

  const PendingFilterChecked(this.isChecked);
}

class FetchActiveOrders extends PortfolioEvent {
  final BotStockFilter botStockFilter;

  const FetchActiveOrders({this.botStockFilter = BotStockFilter.all});
}

class FetchActiveOrderDetail extends PortfolioEvent {
  final String botOrderId;

  const FetchActiveOrderDetail({required this.botOrderId});
}

class CurrencyChanged extends PortfolioEvent {
  final CurrencyType currencyType;

  const CurrencyChanged(this.currencyType) : super();

  @override
  List<Object> get props => [currencyType];
}

class RolloverBotStock extends PortfolioEvent {
  final String botOrderId;

  const RolloverBotStock(this.botOrderId);

  @override
  List<Object> get props => [botOrderId];
}

class EndBotStock extends PortfolioEvent {
  final String botOrderId;

  const EndBotStock(this.botOrderId);

  @override
  List<Object> get props => [botOrderId];
}

class CancelBotStock extends PortfolioEvent {
  final String botOrderId;

  const CancelBotStock(this.botOrderId);

  @override
  List<Object> get props => [botOrderId];
}
