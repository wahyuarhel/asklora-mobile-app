import 'package:asklora_mobile_app/core/utils/app_icons.dart';
import 'package:asklora_mobile_app/feature/orders/bloc/order_bloc.dart';
import 'package:asklora_mobile_app/feature/orders/bloc/trailing/trailing_order_bloc.dart';
import 'package:asklora_mobile_app/feature/orders/domain/symbol_detail.dart';
import 'package:asklora_mobile_app/feature/orders/regular/presentation/order_screen.dart';
import 'package:asklora_mobile_app/feature/orders/repository/orders_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/mocks.dart';

void main() {
  group('Trailing Stop Order Widget Test', () {
    final SymbolDetail symbolDetail =
        SymbolDetail('AAPL.O', 100, AppIcons.appleLogo, SymbolType.symbol);
    Future<void> buildTrailingStopOrderWidget(
        WidgetTester tester, OrderState orderState) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => OrderBloc(),
              ),
              BlocProvider(
                  create: (_) => TrailingOrderBloc(
                      marketPrice: 100,
                      availableBuyingPower: 1000,
                      numberOfSellableShares: 20,
                      ordersRepository: OrdersRepository()))
            ],
            child: TrailingStopOrderWidget(
                orderState: orderState, symbolDetail: symbolDetail),
          ),
        ),
        navigatorObservers: [mockObserver],
      ));
    }

    final trail = find.byKey(const Key('trail_widget'));
    final timeInForce = find.byKey(const Key('time_in_force_widget'));
    final marketPrice = find.byKey(const Key('market_price_widget'));
    final estimatedTotal = find.byKey(const Key('estimated_total_widget'));
    final initialTrailingPrice =
        find.byKey(const Key('initial_trailing_price_widget'));
    final availableBuyingPower =
        find.byKey(const Key('available_buying_power_widget'));
    final availableAmountToSell =
        find.byKey(const Key('available_amount_to_sell_widget'));
    final sharesQuantity = find.byKey(const Key('shares_quantity_widget'));
    final numberOfSellableShares =
        find.byKey(const Key('number_of_sellable_shares_widget'));

    testWidgets('First render widget transaction type buy',
        (WidgetTester tester) async {
      await buildTrailingStopOrderWidget(
          tester,
          const OrderState(
              orderType: OrderType.trailingStop,
              transactionType: TransactionType.buy));
      expect(trail, findsOneWidget);
      expect(sharesQuantity, findsOneWidget);
      expect(timeInForce, findsOneWidget);
      expect(marketPrice, findsOneWidget);
      expect(initialTrailingPrice, findsOneWidget);
      expect(estimatedTotal, findsOneWidget);
      expect(availableBuyingPower, findsOneWidget);
      expect(availableAmountToSell, findsNothing);
      expect(numberOfSellableShares, findsNothing);
    });

    testWidgets('First render widget transaction type sell',
        (WidgetTester tester) async {
      await buildTrailingStopOrderWidget(
          tester,
          const OrderState(
              orderType: OrderType.trailingStop,
              transactionType: TransactionType.sell));
      expect(trail, findsOneWidget);
      expect(sharesQuantity, findsOneWidget);
      expect(timeInForce, findsOneWidget);
      expect(marketPrice, findsOneWidget);
      expect(initialTrailingPrice, findsOneWidget);
      expect(estimatedTotal, findsOneWidget);
      expect(availableBuyingPower, findsNothing);
      expect(availableAmountToSell, findsOneWidget);
      expect(numberOfSellableShares, findsOneWidget);
    });
  });
}
