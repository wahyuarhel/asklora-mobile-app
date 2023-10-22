import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const OrderState()) {
    on<TransactionTypeChanged>(_onTransactionTypeChanged);
    on<OrderTypeChanged>(_onOrderTypeChanged);
    on<TrailTypeChanged>(_onTrailTypeChanged);
    on<TimeInForceChanged>(_onTimeInForceChanged);
    on<TradingHoursChanged>(_onTradingHoursChanged);
    on<MarketTypeChanged>(_onMarketTypeChanged);
  }

  void _onTransactionTypeChanged(
      TransactionTypeChanged event, Emitter<OrderState> emit) {
    emit(state.copyWith(transactionType: event.transactionType));
  }

  void _onOrderTypeChanged(OrderTypeChanged event, Emitter<OrderState> emit) {
    OrderState initialOrderState = const OrderState();
    emit(state.copyWith(
        orderType: event.orderType,
        trailType: initialOrderState.trailType,
        timeInForce: initialOrderState.timeInForce,
        tradingHours: initialOrderState.tradingHours));
  }

  void _onTrailTypeChanged(TrailTypeChanged event, Emitter<OrderState> emit) {
    emit(state.copyWith(trailType: event.trailType));
  }

  void _onTimeInForceChanged(
      TimeInForceChanged event, Emitter<OrderState> emit) {
    emit(state.copyWith(timeInForce: event.timeInForce));
  }

  void _onTradingHoursChanged(
      TradingHoursChanged event, Emitter<OrderState> emit) {
    emit(state.copyWith(tradingHours: event.tradingHours));
  }

  void _onMarketTypeChanged(MarketTypeChanged event, Emitter<OrderState> emit) {
    emit(state.copyWith(marketType: event.marketType));
  }
}
