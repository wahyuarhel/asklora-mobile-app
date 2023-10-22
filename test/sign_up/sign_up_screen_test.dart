import 'package:asklora_mobile_app/core/presentation/buttons/primary_button.dart';
import 'package:asklora_mobile_app/feature/auth/sign_up/presentation/sign_up_screen.dart';
import 'package:asklora_mobile_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/mocks.dart';

void main() async {
  group('Sign Up Screen Widget Tests', () {
    Future<void> buildHomeScreen(WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(MaterialApp(
        home: const SignUpScreen(),
        localizationsDelegates: const [
          S.delegate,
        ],
        navigatorObservers: [mockObserver],
      ));
      await tester.pumpAndSettle();
    }

    testWidgets(
        'Render Sign-Up screen with `Username`, `Password`, `Submit` button and password instructions',
        (tester) async {
      await buildHomeScreen(tester);
      var emailInput = find.byKey(const Key('sign_up_email_input'));
      expect(emailInput, findsOneWidget);
      var passwordInput = find.byKey(const Key('sign_up_password_input'));
      expect(passwordInput, findsOneWidget);
      var signUpButton = find.byKey(const Key('sign_up_submit_button'));
      expect(signUpButton, findsOneWidget);
    });

    testWidgets('Not entering anything', (tester) async {
      await buildHomeScreen(tester);

      //password instruction should be greyed and icon should be ❗
      expect(find.text(S.current.min8Character), findsNothing);
      expect(find.text(S.current.atLeast1Lowercase), findsNothing);
      expect(find.text(S.current.atLeast1Uppercase), findsNothing);
      expect(find.text(S.current.atLeast1Number), findsNothing);

      //signUpButton should be disabled
      var signUpButton = find.byKey(const Key('sign_up_submit_button'));
      expect(
          (tester.firstWidget(signUpButton) as PrimaryButton).disabled, isTrue);
    });

    testWidgets('Entering wrong email format', (tester) async {
      await buildHomeScreen(tester);
      await tester.enterText(
          find.byKey(const Key('sign_up_email_input')), 'kkkkk');
      await tester.pump();

      expect(find.text('kkkkk'), findsOneWidget);
      expect(find.text('Enter valid email'), findsOneWidget);

      //signUpButton should be disabled
      var signUpButton = find.byKey(const Key('sign_up_submit_button'));
      expect(
          (tester.firstWidget(signUpButton) as PrimaryButton).disabled, isTrue);
    });

    testWidgets('Entering wrong password format', (tester) async {
      await buildHomeScreen(tester);
      await tester.enterText(
          find.byKey(const Key('sign_up_password_input')), 'kkkkk');
      await tester.pump();

      expect(find.text('kkkkk'), findsOneWidget);

      expect(find.text(S.current.min8Character), findsOneWidget);
      expect(find.text(S.current.atLeast1Lowercase), findsOneWidget);
      expect(find.text(S.current.atLeast1Uppercase), findsOneWidget);
      expect(find.text(S.current.atLeast1Number), findsOneWidget);

      //signUpButton should be disabled
      var signUpButton = find.byKey(const Key('sign_up_submit_button'));
      expect(
          (tester.firstWidget(signUpButton) as PrimaryButton).disabled, isTrue);
    });

    testWidgets('Entering correct email but wrong password format',
        (tester) async {
      await buildHomeScreen(tester);
      await tester.enterText(
          find.byKey(const Key('sign_up_email_input')), 'testing@xyz.com');
      await tester.enterText(
          find.byKey(const Key('sign_up_password_input')), 'kkkkk');
      await tester.pump();

      expect(find.text('testing@xyz.com'), findsOneWidget);
      expect(find.text('kkkkk'), findsOneWidget);
      expect(find.text('Enter valid email'), findsNothing);

      //password instruction should be greyed and icon should be ❗

      expect(find.text(S.current.min8Character), findsOneWidget);
      expect(find.text(S.current.atLeast1Lowercase), findsOneWidget);
      expect(find.text(S.current.atLeast1Uppercase), findsOneWidget);
      expect(find.text(S.current.atLeast1Number), findsOneWidget);

      //signUpButton should be disabled
      var signUpButton = find.byKey(const Key('sign_up_submit_button'));
      expect(
          (tester.firstWidget(signUpButton) as PrimaryButton).disabled, isTrue);
    });

    testWidgets('Entering wrong email but correct password format',
        (tester) async {
      await buildHomeScreen(tester);
      await tester.enterText(
          find.byKey(const Key('sign_up_email_input')), 'kkkkk');
      await tester.enterText(
          find.byKey(const Key('sign_up_password_input')), 'Testing123');
      await tester.pump();

      expect(find.text('Testing123'), findsOneWidget);
      expect(find.text('kkkkk'), findsOneWidget);
      expect(find.text('Enter valid email'), findsOneWidget);

      //password instruction should be bluegrey and icon should be ✅
      expect(find.text(S.current.min8Character), findsOneWidget);
      expect(find.text(S.current.atLeast1Lowercase), findsOneWidget);
      expect(find.text(S.current.atLeast1Uppercase), findsOneWidget);
      expect(find.text(S.current.atLeast1Number), findsOneWidget);

      //signUpButton should be disabled
      var signUpButton = find.byKey(const Key('sign_up_submit_button'));
      expect(
          (tester.firstWidget(signUpButton) as PrimaryButton).disabled, isTrue);
    });

    testWidgets('Entering correct email and correct password format',
        (tester) async {
      await buildHomeScreen(tester);
      await tester.enterText(
          find.byKey(const Key('sign_up_email_input')), 'testing@xyz.com');
      await tester.enterText(
          find.byKey(const Key('sign_up_password_input')), 'Testing123');
      await tester.pump();

      expect(find.text('testing@xyz.com'), findsOneWidget);
      expect(find.text('Testing123'), findsOneWidget);
      expect(find.text('Enter valid email'), findsNothing);

      //password instruction should be bluegrey and icon should be ✅
      expect(find.text(S.current.min8Character), findsOneWidget);
      expect(find.text(S.current.atLeast1Lowercase), findsOneWidget);
      expect(find.text(S.current.atLeast1Uppercase), findsOneWidget);
      expect(find.text(S.current.atLeast1Number), findsOneWidget);

      //signUpButton should be disabled
      var signUpButton = find.byKey(const Key('sign_up_submit_button'));

      expect((tester.firstWidget(signUpButton) as PrimaryButton).disabled,
          isFalse);
    });
  });
}
