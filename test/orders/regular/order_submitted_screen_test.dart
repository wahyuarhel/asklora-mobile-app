import 'package:asklora_mobile_app/core/utils/app_icons.dart';
import 'package:asklora_mobile_app/feature/orders/bloc/order_bloc.dart';
import 'package:asklora_mobile_app/feature/orders/domain/symbol_detail.dart';
import 'package:asklora_mobile_app/feature/orders/regular/presentation/order_submitted_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/mocks.dart';

void main() {
  group('*Order Submitted Screen Test*', () {
    final SymbolDetail symbolDetail =
        SymbolDetail('AAPL.O', 100, AppIcons.appleLogo, SymbolType.symbol);
    Future<void> buildOrderSubmittedScreen(WidgetTester tester,
        {required TransactionType transactionType,
        required OrderType orderType,
        required SymbolDetail symbolDetail}) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: OrderSubmittedScreen(
            transactionType: transactionType,
            orderType: orderType,
            symbolDetail: symbolDetail,
          ),
        ),
        navigatorObservers: [mockObserver],
      ));
    }

    var viewOrderDetailButton =
        find.byKey(const Key('view_order_detail_submitted_button'));
    var backToDashboardButton =
        find.byKey(const Key('back_to_dashboard_button'));
    var directionValue = find.byKey(const Key('direction_value_expanded_row'));
    var orderTypeValue = find.byKey(const Key('order_type_value_expanded_row'));
    var quantityValue = find.byKey(const Key('quantity_value_expanded_row'));
    var amountValue = find.byKey(const Key('amount_value_expanded_row'));

    testWidgets('When user on "BUY Market Order" Order submitted screen',
        (WidgetTester tester) async {
      await buildOrderSubmittedScreen(tester,
          transactionType: TransactionType.buy,
          orderType: OrderType.market,
          symbolDetail: symbolDetail);
      expect(find.text('Order Success!'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.text('Your order of AAPL.O\nbeen processed'), findsOneWidget);
      expect(directionValue, findsOneWidget);
      expect(orderTypeValue, findsOneWidget);
      expect(quantityValue, findsOneWidget);
      expect(amountValue, findsOneWidget);
      expect(backToDashboardButton, findsOneWidget);
      expect(viewOrderDetailButton, findsOneWidget);
    });
    testWidgets('When user on "BUY Limit Order" Order submitted screen',
        (WidgetTester tester) async {
      await buildOrderSubmittedScreen(tester,
          transactionType: TransactionType.buy,
          orderType: OrderType.limit,
          symbolDetail: symbolDetail);
      expect(find.text('Order Success!'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.text('Your order of ${symbolDetail.name}\nbeen processed'),
          findsOneWidget);
      expect(directionValue, findsOneWidget);
      expect(orderTypeValue, findsOneWidget);
      expect(quantityValue, findsOneWidget);
      expect(amountValue, findsOneWidget);
      expect(backToDashboardButton, findsOneWidget);
      expect(viewOrderDetailButton, findsOneWidget);
    });
    testWidgets('When user on "BUY Stop Order" Order submitted screen',
        (WidgetTester tester) async {
      await buildOrderSubmittedScreen(tester,
          transactionType: TransactionType.buy,
          orderType: OrderType.stop,
          symbolDetail: symbolDetail);
      expect(find.text('Order Success!'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.text('Your order of ${symbolDetail.name}\nbeen processed'),
          findsOneWidget);
      expect(directionValue, findsOneWidget);
      expect(orderTypeValue, findsOneWidget);
      expect(quantityValue, findsOneWidget);
      expect(amountValue, findsOneWidget);
      expect(backToDashboardButton, findsOneWidget);
      expect(viewOrderDetailButton, findsOneWidget);
    });
    testWidgets('When user on "BUY Stop Limit Order" Order submitted screen',
        (WidgetTester tester) async {
      await buildOrderSubmittedScreen(tester,
          transactionType: TransactionType.buy,
          orderType: OrderType.stopLimit,
          symbolDetail: symbolDetail);
      expect(find.text('Order Success!'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.text('Your order of ${symbolDetail.name}\nbeen processed'),
          findsOneWidget);
      expect(directionValue, findsOneWidget);
      expect(orderTypeValue, findsOneWidget);
      expect(quantityValue, findsOneWidget);
      expect(amountValue, findsOneWidget);
      expect(backToDashboardButton, findsOneWidget);
      expect(viewOrderDetailButton, findsOneWidget);
    });
    testWidgets('When user on "BUY Trailing Stop Order" Order submitted screen',
        (WidgetTester tester) async {
      await buildOrderSubmittedScreen(tester,
          transactionType: TransactionType.buy,
          orderType: OrderType.trailingStop,
          symbolDetail: symbolDetail);
      expect(find.text('Order Success!'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.text('Your order of ${symbolDetail.name}\nbeen processed'),
          findsOneWidget);
      expect(directionValue, findsOneWidget);
      expect(orderTypeValue, findsOneWidget);
      expect(quantityValue, findsOneWidget);
      expect(amountValue, findsOneWidget);
      expect(backToDashboardButton, findsOneWidget);
      expect(viewOrderDetailButton, findsOneWidget);
    });

    testWidgets('When user on "SELL Market Order" Order submitted screen',
        (WidgetTester tester) async {
      await buildOrderSubmittedScreen(tester,
          transactionType: TransactionType.sell,
          orderType: OrderType.market,
          symbolDetail: symbolDetail);
      expect(find.text('Order Success!'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.text('Your order of ${symbolDetail.name}\nbeen processed'),
          findsOneWidget);
      expect(find.text('Direction'), findsOneWidget);
      expect(find.text('Order Type'), findsOneWidget);
      expect(find.text('Quantity'), findsOneWidget);
      expect(find.text('Amount'), findsOneWidget);
      expect(backToDashboardButton, findsOneWidget);
      expect(viewOrderDetailButton, findsOneWidget);
    });
    testWidgets('When user on "SELL Limit Order" Order submitted screen',
        (WidgetTester tester) async {
      await buildOrderSubmittedScreen(tester,
          transactionType: TransactionType.sell,
          orderType: OrderType.limit,
          symbolDetail: symbolDetail);
      expect(find.text('Order Success!'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.text('Your order of ${symbolDetail.name}\nbeen processed'),
          findsOneWidget);
      expect(find.text('Direction'), findsOneWidget);
      expect(find.text('Order Type'), findsOneWidget);
      expect(find.text('Quantity'), findsOneWidget);
      expect(find.text('Amount'), findsOneWidget);
      expect(backToDashboardButton, findsOneWidget);
      expect(viewOrderDetailButton, findsOneWidget);
    });
    testWidgets('When user on "SELL Stop Order" Order submitted screen',
        (WidgetTester tester) async {
      await buildOrderSubmittedScreen(tester,
          transactionType: TransactionType.sell,
          orderType: OrderType.stop,
          symbolDetail: symbolDetail);
      expect(find.text('Order Success!'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.text('Your order of ${symbolDetail.name}\nbeen processed'),
          findsOneWidget);
      expect(find.text('Direction'), findsOneWidget);
      expect(find.text('Order Type'), findsOneWidget);
      expect(find.text('Quantity'), findsOneWidget);
      expect(find.text('Amount'), findsOneWidget);
      expect(backToDashboardButton, findsOneWidget);
      expect(viewOrderDetailButton, findsOneWidget);
    });
    testWidgets('When user on "SELL Stop Limit Order" Order submitted screen',
        (WidgetTester tester) async {
      await buildOrderSubmittedScreen(tester,
          transactionType: TransactionType.sell,
          orderType: OrderType.stopLimit,
          symbolDetail: symbolDetail);
      expect(find.text('Order Success!'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.text('Your order of ${symbolDetail.name}\nbeen processed'),
          findsOneWidget);
      expect(find.text('Direction'), findsOneWidget);
      expect(find.text('Order Type'), findsOneWidget);
      expect(find.text('Quantity'), findsOneWidget);
      expect(find.text('Amount'), findsOneWidget);
      expect(backToDashboardButton, findsOneWidget);
      expect(viewOrderDetailButton, findsOneWidget);
    });
    testWidgets(
        'When user on "SELL Trailing Stop Order" Order submitted screen',
        (WidgetTester tester) async {
      await buildOrderSubmittedScreen(tester,
          transactionType: TransactionType.sell,
          orderType: OrderType.trailingStop,
          symbolDetail: symbolDetail);
      expect(find.text('Order Success!'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.text('Your order of ${symbolDetail.name}\nbeen processed'),
          findsOneWidget);
      expect(find.text('Direction'), findsOneWidget);
      expect(find.text('Order Type'), findsOneWidget);
      expect(find.text('Quantity'), findsOneWidget);
      expect(find.text('Amount'), findsOneWidget);
      expect(backToDashboardButton, findsOneWidget);
      expect(viewOrderDetailButton, findsOneWidget);
    });
  });
}
