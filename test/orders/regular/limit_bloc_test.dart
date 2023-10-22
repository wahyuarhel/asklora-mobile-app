import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/feature/orders/bloc/limit/limit_order_bloc.dart';
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
  group('Limit Bloc Tests', () {
    late LimitOrderBloc limitBloc;
    late MockOrdersRepository mockOrdersRepository;
    double marketPrice = 100;

    setUpAll(() async {
      mockOrdersRepository = MockOrdersRepository();
    });

    setUp(() async {
      limitBloc = LimitOrderBloc(
          marketPrice: marketPrice,
          availableBuyingPower: 1000,
          ordersRepository: mockOrdersRepository,
          numberOfSellableShares: 20);
    });

    test('Limit Bloc init state', () {
      expect(
          limitBloc.state,
          const LimitOrderState(
              availableBuyingPower: 1000,
              availableAmountToSell: 2000,
              numberOfSellableShares: 20));
    });

    blocTest<LimitOrderBloc, LimitOrderState>(
        'emits `estimateTotal` = 0 and `limit` = 100 WHEN '
        'input limit 100',
        build: () => limitBloc,
        act: (bloc) async => bloc.add(const LimitChanged(100)),
        expect: () => {
              const LimitOrderState(
                  limit: 100,
                  estimateTotal: 0,
                  availableBuyingPower: 1000,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
            });

    blocTest<LimitOrderBloc, LimitOrderState>(
        'emits `estimateTotal` = 0 and `quantity` = 10 WHEN '
        'input quantity 10',
        build: () => limitBloc,
        act: (bloc) async => bloc.add(const QuantityChanged(10)),
        expect: () => {
              const LimitOrderState(
                  quantity: 10,
                  estimateTotal: 0,
                  availableBuyingPower: 1000,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
            });

    blocTest<LimitOrderBloc, LimitOrderState>(
        'emits `estimateTotal` = 1000, `limit` = 100 and `quantity` = 10 WHEN '
        'input limit 100 and quantity 10',
        build: () => limitBloc,
        act: (bloc) async {
          bloc.add(const LimitChanged(100));
          bloc.add(const QuantityChanged(10));
        },
        expect: () => {
              const LimitOrderState(
                  limit: 100,
                  estimateTotal: 0,
                  availableBuyingPower: 1000,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
              const LimitOrderState(
                  limit: 100,
                  quantity: 10,
                  estimateTotal: 1000,
                  availableBuyingPower: 1000,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
            });

    OrderRequest buyLimitRequest = OrderRequest.limit(
        symbolType: 'symbol',
        symbol: 'abc',
        side: 'buy',
        limitPrice: '100',
        quantity: '10');
    OrderRequest sellLimitRequest = OrderRequest.limit(
        symbolType: 'symbol',
        symbol: 'abc',
        side: 'sell',
        limitPrice: '100',
        quantity: '10');
    BaseResponse<OrderResponse> successResponse =
        BaseResponse.complete(OrderResponse());
    BaseResponse errorResponse = BaseResponse.error();

    blocTest<LimitOrderBloc, LimitOrderState>(
        'emits `response` = BaseResponse.complete WHEN '
        'failed submit buy limit order',
        build: () {
          when(mockOrdersRepository.submitOrder(orderRequest: buyLimitRequest))
              .thenThrow(BaseResponse.errorMessage);
          return limitBloc;
        },
        act: (bloc) async {
          bloc.add(OrderSubmitted(buyLimitRequest));
        },
        expect: () => {
              LimitOrderState(
                  response: BaseResponse.loading(),
                  availableBuyingPower: 1000,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
              LimitOrderState(
                  response: errorResponse,
                  availableBuyingPower: 1000,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
            });

    blocTest<LimitOrderBloc, LimitOrderState>(
        'emits `response` = BaseResponse.complete WHEN '
        'failed submit sell limit order',
        build: () {
          when(mockOrdersRepository.submitOrder(orderRequest: sellLimitRequest))
              .thenThrow(BaseResponse.errorMessage);
          return limitBloc;
        },
        act: (bloc) async {
          bloc.add(OrderSubmitted(sellLimitRequest));
        },
        expect: () => {
              LimitOrderState(
                  response: BaseResponse.loading(),
                  availableBuyingPower: 1000,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
              LimitOrderState(
                  response: errorResponse,
                  availableBuyingPower: 1000,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
            });

    blocTest<LimitOrderBloc, LimitOrderState>(
        'emits `response` = BaseResponse.complete WHEN '
        'successfully submit buy limit order',
        build: () {
          when(mockOrdersRepository.submitOrder(orderRequest: buyLimitRequest))
              .thenAnswer((_) async => Future.value(successResponse));
          return limitBloc;
        },
        act: (bloc) async {
          bloc.add(OrderSubmitted(buyLimitRequest));
        },
        expect: () => {
              LimitOrderState(
                  response: BaseResponse.loading(),
                  availableBuyingPower: 1000,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
              LimitOrderState(
                  response: successResponse,
                  availableBuyingPower: 1000,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
            });

    blocTest<LimitOrderBloc, LimitOrderState>(
        'emits `response` = BaseResponse.complete WHEN '
        'successfully submit sell limit order',
        build: () {
          when(mockOrdersRepository.submitOrder(orderRequest: sellLimitRequest))
              .thenAnswer((_) async => Future.value(successResponse));
          return limitBloc;
        },
        act: (bloc) async {
          bloc.add(OrderSubmitted(sellLimitRequest));
        },
        expect: () => {
              LimitOrderState(
                  response: BaseResponse.loading(),
                  availableBuyingPower: 1000,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
              LimitOrderState(
                  response: successResponse,
                  availableBuyingPower: 1000,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
            });

    tearDown(() => {limitBloc.close()});
  });
}
