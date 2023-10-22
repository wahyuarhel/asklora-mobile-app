import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/feature/orders/bloc/market/market_bloc.dart';
import 'package:asklora_mobile_app/feature/orders/domain/order_request.dart';
import 'package:asklora_mobile_app/feature/orders/domain/order_response.dart';
import 'package:asklora_mobile_app/feature/orders/repository/orders_repository.dart';
import 'package:asklora_mobile_app/feature/orders/utils/orders_calculation.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'market_bloc_test.mocks.dart';

@GenerateMocks([OrdersRepository])
void main() async {
  group('Market Bloc Tests', () {
    late MarketBloc marketBloc;
    late MockOrdersRepository mockOrdersRepository;
    double marketPrice = 100;

    setUpAll(() async {
      mockOrdersRepository = MockOrdersRepository();
    });

    setUp(() async {
      marketBloc = MarketBloc(
          marketPrice: marketPrice,
          availableBuyingPower: 1000,
          ordersRepository: mockOrdersRepository,
          numberOfSellableShares: 20);
    });

    test('Market Bloc init state', () {
      expect(
          marketBloc.state,
          const MarketState(
              availableBuyingPower: 1000,
              numberOfBuyableShares: 10,
              availableAmountToSell: 2000,
              numberOfSellableShares: 20));
    });

    blocTest<MarketBloc, MarketState>(
        'emits `estimateTotal` = 1000 and `amount` = 10 WHEN '
        'input amount 1000',
        build: () => marketBloc,
        act: (bloc) async => bloc.add(const AmountChanged(1000)),
        expect: () => {
              MarketState(
                  amount: 1000,
                  estimateTotal: 1000,
                  sharesAmount: calculateAmount(marketPrice, 1000),
                  availableBuyingPower: 1000,
                  numberOfBuyableShares: 10,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
            });

    blocTest<MarketBloc, MarketState>(
        'emits `shares amount` = 0.1 and `estimated total` = 10 WHEN '
        'increment shares amount 1x',
        build: () => marketBloc,
        act: (bloc) async => bloc.add(const SharesAmountIncremented()),
        expect: () => {
              MarketState(
                  amount: 10,
                  estimateTotal: calculateEstimateTotal(marketPrice, 0.1),
                  sharesAmount: 0.1,
                  availableBuyingPower: 1000,
                  numberOfBuyableShares: 10,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
            });

    blocTest<MarketBloc, MarketState>(
        'emits `shares amount` = 0 and `estimated total` = 0 WHEN '
        'increment shares amount 1x then decrement shares amount 1x',
        build: () => marketBloc,
        act: (bloc) async {
          bloc.add(const SharesAmountIncremented());
          bloc.add(const SharesAmountDecremented());
        },
        expect: () => {
              MarketState(
                  amount: 10,
                  estimateTotal: calculateEstimateTotal(marketPrice, 0.1),
                  sharesAmount: 0.1,
                  availableBuyingPower: 1000,
                  numberOfBuyableShares: 10,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
              const MarketState(
                  amount: 0,
                  estimateTotal: 0,
                  sharesAmount: 0,
                  availableBuyingPower: 1000,
                  numberOfBuyableShares: 10,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
            });

    OrderRequest marketSharesRequest = OrderRequest.marketShares(
        symbolType: 'symbol', symbol: 'abc', side: 'buy', qty: '10');
    OrderRequest marketAmountRequest = OrderRequest.marketAmount(
        symbolType: 'symbol', symbol: 'abc', side: 'buy', amount: '1000');
    BaseResponse<OrderResponse> response =
        BaseResponse.complete(OrderResponse());

    blocTest<MarketBloc, MarketState>(
        'emits `response` = BaseResponse.complete WHEN '
        'successfully submit market shares order',
        build: () {
          when(mockOrdersRepository.submitOrder(
                  orderRequest: marketSharesRequest))
              .thenAnswer((_) async => Future.value(response));
          return marketBloc;
        },
        act: (bloc) async {
          bloc.add(OrderSubmitted(marketSharesRequest));
        },
        expect: () => {
              MarketState(
                  response: BaseResponse.loading(),
                  availableBuyingPower: 1000,
                  numberOfBuyableShares: 10,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
              MarketState(
                  response: response,
                  availableBuyingPower: 1000,
                  numberOfBuyableShares: 10,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
            });

    blocTest<MarketBloc, MarketState>(
        'emits `response` = BaseResponse.complete WHEN '
        'successfully submit market amount order',
        build: () {
          when(mockOrdersRepository.submitOrder(
                  orderRequest: marketAmountRequest))
              .thenAnswer((_) async => Future.value(response));
          return marketBloc;
        },
        act: (bloc) async {
          bloc.add(OrderSubmitted(marketSharesRequest));
        },
        expect: () => {
              MarketState(
                  response: BaseResponse.loading(),
                  availableBuyingPower: 1000,
                  numberOfBuyableShares: 10,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
              MarketState(
                  response: response,
                  availableBuyingPower: 1000,
                  numberOfBuyableShares: 10,
                  availableAmountToSell: 2000,
                  numberOfSellableShares: 20),
            });

    tearDown(() => {marketBloc.close()});
  });
}
