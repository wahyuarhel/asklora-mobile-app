import 'package:asklora_mobile_app/core/utils/app_icons.dart';
import 'package:asklora_mobile_app/feature/orders/bloc/limit/limit_order_bloc.dart';
import 'package:asklora_mobile_app/feature/orders/bloc/order_bloc.dart';
import 'package:asklora_mobile_app/feature/orders/domain/symbol_detail.dart';
import 'package:asklora_mobile_app/feature/orders/regular/presentation/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/mocks.dart';

void main() {
  final SymbolDetail symbolDetail =
      SymbolDetail('AAPL.O', 100, AppIcons.appleLogo, SymbolType.symbol);
  Future<void> buildOrderConfirmationWidget<T>(
      WidgetTester tester, OrderState orderState,
      {T? dynamicState}) async {
    final mockObserver = MockNavigatorObserver();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (_) => OrderBloc(),
          child: OrderConfirmationWidget<T>(
              dynamicState: dynamicState,
              onConfirmedTap: () {},
              orderState: orderState,
              symbolDetail: symbolDetail),
        ),
      ),
      navigatorObservers: [mockObserver],
    ));
  }

  final symbolTitle = find.byKey(const Key('symbol_title_widget'));
  final timeInForce = find.byKey(const Key('time_in_force_widget'));
  final trail = find.byKey(const Key('trail_type_widget'));
  final orderType = find.byKey(const Key('order_type_widget'));
  final fees = find.byKey(const Key('order_fees_widget'));
  final estimatedTotal = find.byKey(const Key('estimated_total_widget'));
  final tradingHours = find.byKey(const Key('trading_hours_widget'));
  final sharesQuantity = find.byKey(const Key('shares_quantity_widget'));
  final orderConfirmationButton =
      find.byKey(const Key('order_confirmation_button'));

  group('Order Buy Confirmation Widget Test', () {
    testWidgets('Limit Order', (WidgetTester tester) async {
      await buildOrderConfirmationWidget<LimitOrderState>(
          tester,
          const OrderState(
              orderType: OrderType.limit, transactionType: TransactionType.buy),
          dynamicState: const LimitOrderState(
              availableBuyingPower: 1000,
              availableAmountToSell: 10,
              numberOfSellableShares: 10));
      expect(symbolTitle, findsOneWidget);
      expect(find.text('Direction'), findsOneWidget);
      expect(orderType, findsOneWidget);
      expect(find.text('Limit Price'), findsOneWidget);
      expect(sharesQuantity, findsOneWidget);
      expect(fees, findsOneWidget);
      expect(estimatedTotal, findsOneWidget);
      expect(timeInForce, findsOneWidget);
      expect(tradingHours, findsOneWidget);
      expect(orderConfirmationButton, findsOneWidget);
    });

    testWidgets('Stop Order', (WidgetTester tester) async {
      await buildOrderConfirmationWidget(
          tester,
          const OrderState(
              orderType: OrderType.stop, transactionType: TransactionType.buy));
      expect(symbolTitle, findsOneWidget);
      expect(find.text('Direction'), findsOneWidget);
      expect(orderType, findsOneWidget);
      expect(find.text('Stop Price'), findsOneWidget);
      expect(sharesQuantity, findsOneWidget);
      expect(fees, findsOneWidget);
      expect(estimatedTotal, findsOneWidget);
      expect(timeInForce, findsOneWidget);
      expect(orderConfirmationButton, findsOneWidget);
    });

    testWidgets('Stop Limit Order', (WidgetTester tester) async {
      await buildOrderConfirmationWidget(
          tester,
          const OrderState(
              orderType: OrderType.stopLimit,
              transactionType: TransactionType.buy));
      expect(symbolTitle, findsOneWidget);
      expect(find.text('Direction'), findsOneWidget);
      expect(orderType, findsOneWidget);
      expect(find.text('Stop Price'), findsOneWidget);
      expect(find.text('Limit Price'), findsOneWidget);
      expect(sharesQuantity, findsOneWidget);
      expect(fees, findsOneWidget);
      expect(estimatedTotal, findsOneWidget);
      expect(timeInForce, findsOneWidget);
      expect(orderConfirmationButton, findsOneWidget);
    });

    testWidgets('Trailing Stop Order', (WidgetTester tester) async {
      await buildOrderConfirmationWidget(
          tester,
          const OrderState(
              orderType: OrderType.trailingStop,
              transactionType: TransactionType.buy));
      expect(symbolTitle, findsOneWidget);
      expect(find.text('Direction'), findsOneWidget);
      expect(orderType, findsOneWidget);
      expect(trail, findsOneWidget);
      expect(sharesQuantity, findsOneWidget);
      expect(fees, findsOneWidget);
      expect(estimatedTotal, findsOneWidget);
      expect(timeInForce, findsOneWidget);
      expect(orderConfirmationButton, findsOneWidget);
    });

    testWidgets('Market Order', (WidgetTester tester) async {
      await buildOrderConfirmationWidget(
          tester,
          const OrderState(
              orderType: OrderType.market,
              transactionType: TransactionType.buy));
      expect(symbolTitle, findsOneWidget);
      expect(find.text('Direction'), findsOneWidget);
      expect(orderType, findsOneWidget);
      expect(find.text('Amount'), findsOneWidget);
      expect(find.text('Equivalent Quantity'), findsOneWidget);
      expect(fees, findsOneWidget);
      expect(estimatedTotal, findsOneWidget);
      expect(orderConfirmationButton, findsOneWidget);
    });
  });

  group('Order Sell Confirmation Widget Test', () {
    testWidgets('Limit Order', (WidgetTester tester) async {
      await buildOrderConfirmationWidget<LimitOrderState>(
          tester,
          const OrderState(
              orderType: OrderType.limit,
              transactionType: TransactionType.sell),
          dynamicState: const LimitOrderState(
              availableBuyingPower: 1000,
              availableAmountToSell: 100,
              numberOfSellableShares: 10));
      expect(symbolTitle, findsOneWidget);
      expect(find.text('Direction'), findsOneWidget);
      expect(orderType, findsOneWidget);
      expect(find.text('Limit Price'), findsOneWidget);
      expect(sharesQuantity, findsOneWidget);
      expect(estimatedTotal, findsOneWidget);
      expect(timeInForce, findsOneWidget);
      expect(tradingHours, findsOneWidget);
      expect(orderConfirmationButton, findsOneWidget);
    });

    testWidgets('Stop Order', (WidgetTester tester) async {
      await buildOrderConfirmationWidget(
          tester,
          const OrderState(
              orderType: OrderType.stop,
              transactionType: TransactionType.sell));
      expect(symbolTitle, findsOneWidget);
      expect(find.text('Direction'), findsOneWidget);
      expect(orderType, findsOneWidget);
      expect(find.text('Stop Price'), findsOneWidget);
      expect(sharesQuantity, findsOneWidget);
      expect(estimatedTotal, findsOneWidget);
      expect(timeInForce, findsOneWidget);
      expect(orderConfirmationButton, findsOneWidget);
    });

    testWidgets('Stop Limit Order', (WidgetTester tester) async {
      await buildOrderConfirmationWidget(
          tester,
          const OrderState(
              orderType: OrderType.stopLimit,
              transactionType: TransactionType.buy));
      expect(symbolTitle, findsOneWidget);
      expect(find.text('Direction'), findsOneWidget);
      expect(orderType, findsOneWidget);
      expect(find.text('Stop Price'), findsOneWidget);
      expect(find.text('Limit Price'), findsOneWidget);
      expect(sharesQuantity, findsOneWidget);
      expect(estimatedTotal, findsOneWidget);
      expect(timeInForce, findsOneWidget);
      expect(orderConfirmationButton, findsOneWidget);
    });

    testWidgets('Trailing Stop Order', (WidgetTester tester) async {
      await buildOrderConfirmationWidget(
          tester,
          const OrderState(
              orderType: OrderType.trailingStop,
              transactionType: TransactionType.sell));
      expect(symbolTitle, findsOneWidget);
      expect(find.text('Direction'), findsOneWidget);
      expect(orderType, findsOneWidget);
      expect(trail, findsOneWidget);
      expect(sharesQuantity, findsOneWidget);
      expect(estimatedTotal, findsOneWidget);
      expect(timeInForce, findsOneWidget);
      expect(orderConfirmationButton, findsOneWidget);
    });

    testWidgets('Market Order', (WidgetTester tester) async {
      await buildOrderConfirmationWidget(
          tester,
          const OrderState(
              orderType: OrderType.market,
              transactionType: TransactionType.sell));
      expect(symbolTitle, findsOneWidget);
      expect(find.text('Direction'), findsOneWidget);
      expect(orderType, findsOneWidget);
      expect(find.text('Amount'), findsOneWidget);
      expect(find.text('Equivalent Quantity'), findsOneWidget);
      expect(estimatedTotal, findsOneWidget);
      expect(orderConfirmationButton, findsOneWidget);
    });
  });
}
