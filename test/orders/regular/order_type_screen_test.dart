import 'package:asklora_mobile_app/feature/orders/bloc/order_bloc.dart';
import 'package:asklora_mobile_app/feature/orders/regular/presentation/order_type_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/mocks.dart';

void main() {
  group('*Order Type Screen Test*', () {
    Future<void> buildOrderTypeScreen(
        WidgetTester tester, TransactionType transactionType) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: OrderTypeScreen(transactionType: transactionType),
        ),
        navigatorObservers: [mockObserver],
      ));
    }

    //* var for BUY
    var buyMarketOrderButton = find.byKey(const Key('market_order_buy_button'));
    var buyLimitOrderButton = find.byKey(const Key('limit_order_buy_button'));
    var buyStopOrderBuyButton = find.byKey(const Key('stop_order_buy_button'));
    var buyStopLimitOrderButton =
        find.byKey(const Key('stop_limit_order_buy_button'));
    var buyTrailingStopOrderButton =
        find.byKey(const Key('trailing_stop_order_buy_button'));

    //* Key for SELL
    var sellMarketSellOrderButton =
        find.byKey(const Key('market_order_sell_button'));
    var sellLimitOrderButton = find.byKey(const Key('limit_order_sell_button'));
    var sellStopOrderBuyButton =
        find.byKey(const Key('stop_order_sell_button'));
    var sellStopLimitOrderButton =
        find.byKey(const Key('stop_limit_order_sell_button'));
    var sellTrailingStopOrderButton =
        find.byKey(const Key('trailing_stop_order_sell_button'));

    testWidgets('When user on "Buy" Order Type Screen',
        (WidgetTester tester) async {
      await buildOrderTypeScreen(tester, TransactionType.buy);
      expect(find.text('Select Order type'), findsOneWidget);
      expect(find.text('AskLORA supports the following order type :'),
          findsOneWidget);
      expect(buyMarketOrderButton, findsOneWidget);
      expect(buyLimitOrderButton, findsOneWidget);
      expect(buyStopOrderBuyButton, findsOneWidget);
      expect(buyStopLimitOrderButton, findsOneWidget);
      expect(buyTrailingStopOrderButton, findsOneWidget);
      expect(
          find.text(
              'Still unsure about the different order types? Learn more here!'),
          findsOneWidget);
    });

    testWidgets('When user on "Sell" Order Type Screen',
        (WidgetTester tester) async {
      await buildOrderTypeScreen(tester, TransactionType.sell);
      expect(find.text('Select Order type'), findsOneWidget);
      expect(find.text('AskLORA supports the following order type :'),
          findsOneWidget);
      expect(sellMarketSellOrderButton, findsOneWidget);
      expect(sellLimitOrderButton, findsOneWidget);
      expect(sellStopOrderBuyButton, findsOneWidget);
      expect(sellStopLimitOrderButton, findsOneWidget);
      expect(sellTrailingStopOrderButton, findsOneWidget);
    });
  });
}
