import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/base_response.dart';
import '../../domain/order_request.dart';
import '../../repository/orders_repository.dart';
import '../../utils/orders_calculation.dart';

part 'market_event.dart';

part 'market_state.dart';

class MarketBloc extends Bloc<MarketEvent, MarketState> {
  MarketBloc(
      {required double marketPrice,
      required double availableBuyingPower,
      required double numberOfSellableShares,
      required OrdersRepository ordersRepository})
      : _marketPrice = marketPrice,
        _availableBuyingPower = availableBuyingPower,
        _numberOfSellableShares = numberOfSellableShares,
        _ordersRepository = ordersRepository,
        super(MarketState(
            availableBuyingPower: availableBuyingPower,
            numberOfBuyableShares: calculateNumberOfBuyableShares(
                marketPrice, availableBuyingPower),
            numberOfSellableShares: numberOfSellableShares,
            availableAmountToSell: calculateAvailableAmountToSell(
                marketPrice, numberOfSellableShares))) {
    on<AmountChanged>(_onAmountChanged);
    on<SharesAmountChanged>(_onSharesAmountChanged);
    on<SharesAmountIncremented>(_onSharesAmountIncremented);
    on<SharesAmountDecremented>(_onSharesAmountDecremented);
    on<OrderSubmitted>(_onOrderSubmitted);
    on<ResetMarketValue>(_onResetMarketValue);
  }

  final OrdersRepository _ordersRepository;

  final double _marketPrice;
  final double _availableBuyingPower;
  final double _numberOfSellableShares;

  void _onAmountChanged(AmountChanged event, Emitter<MarketState> emit) {
    double sharesAmount = calculateAmount(_marketPrice, event.amount);
    emit(state.copyWith(
        amount: event.amount,
        estimateTotal: event.amount,
        sharesAmount: sharesAmount));
  }

  void _onResetMarketValue(ResetMarketValue event, Emitter<MarketState> emit) {
    emit(MarketState(
        availableBuyingPower: _availableBuyingPower,
        numberOfBuyableShares:
            calculateNumberOfBuyableShares(_marketPrice, _availableBuyingPower),
        numberOfSellableShares: _numberOfSellableShares,
        availableAmountToSell: calculateAvailableAmountToSell(
            _marketPrice, _numberOfSellableShares)));
  }

  void _onSharesAmountChanged(
      SharesAmountChanged event, Emitter<MarketState> emit) {
    if (!event.sharesAmount.isNegative) {
      double estimateTotal =
          calculateEstimateTotal(_marketPrice, event.sharesAmount);
      emit(state.copyWith(
          amount: estimateTotal,
          estimateTotal: estimateTotal,
          sharesAmount: event.sharesAmount));
    }
  }

  void _onSharesAmountIncremented(
      SharesAmountIncremented event, Emitter<MarketState> emit) {
    double sharesAmount = incrementSharesAmount(state.sharesAmount);
    double estimateTotal = calculateEstimateTotal(_marketPrice, sharesAmount);
    emit(state.copyWith(
        amount: estimateTotal,
        estimateTotal: estimateTotal,
        sharesAmount: sharesAmount));
  }

  void _onSharesAmountDecremented(
      SharesAmountDecremented event, Emitter<MarketState> emit) {
    if (state.sharesAmount != 0) {
      double sharesAmount = decrementSharesAmount(state.sharesAmount);
      double estimateTotal = calculateEstimateTotal(_marketPrice, sharesAmount);
      emit(state.copyWith(
          amount: estimateTotal,
          estimateTotal: estimateTotal,
          sharesAmount: sharesAmount));
    }
  }

  void _onOrderSubmitted(
      OrderSubmitted event, Emitter<MarketState> emit) async {
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
