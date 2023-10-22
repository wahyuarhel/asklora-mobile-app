import 'package:asklora_mobile_app/feature/orders/bloc/order_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  group('Order Bloc Tests', () {
    late OrderBloc orderBloc;

    setUp(() async {
      orderBloc = OrderBloc();
    });

    test('Order Bloc init state', () {
      expect(orderBloc.state, const OrderState());
    });

    blocTest<OrderBloc, OrderState>(
        'emits `transactionType` = TransactionType.buy WHEN '
        'select transaction type buy',
        build: () => orderBloc,
        act: (bloc) async =>
            bloc.add(const TransactionTypeChanged(TransactionType.buy)),
        expect: () => {
              const OrderState(transactionType: TransactionType.buy),
            });

    blocTest<OrderBloc, OrderState>(
        'emits `transactionType` = TransactionType.buy WHEN '
        'select transaction type sell',
        build: () => orderBloc,
        act: (bloc) async =>
            bloc.add(const TransactionTypeChanged(TransactionType.sell)),
        expect: () => {
              const OrderState(transactionType: TransactionType.sell),
            });

    blocTest<OrderBloc, OrderState>(
        'emits `orderType` = OrderType.limit WHEN '
        'select order type limit',
        build: () => orderBloc,
        act: (bloc) async => bloc.add(const OrderTypeChanged(OrderType.limit)),
        expect: () => {
              const OrderState(orderType: OrderType.limit),
            });

    blocTest<OrderBloc, OrderState>(
        'emits `trailType` = TrailType.amount WHEN '
        'select trail type amount',
        build: () => orderBloc,
        act: (bloc) async => bloc.add(const TrailTypeChanged(TrailType.amount)),
        expect: () => {
              const OrderState(trailType: TrailType.amount),
            });

    blocTest<OrderBloc, OrderState>(
        'emits `timeInForce` = TimeInForce.goodTillCanceled WHEN '
        'select time in force goodTillCanceled',
        build: () => orderBloc,
        act: (bloc) async =>
            bloc.add(const TimeInForceChanged(TimeInForce.goodTillCanceled)),
        expect: () => {
              const OrderState(timeInForce: TimeInForce.goodTillCanceled),
            });

    blocTest<OrderBloc, OrderState>(
        'emits `tradingHours` = TradingHours.regular WHEN '
        'select trading hours regular',
        build: () => orderBloc,
        act: (bloc) async =>
            bloc.add(const TradingHoursChanged(TradingHours.regular)),
        expect: () => {
              const OrderState(tradingHours: TradingHours.regular),
            });

    tearDown(() => {orderBloc.close()});
  });
}
