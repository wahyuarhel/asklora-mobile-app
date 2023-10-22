import 'package:asklora_mobile_app/feature/orders/bloc/order_bloc.dart';
import 'package:asklora_mobile_app/feature/orders/regular/presentation/order_screen.dart';
import 'package:asklora_mobile_app/feature/orders/regular/presentation/widgets/custom_bottom_sheet_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mocks.dart';

void main() {
  group('Trading Hours Widget Test', () {
    Future<void> buildTradingHoursWidget(WidgetTester tester,
        {bool showOnlyInformation = false}) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: BlocProvider(
            create: (_) => OrderBloc(),
            child: TradingHoursWidget(
              showOnlyInformation: showOnlyInformation,
            ),
          ),
        ),
        navigatorObservers: [mockObserver],
      ));
    }

    final tradingHoursButton = find.byKey(const Key('trading_hours_button'));
    final tradingHoursRegularChoice =
        find.byKey(const Key('trading_hours_regular_choice'));
    final tradingHoursExtendedChoice =
        find.byKey(const Key('trading_hours_extended_choice'));
    final tradingHoursBottomSheet =
        find.byKey(const Key('trading_hours_bottom_sheet'));
    final tradingHoursRegularChoiceButton =
        find.byKey(const Key('trading_hours_regular_choice_button'));
    final tradingHoursExtendedChoiceButton =
        find.byKey(const Key('trading_hours_extended_choice_button'));

    testWidgets('First render trading hours widget',
        (WidgetTester tester) async {
      await buildTradingHoursWidget(tester);
      expect(tradingHoursButton, findsOneWidget);
    });

    testWidgets('Tap and show bottom sheet widget',
        (WidgetTester tester) async {
      await buildTradingHoursWidget(tester);
      expect(tradingHoursButton, findsOneWidget);
      await tester.tap(tradingHoursButton);
      await tester.pump();
      expect(tradingHoursBottomSheet, findsOneWidget);
      expect(tradingHoursRegularChoice, findsOneWidget);
      expect(tradingHoursExtendedChoice, findsOneWidget);
    });

    testWidgets('Tap choice day and extended', (WidgetTester tester) async {
      await buildTradingHoursWidget(tester);
      expect(tradingHoursButton, findsOneWidget);
      await tester.tap(tradingHoursButton);
      await tester.pump();
      expect(tradingHoursBottomSheet, findsOneWidget);
      expect(tradingHoursRegularChoice, findsOneWidget);
      expect(tradingHoursExtendedChoice, findsOneWidget);
      await tester.ensureVisible(tradingHoursRegularChoiceButton);
      await tester.pumpAndSettle();
      await tester.tap(tradingHoursRegularChoiceButton);
      await tester.pump();
      expect(
          (tester.widget(tradingHoursRegularChoice)
                  as CustomBottomSheetCardWidget)
              .active,
          isTrue);
      expect(
          (tester.widget(tradingHoursExtendedChoice)
                  as CustomBottomSheetCardWidget)
              .active,
          isFalse);
      await tester.ensureVisible(tradingHoursExtendedChoiceButton);
      await tester.pumpAndSettle();
      await tester.tap(tradingHoursExtendedChoiceButton);
      await tester.pump();
      expect(
          (tester.widget(tradingHoursExtendedChoice)
                  as CustomBottomSheetCardWidget)
              .active,
          isTrue);
      expect(
          (tester.widget(tradingHoursRegularChoice)
                  as CustomBottomSheetCardWidget)
              .active,
          isFalse);
    });

    testWidgets(
        'render only the information with default state tradingHours=extended',
        (WidgetTester tester) async {
      await buildTradingHoursWidget(tester, showOnlyInformation: true);
      expect(tradingHoursButton, findsNothing);
      expect(find.text('Extended'), findsOneWidget);
    });
  });
}
