import 'package:asklora_mobile_app/core/presentation/buttons/primary_button.dart';
import 'package:asklora_mobile_app/feature/onboarding/welcome/ask_name/presentation/ask_name_screen.dart';
import 'package:asklora_mobile_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/mocks.dart';

void main() {
  group(
    'Lora Ask Name Screen Widget Test',
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
          home: const AskNameScreen(),
          navigatorObservers: [mockObserver],
        ));
      }

      var nameInput = find.byKey(
        const Key('name_input'),
      );

      var nextButton = find.byKey(
        const Key('next_button'),
      );

      testWidgets(
          'Show Lora Ask Name screen with memoji, name input, disabled next button',
          (WidgetTester tester) async {
        await buildCarouselScreen(tester);
        await tester.pumpAndSettle();
        expect(nameInput, findsOneWidget);
        expect(nextButton, findsOneWidget);
        expect(
            (tester.firstWidget(nextButton) as PrimaryButton).disabled, isTrue);
        expect(nameInput, findsOneWidget);
      });

      testWidgets(
          'input name with `Anton` then find text `Anton` on screen with enabled next button',
          (WidgetTester tester) async {
        await buildCarouselScreen(tester);
        await tester.pumpAndSettle();
        await tester.enterText(
          nameInput,
          'Anton',
        );
        await tester.pump();
        expect(find.text('Anton'), findsOneWidget);
        expect((tester.firstWidget(nextButton) as PrimaryButton).disabled,
            isFalse);
      });
    },
  );
}
