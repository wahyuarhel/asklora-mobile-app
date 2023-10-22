import 'package:asklora_mobile_app/feature/orders/bloc/order_bloc.dart';
import 'package:asklora_mobile_app/feature/orders/regular/presentation/order_screen.dart';
import 'package:asklora_mobile_app/feature/orders/regular/presentation/widgets/custom_bottom_sheet_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mocks.dart';

void main() {
  group('Time in Force Widget Test', () {
    Future<void> buildTimeInForceWidget(WidgetTester tester,
        {bool showOnlyInformation = false}) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: BlocProvider(
            create: (_) => OrderBloc(),
            child: TimeInForceWidget(
              showOnlyInformation: showOnlyInformation,
            ),
          ),
        ),
        navigatorObservers: [mockObserver],
      ));
    }

    final timeInForceButton = find.byKey(const Key('time_in_force_button'));
    final timeInForceDayChoice =
        find.byKey(const Key('time_in_force_day_choice'));
    final timeInForceGoodTillCancelledChoice =
        find.byKey(const Key('time_in_force_good_till_cancelled_choice'));
    final timeInForceBottomSheet =
        find.byKey(const Key('time_in_force_bottom_sheet'));
    final timeInForceDayChoiceButton =
        find.byKey(const Key('time_in_force_day_choice_button'));
    final timeInForceGoodTillCancelledChoiceButton = find
        .byKey(const Key('time_in_force_good_till_cancelled_choice_button'));

    testWidgets('First render time in force widget',
        (WidgetTester tester) async {
      await buildTimeInForceWidget(tester);
      expect(timeInForceButton, findsOneWidget);
    });

    testWidgets('Tap and show bottom sheet widget',
        (WidgetTester tester) async {
      await buildTimeInForceWidget(tester);
      expect(timeInForceButton, findsOneWidget);
      await tester.tap(timeInForceButton);
      await tester.pump();
      expect(timeInForceBottomSheet, findsOneWidget);
      expect(timeInForceDayChoice, findsOneWidget);
      expect(timeInForceDayChoice, findsOneWidget);
    });

    testWidgets('Tap choice day and good till cancelled',
        (WidgetTester tester) async {
      await buildTimeInForceWidget(tester);
      expect(timeInForceButton, findsOneWidget);
      await tester.tap(timeInForceButton);
      await tester.pump();
      expect(timeInForceBottomSheet, findsOneWidget);
      expect(timeInForceDayChoice, findsOneWidget);
      expect(timeInForceDayChoice, findsOneWidget);
      await tester.ensureVisible(timeInForceDayChoiceButton);
      await tester.pumpAndSettle();
      await tester.tap(timeInForceDayChoiceButton);
      await tester.pump();
      expect(
          (tester.widget(timeInForceDayChoice) as CustomBottomSheetCardWidget)
              .active,
          isTrue);
      expect(
          (tester.widget(timeInForceGoodTillCancelledChoice)
                  as CustomBottomSheetCardWidget)
              .active,
          isFalse);
      await tester.ensureVisible(timeInForceGoodTillCancelledChoiceButton);
      await tester.pumpAndSettle();
      await tester.tap(timeInForceGoodTillCancelledChoiceButton);
      await tester.pump();
      expect(
          (tester.widget(timeInForceGoodTillCancelledChoice)
                  as CustomBottomSheetCardWidget)
              .active,
          isTrue);
      expect(
          (tester.widget(timeInForceDayChoice) as CustomBottomSheetCardWidget)
              .active,
          isFalse);
    });

    testWidgets(
        'render only the information with default state timeInForce=Day',
        (WidgetTester tester) async {
      await buildTimeInForceWidget(tester, showOnlyInformation: true);
      expect(timeInForceButton, findsNothing);
      expect(find.text('Day'), findsOneWidget);
    });
  });
}
