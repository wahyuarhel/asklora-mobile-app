import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/feature/orders/bloc/stop_limit/stop_limit_order_bloc.dart';
import 'package:asklora_mobile_app/feature/orders/domain/order_request.dart';
import 'package:asklora_mobile_app/feature/orders/domain/order_response.dart';
import 'package:asklora_mobile_app/feature/orders/repository/orders_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'market_bloc_test.mocks.dart';

@GenerateMocks([OrdersRepository])
void main() {
  group('*Stop Limit Order Bloc Test*', () {
    late StopLimitOrderBloc stopLimitOrderBloc;
    late MockOrdersRepository mockOrdersRepository;
    double marketPrice = 100;

    setUpAll(() async {
      mockOrdersRepository = MockOrdersRepository();
    });

    setUp(() async {
      stopLimitOrderBloc = StopLimitOrderBloc(
          marketPrice: marketPrice,
          availableBuyingPower: 1000,
          numberOfSellableShares: 20,
          ordersRepository: mockOrdersRepository);
    });

    test('Stop Limit Order init state', () {
      expect(
          stopLimitOrderBloc.state,
          const StopLimitOrderState(
              availableBuyingPower: 1000,
              availableAmountToSell: 2000,
              numberOfSellableShares: 20));
    });

    blocTest<StopLimitOrderBloc, StopLimitOrderState>(
        'emits `estimateTotal = 0` and `Stop Price = 100` WHEN input Stop Price 100',
        build: () => stopLimitOrderBloc,
        act: (bloc) async =>
            bloc.add(const StopPriceOfStopLimitOrderChanged(100)),
        expect: () => {
              const StopLimitOrderState(
                  stopPrice: 100,
                  estimateTotal: 0,
                  availableBuyingPower: 1000,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
            });
    blocTest<StopLimitOrderBloc, StopLimitOrderState>(
        'emits `estimateTotal = 0` and `limit price = 100` WHEN input limit Price 100',
        build: () => stopLimitOrderBloc,
        act: (bloc) async =>
            bloc.add(const LimitPriceOfStopLimitOrderChanged(110)),
        expect: () => {
              const StopLimitOrderState(
                  limitPrice: 110,
                  estimateTotal: 0,
                  availableBuyingPower: 1000,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
            });
    blocTest<StopLimitOrderBloc, StopLimitOrderState>(
        'emits `estimateTotal = 0` and `quantity = 10` WHEN input Quantity 100',
        build: () => stopLimitOrderBloc,
        act: (bloc) async =>
            bloc.add(const QuantityOfStopLimitOrderChanged(10)),
        expect: () => {
              const StopLimitOrderState(
                  quantity: 10,
                  estimateTotal: 0,
                  availableBuyingPower: 1000,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
            });
    blocTest<StopLimitOrderBloc, StopLimitOrderState>(
        'emits `estimateTotal = 1000` and `stop price = 99` `limit price = 100` WHEN input stop price = 99 , limit price = 100 and quantity = 10',
        build: () => stopLimitOrderBloc,
        act: (bloc) async {
          bloc.add(const StopPriceOfStopLimitOrderChanged(99));
          bloc.add(const LimitPriceOfStopLimitOrderChanged(100));
          bloc.add(const QuantityOfStopLimitOrderChanged(10));
        },
        expect: () => {
              const StopLimitOrderState(
                  stopPrice: 99,
                  estimateTotal: 0,
                  availableBuyingPower: 1000,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
              const StopLimitOrderState(
                  stopPrice: 99,
                  limitPrice: 100,
                  estimateTotal: 0,
                  availableBuyingPower: 1000,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
              const StopLimitOrderState(
                  stopPrice: 99,
                  limitPrice: 100,
                  quantity: 10,
                  estimateTotal: 1000,
                  availableBuyingPower: 1000,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
            });

    OrderRequest requestBuyStopLimitOrder = OrderRequest.stopLimit(
        symbolType: 'symbol',
        symbol: 'abc',
        side: 'buy',
        stopPrice: '99',
        limitPrice: '100',
        quantity: '10');
    OrderRequest requestSellStopLimitOrder = OrderRequest.stopLimit(
        symbolType: 'symbol',
        symbol: 'abc',
        side: 'sell',
        stopPrice: '99',
        limitPrice: '100',
        quantity: '10');
    BaseResponse<OrderResponse> successResponse =
        BaseResponse.complete(OrderResponse());
    BaseResponse errorResponse = BaseResponse.error();

    blocTest<StopLimitOrderBloc, StopLimitOrderState>(
      'emits `response = BaseResponse.complete` WHEN `failed submit buy stop limit order`',
      build: () {
        when(mockOrdersRepository.submitOrder(
                orderRequest: requestBuyStopLimitOrder))
            .thenThrow(BaseResponse.errorMessage);
        return stopLimitOrderBloc;
      },
      act: (bloc) async {
        bloc.add(StopLimitOrderSubmitted(requestBuyStopLimitOrder));
      },
      expect: () => {
        StopLimitOrderState(
            response: BaseResponse.loading(),
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
        StopLimitOrderState(
            response: errorResponse,
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20)
      },
    );
    blocTest<StopLimitOrderBloc, StopLimitOrderState>(
      'emits `response = BaseResponse.complete` WHEN `failed submit sell stop limit order`',
      build: () {
        when(mockOrdersRepository.submitOrder(
                orderRequest: requestSellStopLimitOrder))
            .thenThrow(BaseResponse.errorMessage);
        return stopLimitOrderBloc;
      },
      act: (bloc) async {
        bloc.add(StopLimitOrderSubmitted(requestSellStopLimitOrder));
      },
      expect: () => {
        StopLimitOrderState(
            response: BaseResponse.loading(),
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
        StopLimitOrderState(
            response: errorResponse,
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20)
      },
    );
    blocTest<StopLimitOrderBloc, StopLimitOrderState>(
      'emits `response = BaseResponse.complete` WHEN `success submit buy stop limit order`',
      build: () {
        when(mockOrdersRepository.submitOrder(
                orderRequest: requestBuyStopLimitOrder))
            .thenAnswer((_) async => Future.value(successResponse));
        return stopLimitOrderBloc;
      },
      act: (bloc) async {
        bloc.add(StopLimitOrderSubmitted(requestBuyStopLimitOrder));
      },
      expect: () => {
        StopLimitOrderState(
            response: BaseResponse.loading(),
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
        StopLimitOrderState(
            response: successResponse,
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20)
      },
    );
    blocTest<StopLimitOrderBloc, StopLimitOrderState>(
      'emits `response = BaseResponse.complete` WHEN `success submit sell stop limit order`',
      build: () {
        when(mockOrdersRepository.submitOrder(
                orderRequest: requestSellStopLimitOrder))
            .thenAnswer((_) async => Future.value(successResponse));
        return stopLimitOrderBloc;
      },
      act: (bloc) async {
        bloc.add(StopLimitOrderSubmitted(requestSellStopLimitOrder));
      },
      expect: () => {
        StopLimitOrderState(
            response: BaseResponse.loading(),
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
        StopLimitOrderState(
            response: successResponse,
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20)
      },
    );
  });
}
