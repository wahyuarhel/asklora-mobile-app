import 'package:asklora_mobile_app/core/utils/app_icons.dart';
import 'package:asklora_mobile_app/feature/orders/bloc/order_bloc.dart';
import 'package:asklora_mobile_app/feature/orders/domain/symbol_detail.dart';
import 'package:asklora_mobile_app/feature/orders/regular/presentation/regular_order_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/mocks.dart';

void main() {
  group('Order Screen Test', () {
    final SymbolDetail symbolDetail =
        SymbolDetail('AAPL.O', 100, AppIcons.appleLogo, SymbolType.symbol);
    Future<void> buildDepositWelcomeScreen(WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(MaterialApp(
        home: RegularOrderHomeScreen(
          symbolDetail: symbolDetail,
          initialOrderPageStep: OrderPageStep.order,
          availableBuyingPower: 1000,
        ),
        navigatorObservers: [mockObserver],
      ));
    }

    testWidgets('First render order screen', (WidgetTester tester) async {
      await buildDepositWelcomeScreen(tester);
      expect(find.byKey(const Key('dropdown_order_type')), findsOneWidget);
      expect(find.byKey(const Key('order_contents')), findsOneWidget);
      expect(find.byKey(const Key('symbol_title_widget')), findsOneWidget);
      expect(
          find.byKey(const Key('order_confirmation_button')), findsOneWidget);
    });
  });
}
