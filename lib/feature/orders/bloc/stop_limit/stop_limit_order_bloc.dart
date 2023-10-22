import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/base_response.dart';
import '../../domain/order_request.dart';
import '../../repository/orders_repository.dart';
import '../../utils/orders_calculation.dart';
import '../order_bloc.dart';

part 'stop_limit_order_event.dart';
part 'stop_limit_order_state.dart';

class StopLimitOrderBloc
    extends Bloc<StopLimitOrderEvent, StopLimitOrderState> {
  final OrdersRepository _ordersRepository;

  StopLimitOrderBloc({
    required double marketPrice,
    required double availableBuyingPower,
    required double numberOfSellableShares,
    required OrdersRepository ordersRepository,
  })  : _ordersRepository = ordersRepository,
        super(StopLimitOrderState(
            availableBuyingPower: availableBuyingPower,
            availableAmountToSell: calculateAvailableAmountToSell(
                marketPrice, numberOfSellableShares),
            numberOfSellableShares: numberOfSellableShares)) {
    on<StopPriceOfStopLimitOrderChanged>(_onStopPriceChanged);
    on<LimitPriceOfStopLimitOrderChanged>(_onLimitPriceChanged);
    on<QuantityOfStopLimitOrderChanged>(_onQuantityChanged);
    on<StopLimitOrderSubmitted>(_onOrderSubmitted);
  }

  void _onStopPriceChanged(StopPriceOfStopLimitOrderChanged event,
      Emitter<StopLimitOrderState> emit) {
    emit(state.copyWith(
        stopPrice: event.stopPrice,
        estimateTotal:
            calculateEstimateTotal(event.stopPrice, state.quantity)));
  }

  void _onLimitPriceChanged(LimitPriceOfStopLimitOrderChanged event,
      Emitter<StopLimitOrderState> emit) {
    emit(state.copyWith(
        limitPrice: event.limitPrice,
        estimateTotal:
            calculateEstimateTotal(event.limitPrice, state.quantity)));
  }

  void _onQuantityChanged(QuantityOfStopLimitOrderChanged event,
      Emitter<StopLimitOrderState> emit) {
    emit(state.copyWith(
        estimateTotal: calculateEstimateTotal(state.limitPrice, event.quantity),
        quantity: event.quantity));
  }

  void _onOrderSubmitted(
      StopLimitOrderSubmitted event, Emitter<StopLimitOrderState> emit) async {
    emit(state.copyWith(response: BaseResponse.loading()));
    try {
      var data =
          await _ordersRepository.submitOrder(orderRequest: event.orderRequest);
      emit(state.copyWith(response: data));
    } catch (e) {
      emit(state.copyWith(response: BaseResponse.error()));
    }
  }
}
