import 'package:asklora_mobile_app/core/presentation/buttons/primary_button.dart';
import 'package:asklora_mobile_app/feature/auth/sign_in/presentation/sign_in_screen.dart';
import 'package:asklora_mobile_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/mocks.dart';

void main() {
  group(
    'Sign In Screen Widget Test',
    () {
      Future<void> buildSignInScreen(WidgetTester tester) async {
        final mockObserver = MockNavigatorObserver();
        await tester.pumpWidget(MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: const SignInScreen(),
          navigatorObservers: [mockObserver],
        ));
      }

      testWidgets(
          'Show Sign in screen with email input, password input, and login button ',
          (WidgetTester tester) async {
        // ARRANGE
        await buildSignInScreen(tester);
        // ACT & ASSERT
        var emailInput = find.byKey(
          const Key('sign_in_email_input'),
        );
        expect(emailInput, findsOneWidget);
        var passwordInput = find.byKey(
          const Key('sign_in_password_input'),
        );
        expect(passwordInput, findsOneWidget);
        var forgotPasswordButton = find.byKey(
          const Key('forgot_password_button'),
        );
        expect(forgotPasswordButton, findsOneWidget);
        var loginButton = find.byKey(
          const Key('sign_in_submit_button'),
        );
        expect(loginButton, findsOneWidget);
      });

      testWidgets('Render errol label on email', (tester) async {
        await buildSignInScreen(tester);
        await tester.enterText(
            find.byKey(const Key('sign_in_email_input')), 'qweasdzxc');
        var loginButton = find.byKey(const Key('sign_in_submit_button'));
        await tester.pump();

        expect(find.text('qweasdzxc'), findsOneWidget);
        expect(find.text('Enter valid email'), findsOneWidget);
        expect(tester.widget<PrimaryButton>(loginButton).disabled, isTrue);
      });

      testWidgets('Enable button when entered valid email.', (tester) async {
        await buildSignInScreen(tester);
        await tester.enterText(
          find.byKey(const Key('sign_in_email_input')),
          'wahyu@loratechai.com',
        );
        await tester.enterText(
          find.byKey(const Key('sign_in_password_input')),
          'Test123',
        );
        var submitButton = find.byKey(
          const Key('sign_in_submit_button'),
        );
        await tester.pump();

        expect(find.text('wahyu@loratechai.com'), findsOneWidget);
        expect(find.text('Test123'), findsOneWidget);
        expect(find.text('Enter valid email'), findsNothing);
        expect(tester.widget<PrimaryButton>(submitButton).disabled, isFalse);
      });
    },
  );
}
