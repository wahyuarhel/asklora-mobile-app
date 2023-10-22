import 'package:asklora_mobile_app/feature/orders/bloc/order_bloc.dart';
import 'package:asklora_mobile_app/feature/orders/regular/presentation/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/mocks.dart';

void main() {
  group('Order Details Screen Test', () {
    Future<void> buildOrderDetailsScreen(WidgetTester tester,
        {required TransactionType transactionType,
        required OrderType orderType}) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: OrderDetailsScreen(
              transactionType: transactionType, orderType: orderType),
        ),
        navigatorObservers: [mockObserver],
      ));
    }

    var directionValue = find.byKey(const Key('direction_value_expanded_row'));
    var orderTypeValue = find.byKey(const Key('order_type_value_expanded_row'));
    var amountValue = find.byKey(const Key('amount_value_expanded_row'));
    var equivalentQuantityValue =
        find.byKey(const Key('equivalent_quantity_value_expanded_row'));
    var estTotalValue = find.byKey(const Key('est_total_value_expanded_row'));

    testWidgets('When user on "BUY" Market Order ',
        (WidgetTester tester) async {
      await buildOrderDetailsScreen(tester,
          transactionType: TransactionType.buy, orderType: OrderType.market);
      expect(find.text('Trade Details'), findsWidgets);
      expect(directionValue, findsWidgets);
      expect(orderTypeValue, findsWidgets);
      expect(amountValue, findsWidgets);
      expect(equivalentQuantityValue, findsWidgets);
      expect(estTotalValue, findsWidgets);
    });
    testWidgets('When user on "BUY" Limit Order ', (WidgetTester tester) async {
      await buildOrderDetailsScreen(tester,
          transactionType: TransactionType.buy, orderType: OrderType.limit);
      expect(find.text('Trade Details'), findsWidgets);
      expect(directionValue, findsWidgets);
      expect(orderTypeValue, findsWidgets);
      expect(amountValue, findsWidgets);
      expect(equivalentQuantityValue, findsWidgets);
      expect(estTotalValue, findsWidgets);
    });
    testWidgets('When user on "BUY" Stop Order ', (WidgetTester tester) async {
      await buildOrderDetailsScreen(tester,
          transactionType: TransactionType.buy, orderType: OrderType.stop);
      expect(find.text('Trade Details'), findsWidgets);
      expect(directionValue, findsWidgets);
      expect(orderTypeValue, findsWidgets);
      expect(amountValue, findsWidgets);
      expect(equivalentQuantityValue, findsWidgets);
      expect(estTotalValue, findsWidgets);
    });
    testWidgets('When user on "BUY" Stop Limit Order ',
        (WidgetTester tester) async {
      await buildOrderDetailsScreen(tester,
          transactionType: TransactionType.buy, orderType: OrderType.stopLimit);
      expect(find.text('Trade Details'), findsWidgets);
      expect(directionValue, findsWidgets);
      expect(orderTypeValue, findsWidgets);
      expect(amountValue, findsWidgets);
      expect(equivalentQuantityValue, findsWidgets);
      expect(estTotalValue, findsWidgets);
    });
    testWidgets('When user on "BUY" Trailing Stop Order ',
        (WidgetTester tester) async {
      await buildOrderDetailsScreen(tester,
          transactionType: TransactionType.buy,
          orderType: OrderType.trailingStop);
      expect(find.text('Trade Details'), findsWidgets);
      expect(directionValue, findsWidgets);
      expect(orderTypeValue, findsWidgets);
      expect(amountValue, findsWidgets);
      expect(equivalentQuantityValue, findsWidgets);
      expect(estTotalValue, findsWidgets);
    });
    testWidgets('When user on "SELL" Market Order ',
        (WidgetTester tester) async {
      await buildOrderDetailsScreen(tester,
          transactionType: TransactionType.sell, orderType: OrderType.market);
      expect(find.text('Trade Details'), findsWidgets);
      expect(directionValue, findsWidgets);
      expect(orderTypeValue, findsWidgets);
      expect(amountValue, findsWidgets);
      expect(equivalentQuantityValue, findsWidgets);
      expect(estTotalValue, findsWidgets);
    });
    testWidgets('When user on "SELL" Limit Order ',
        (WidgetTester tester) async {
      await buildOrderDetailsScreen(tester,
          transactionType: TransactionType.sell, orderType: OrderType.limit);
      expect(find.text('Trade Details'), findsWidgets);
      expect(directionValue, findsWidgets);
      expect(orderTypeValue, findsWidgets);
      expect(amountValue, findsWidgets);
      expect(equivalentQuantityValue, findsWidgets);
      expect(estTotalValue, findsWidgets);
    });
    testWidgets('When user on "SELL" Stop Order ', (WidgetTester tester) async {
      await buildOrderDetailsScreen(tester,
          transactionType: TransactionType.sell, orderType: OrderType.stop);
      expect(find.text('Trade Details'), findsWidgets);
      expect(directionValue, findsWidgets);
      expect(orderTypeValue, findsWidgets);
      expect(amountValue, findsWidgets);
      expect(equivalentQuantityValue, findsWidgets);
      expect(estTotalValue, findsWidgets);
    });
    testWidgets('When user on "SELL" Stop Limit Order ',
        (WidgetTester tester) async {
      await buildOrderDetailsScreen(tester,
          transactionType: TransactionType.sell,
          orderType: OrderType.stopLimit);
      expect(find.text('Trade Details'), findsWidgets);
      expect(directionValue, findsWidgets);
      expect(orderTypeValue, findsWidgets);
      expect(amountValue, findsWidgets);
      expect(equivalentQuantityValue, findsWidgets);
      expect(estTotalValue, findsWidgets);
    });
    testWidgets('When user on "SELL" Trailing Stop Order ',
        (WidgetTester tester) async {
      await buildOrderDetailsScreen(tester,
          transactionType: TransactionType.sell,
          orderType: OrderType.trailingStop);
      expect(find.text('Trade Details'), findsWidgets);
      expect(directionValue, findsWidgets);
      expect(orderTypeValue, findsWidgets);
      expect(amountValue, findsWidgets);
      expect(equivalentQuantityValue, findsWidgets);
      expect(estTotalValue, findsWidgets);
    });
  });
}
