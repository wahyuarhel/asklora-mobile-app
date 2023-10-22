import 'package:asklora_mobile_app/core/presentation/buttons/primary_button.dart';
import 'package:asklora_mobile_app/feature/onboarding/welcome/greeting/greeting_screen.dart';
import 'package:asklora_mobile_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/mocks.dart';

void main() {
  group(
    'Greeting Screen Widget Test',
    () {
      Future<void> buildCarouselScreen(WidgetTester tester) async {
        final mockObserver = MockNavigatorObserver();
        await tester.pumpWidget(MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: const GreetingScreen(name: 'Anton'),
          navigatorObservers: [mockObserver],
        ));
      }

      var nextButton = find.byKey(
        const Key('next_button'),
      );

      testWidgets('Show Greeting screen with memoji and next button',
          (WidgetTester tester) async {
        await buildCarouselScreen(tester);
        await tester.pumpAndSettle();
        expect(nextButton, findsOneWidget);
        expect((tester.firstWidget(nextButton) as PrimaryButton).disabled,
            isFalse);
      });
    },
  );
}
