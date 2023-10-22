import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/feature/orders/bloc/trailing/trailing_order_bloc.dart';
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
  group('*Trailing Order Bloc Test*', () {
    late TrailingOrderBloc trailingOrderBloc;
    late MockOrdersRepository mockOrdersRepository;
    double marketPrice = 100;

    setUpAll(() async {
      mockOrdersRepository = MockOrdersRepository();
    });

    setUp(() async {
      trailingOrderBloc = TrailingOrderBloc(
        marketPrice: marketPrice,
        availableBuyingPower: 1000,
        numberOfSellableShares: 20,
        ordersRepository: mockOrdersRepository,
      );
    });

    test('Trailing Order init state', () {
      expect(
          trailingOrderBloc.state,
          const TrailingOrderState(
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20,
          ));
    });

    blocTest<TrailingOrderBloc, TrailingOrderState>(
      'emits `initial trailing price = 110` and `trail amount = 10` WHEN input amount 10',
      build: () => trailingOrderBloc,
      act: (bloc) async => bloc.add(const TrailingAmountChanged(10)),
      expect: () => {
        const TrailingOrderState(
            amount: 10,
            initialTrailingPrice: 110,
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20)
      },
    );
    blocTest<TrailingOrderBloc, TrailingOrderState>(
      'emits `initial trailing price = 110` and `estimated total = 990` WHEN `trail amount = 10` and `quantity = 9`',
      build: () => trailingOrderBloc,
      act: (bloc) async => {
        bloc.add(const TrailingAmountChanged(10)),
        bloc.add(const QuantityOfTrailingOrderChanged(9))
      },
      expect: () => {
        const TrailingOrderState(
          amount: 10,
          initialTrailingPrice: 110,
          availableBuyingPower: 1000,
          availableAmountToSell: 2000,
          numberOfSellableShares: 20,
        ),
        const TrailingOrderState(
          amount: 10,
          quantity: 9,
          initialTrailingPrice: 110,
          estimateTotal: 990,
          availableBuyingPower: 1000,
          availableAmountToSell: 2000,
          numberOfSellableShares: 20,
        ),
      },
    );

    blocTest<TrailingOrderBloc, TrailingOrderState>(
      'emits `initial trailing price = 110` and `trail percentage = 10` WHEN input percentage 10',
      build: () => trailingOrderBloc,
      act: (bloc) => bloc.add(const TrailingPercentageChanged(10)),
      expect: () => {
        const TrailingOrderState(
            percentage: 10,
            initialTrailingPrice: 110,
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20)
      },
    );
    blocTest<TrailingOrderBloc, TrailingOrderState>(
      'emits `initial trailing price = 110` and `estimated total = 990` WHEN input `trail percentage = 10` and `quantity = 9`',
      build: () => trailingOrderBloc,
      act: (bloc) => {
        bloc.add(const TrailingPercentageChanged(10)),
        bloc.add(const QuantityOfTrailingOrderChanged(9)),
      },
      expect: () => {
        const TrailingOrderState(
            percentage: 10,
            initialTrailingPrice: 110,
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
        const TrailingOrderState(
            percentage: 10,
            quantity: 9,
            initialTrailingPrice: 110,
            estimateTotal: 990,
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
      },
    );

    OrderRequest requestBuyTrailStopOrderByAmount =
        OrderRequest.trailingStopAmount(
      symbolType: 'symbol',
      symbol: 'abc',
      side: 'buy',
      trailPrice: '10',
      quantity: '10',
    );
    OrderRequest requestBuyTrailStopOrderByPercentage =
        OrderRequest.trailingStopAmount(
      symbolType: 'symbol',
      symbol: 'abc',
      side: 'buy',
      trailPrice: '10',
      quantity: '10',
    );
    OrderRequest requestSellTrailStopOrderByAmount =
        OrderRequest.trailingStopAmount(
      symbolType: 'symbol',
      symbol: 'abc',
      side: 'sell',
      trailPrice: '10',
      quantity: '10',
    );
    OrderRequest requestSellTrailStopOrderByPercentage =
        OrderRequest.trailingStopAmount(
      symbolType: 'symbol',
      symbol: 'abc',
      side: 'sell',
      trailPrice: '10',
      quantity: '10',
    );
    BaseResponse<OrderResponse> successResponse =
        BaseResponse.complete(OrderResponse());
    BaseResponse errorResponse = BaseResponse.error();

    blocTest<TrailingOrderBloc, TrailingOrderState>(
      'emits response = BaseResponse.complete WHEN failed submit buy trail stop order by trail amount',
      build: () {
        when(mockOrdersRepository.submitOrder(
                orderRequest: requestBuyTrailStopOrderByAmount))
            .thenThrow(BaseResponse.errorMessage);
        return trailingOrderBloc;
      },
      act: (bloc) async {
        bloc.add(TrailingOrderSubmitted(requestBuyTrailStopOrderByAmount));
      },
      expect: () => {
        TrailingOrderState(
            response: BaseResponse.loading(),
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
        TrailingOrderState(
            response: errorResponse,
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
      },
    );
    blocTest<TrailingOrderBloc, TrailingOrderState>(
      'emits response = BaseResponse.complete WHEN failed submit buy trail stop order by trail percentage',
      build: () {
        when(mockOrdersRepository.submitOrder(
                orderRequest: requestBuyTrailStopOrderByPercentage))
            .thenThrow(BaseResponse.errorMessage);
        return trailingOrderBloc;
      },
      act: (bloc) async {
        bloc.add(TrailingOrderSubmitted(requestBuyTrailStopOrderByAmount));
      },
      expect: () => {
        TrailingOrderState(
            response: BaseResponse.loading(),
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
        TrailingOrderState(
            response: errorResponse,
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
      },
    );
    blocTest<TrailingOrderBloc, TrailingOrderState>(
      'emits response = BaseResponse.complete WHEN failed submit sell trail stop order by trail amount',
      build: () {
        when(mockOrdersRepository.submitOrder(
                orderRequest: requestSellTrailStopOrderByAmount))
            .thenThrow('Something went wrong, please try again later');
        return trailingOrderBloc;
      },
      act: (bloc) async {
        bloc.add(TrailingOrderSubmitted(requestSellTrailStopOrderByAmount));
      },
      expect: () => {
        TrailingOrderState(
            response: BaseResponse.loading(),
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
        TrailingOrderState(
            response: errorResponse,
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
      },
    );
    blocTest<TrailingOrderBloc, TrailingOrderState>(
      'emits response = BaseResponse.complete WHEN failed submit sell trail stop order by trail percentage',
      build: () {
        when(mockOrdersRepository.submitOrder(
                orderRequest: requestSellTrailStopOrderByPercentage))
            .thenThrow('Something went wrong, please try again later');
        return trailingOrderBloc;
      },
      act: (bloc) async {
        bloc.add(TrailingOrderSubmitted(requestSellTrailStopOrderByPercentage));
      },
      expect: () => {
        TrailingOrderState(
            response: BaseResponse.loading(),
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
        TrailingOrderState(
            response: errorResponse,
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
      },
    );
    blocTest<TrailingOrderBloc, TrailingOrderState>(
      'emits response = BaseResponse.complete WHEN successfully submit buy trail stop order by trail amount',
      build: () {
        when(mockOrdersRepository.submitOrder(
                orderRequest: requestBuyTrailStopOrderByAmount))
            .thenAnswer((_) async => Future.value(successResponse));
        return trailingOrderBloc;
      },
      act: (bloc) async {
        bloc.add(TrailingOrderSubmitted(requestBuyTrailStopOrderByAmount));
      },
      expect: () => {
        TrailingOrderState(
            response: BaseResponse.loading(),
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
        TrailingOrderState(
            response: successResponse,
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
      },
    );
    blocTest<TrailingOrderBloc, TrailingOrderState>(
      'emits response = BaseResponse.complete WHEN successfully submit buy trail stop order by trail percentage',
      build: () {
        when(mockOrdersRepository.submitOrder(
                orderRequest: requestBuyTrailStopOrderByPercentage))
            .thenAnswer((_) async => Future.value(successResponse));
        return trailingOrderBloc;
      },
      act: (bloc) async {
        bloc.add(TrailingOrderSubmitted(requestBuyTrailStopOrderByPercentage));
      },
      expect: () => {
        TrailingOrderState(
            response: BaseResponse.loading(),
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
        TrailingOrderState(
            response: successResponse,
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
      },
    );
    blocTest<TrailingOrderBloc, TrailingOrderState>(
      'emits response = BaseResponse.complete WHEN successfully submit sell trail stop order by trail amount',
      build: () {
        when(mockOrdersRepository.submitOrder(
                orderRequest: requestSellTrailStopOrderByAmount))
            .thenAnswer((_) async => Future.value(successResponse));
        return trailingOrderBloc;
      },
      act: (bloc) async {
        bloc.add(TrailingOrderSubmitted(requestSellTrailStopOrderByAmount));
      },
      expect: () => {
        TrailingOrderState(
            response: BaseResponse.loading(),
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
        TrailingOrderState(
            response: successResponse,
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
      },
    );
    blocTest<TrailingOrderBloc, TrailingOrderState>(
      'emits response = BaseResponse.complete WHEN successfully submit sell trail stop order by trail percentage',
      build: () {
        when(mockOrdersRepository.submitOrder(
                orderRequest: requestSellTrailStopOrderByPercentage))
            .thenAnswer((_) async => Future.value(successResponse));
        return trailingOrderBloc;
      },
      act: (bloc) async {
        bloc.add(TrailingOrderSubmitted(requestSellTrailStopOrderByPercentage));
      },
      expect: () => {
        TrailingOrderState(
            response: BaseResponse.loading(),
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
        TrailingOrderState(
            response: successResponse,
            availableBuyingPower: 1000,
            availableAmountToSell: 2000,
            numberOfSellableShares: 20),
      },
    );
  });
}
