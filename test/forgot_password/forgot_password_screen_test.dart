import 'package:asklora_mobile_app/core/presentation/buttons/primary_button.dart';
import 'package:asklora_mobile_app/feature/auth/forgot_password/presentation/forgot_password_screen.dart';
import 'package:asklora_mobile_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/mocks.dart';

void main() {
  group(
    'Forgot Password Screen Widget Test',
    () {
      Future<void> buildForgotPasswordScreen(WidgetTester tester) async {
        final mockObserver = MockNavigatorObserver();
        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            home: const ForgotPasswordScreen(),
            navigatorObservers: [mockObserver],
          ),
        );
      }

      testWidgets(
        'Show Forgot Password Screen with `Email` input field with `Submit` button',
        (tester) async {
          //ARRANGE
          await buildForgotPasswordScreen(tester);
          // ACT & ASSERT
          var emailInput = find.byKey(
            const Key('forgot_password_email_input'),
          );
          expect(emailInput, findsOneWidget);
          var submitButton = find.byKey(
            const Key('forgot_password_submit_button'),
          );
          expect(submitButton, findsOneWidget);
        },
      );

      testWidgets(
          'Render error label on email text field and button disable when entered wrong email.',
          (tester) async {
        await buildForgotPasswordScreen(tester);
        await tester.enterText(
          find.byKey(const Key('forgot_password_email_input')),
          'john.doe',
        );
        var submitButton = find.byKey(
          const Key('forgot_password_submit_button'),
        );
        await tester.pump();

        expect(find.text('john.doe'), findsOneWidget);
        expect(find.text('Enter valid email'), findsOneWidget);
        expect((tester.firstWidget(submitButton) as PrimaryButton).disabled,
            isTrue);
      });

      testWidgets('Enable button when entered valid email.', (tester) async {
        await buildForgotPasswordScreen(tester);
        await tester.enterText(
          find.byKey(const Key('forgot_password_email_input')),
          'asklora@loratechai.com',
        );
        var submitButton = find.byKey(
          const Key('forgot_password_submit_button'),
        );
        await tester.pump();

        expect(find.text('asklora@loratechai.com'), findsOneWidget);
        expect(find.text('Enter valid email'), findsNothing);
        expect((tester.firstWidget(submitButton) as PrimaryButton).disabled,
            isFalse);
      });
    },
  );
}
