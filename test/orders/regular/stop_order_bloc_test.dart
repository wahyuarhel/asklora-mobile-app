import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/feature/orders/bloc/stop/stop_order_bloc.dart';
import 'package:asklora_mobile_app/feature/orders/domain/order_request.dart';
import 'package:asklora_mobile_app/feature/orders/domain/order_response.dart';
import 'package:asklora_mobile_app/feature/orders/repository/orders_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'market_bloc_test.mocks.dart';

@GenerateMocks([OrdersRepository])
void main() async {
  group('*Stop Order Bloc Test*', () {
    late StopOrderBloc stopBloc;
    late MockOrdersRepository mockOrdersRepository;
    double marketPrice = 100;

    setUpAll(() async {
      mockOrdersRepository = MockOrdersRepository();
    });

    setUp(() async {
      stopBloc = StopOrderBloc(
          marketPrice: marketPrice,
          availableBuyingPower: 1000,
          numberOfSellableShares: 20,
          ordersRepository: mockOrdersRepository);
    });

    test('Stop Order init state', () {
      expect(
          stopBloc.state,
          const StopOrderState(
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20,
          ));
    });

    blocTest<StopOrderBloc, StopOrderState>(
      'emits `estimateTotal = 0` and `stopPrice = 100` WHEN input stop price 100',
      build: () => stopBloc,
      act: (bloc) async => bloc.add(const StopPriceChanged(100)),
      expect: () => {
        const StopOrderState(
            stopPrice: 100,
            estimateTotal: 0,
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20)
      },
    );

    blocTest<StopOrderBloc, StopOrderState>(
      'emits `estimateTotal = 0` and `quantity = 10` WHEN input quantity 100',
      build: () => stopBloc,
      act: (bloc) => bloc.add(const StopQuantityChanged(10)),
      expect: () => {
        const StopOrderState(
            quantity: 10,
            estimateTotal: 0,
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
      },
    );

    blocTest<StopOrderBloc, StopOrderState>(
      'emits `estimateTotal = 1000` and `stop price = 100` `quantity = 10` WHEN input stop price 100 and quantity 10',
      build: () => stopBloc,
      act: (bloc) async {
        bloc.add(const StopPriceChanged(100));
        bloc.add(const StopQuantityChanged(10));
      },
      expect: () => {
        const StopOrderState(
            stopPrice: 100,
            estimateTotal: 0,
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
        const StopOrderState(
            stopPrice: 100,
            quantity: 10,
            estimateTotal: 1000,
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
      },
    );

    OrderRequest buyStopOrderRequest = OrderRequest.stop(
        symbolType: 'symbol',
        symbol: 'abc',
        side: 'buy',
        stopPrice: '100',
        quantity: '10');
    OrderRequest sellStopOrderRequest = OrderRequest.stop(
        symbolType: 'symbol',
        symbol: 'abc',
        side: 'sell',
        stopPrice: '100',
        quantity: '10');
    BaseResponse<OrderResponse> successResponse =
        BaseResponse.complete(OrderResponse());
    BaseResponse errorResponse = BaseResponse.error();

    blocTest<StopOrderBloc, StopOrderState>(
      'emits `response = BaseResponse.complete` WHEN `failed submit buy stop order`',
      build: () {
        when(mockOrdersRepository.submitOrder(
                orderRequest: buyStopOrderRequest))
            .thenThrow(BaseResponse.errorMessage);
        return stopBloc;
      },
      act: (bloc) async {
        bloc.add(StopOrderSubmitted(buyStopOrderRequest));
      },
      expect: () => {
        StopOrderState(
            response: BaseResponse.loading(),
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
        StopOrderState(
            response: errorResponse,
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
      },
    );
    blocTest<StopOrderBloc, StopOrderState>(
      'emits `response = BaseResponse.complete` WHEN `failed submit sell stop order`',
      build: () {
        when(mockOrdersRepository.submitOrder(
                orderRequest: sellStopOrderRequest))
            .thenThrow(BaseResponse.errorMessage);
        return stopBloc;
      },
      act: (bloc) async {
        bloc.add(StopOrderSubmitted(sellStopOrderRequest));
      },
      expect: () => {
        StopOrderState(
            response: BaseResponse.loading(),
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
        StopOrderState(
            response: errorResponse,
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
      },
    );
    blocTest<StopOrderBloc, StopOrderState>(
      'emits `response = BaseResponse.complete` WHEN `successfully submit buy stop order`',
      build: () {
        when(mockOrdersRepository.submitOrder(
                orderRequest: buyStopOrderRequest))
            .thenAnswer((_) async => Future.value(successResponse));
        return stopBloc;
      },
      act: (bloc) async {
        bloc.add(StopOrderSubmitted(buyStopOrderRequest));
      },
      expect: () => {
        StopOrderState(
            response: BaseResponse.loading(),
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
        StopOrderState(
            response: successResponse,
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
      },
    );
    blocTest<StopOrderBloc, StopOrderState>(
      'emits `response = BaseResponse.complete` WHEN `successfully submit sell stop order`',
      build: () {
        when(mockOrdersRepository.submitOrder(
                orderRequest: sellStopOrderRequest))
            .thenAnswer((_) async => Future.value(successResponse));
        return stopBloc;
      },
      act: (bloc) async {
        bloc.add(StopOrderSubmitted(sellStopOrderRequest));
      },
      expect: () => {
        StopOrderState(
            response: BaseResponse.loading(),
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
        StopOrderState(
            response: successResponse,
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
      },
    );
  });
}
