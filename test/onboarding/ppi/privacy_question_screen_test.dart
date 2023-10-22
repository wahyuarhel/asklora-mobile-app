//import 'dart:math';

// import 'package:asklora_mobile_app/feature/onboarding/ppi/bloc/question/question_bloc.dart';
// import 'package:asklora_mobile_app/feature/onboarding/ppi/domain/fixture.dart';
// import 'package:asklora_mobile_app/feature/onboarding/ppi/domain/question.dart';
// import 'package:asklora_mobile_app/feature/onboarding/ppi/presentation/ppi_screen.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

//import '../../mocks/mocks.dart';

void main() async {
  group('Questions Screen Tests', () {
    // var multipleChoiceQuestionBuilder =
    //     find.byKey(const Key('multiple_choice_question_builder'));
    // var descriptiveQuestionInput =
    //     find.byKey(const Key('descriptive_question_input'));
    // var questionHeader = find.byKey(const Key('question_header'));
    // var questionNavigationButtonWidget =
    //     find.byKey(const Key('question_navigation_button_widget'));
    //
    // var questionNextButton = find.byKey(const Key('question_next_button'));
    // List<Question> privacyQuestions = Fixture.instance.getPrivacyQuestions;
    //
    // Future<void> buildPrivacyQuestionScreen(WidgetTester tester) async {
    //   final mockObserver = MockNavigatorObserver();
    //   await tester.pumpWidget(MaterialApp(
    //     home: const PpiScreen(
    //       questionPageType: QuestionPageType.privacy,
    //       initialQuestionPage: QuestionPageStep.privacy,
    //     ),
    //     navigatorObservers: [mockObserver],
    //   ));
    // }

    ///TODO: Fix this test cases

    /*testWidgets(
        'Rendering Privacy Question Screen and Navigating through privacy question 1-4',
        (tester) async {
      await buildPrivacyQuestionScreen(tester);
      await tester.pumpAndSettle();

      for (int index = 0; index < privacyQuestions.length; index++) {
        if (privacyQuestions[index].questions!.types ==
            QuestionType.choices.value) {
          expect(multipleChoiceQuestionBuilder, findsOneWidget);
          expect(descriptiveQuestionInput, findsNothing);
          expect(questionHeader, findsOneWidget);
          expect(questionNavigationButtonWidget, findsOneWidget);
          expect(questionNextButton, findsOneWidget);
          await tester.pumpAndSettle();
          await tester.tap(
              find.byKey(Key('test-Key-${privacyQuestions[index].uid}-0')));
          await tester.pump();
          await tester.tap(questionNextButton);
          await tester.pump();
        } else if (privacyQuestions[index].questions!.types ==
            QuestionType.descriptive.value) {
          expect(multipleChoiceQuestionBuilder, findsNothing);
          expect(descriptiveQuestionInput, findsOneWidget);
          expect(questionHeader, findsOneWidget);
          expect(questionNavigationButtonWidget, findsOneWidget);
          expect(questionNextButton, findsOneWidget);
          await tester.enterText(descriptiveQuestionInput, 'abc');
          await tester.pump();
          await tester.tap(questionNextButton);
          await tester.pump();
        } else if (privacyQuestions[index].questions!.types ==
            QuestionType.unique.value) {
          var accountInvestibleLiquidAssetsSelect =
              find.byKey(const Key('account_investible_liquid_assets_select'));
          var accountFundingSourceSelect =
              find.byKey(const Key('account_funding_source_select'));
          var accountEmploymentStatusSelect =
              find.byKey(const Key('account_employment_status_select'));
          expect(accountInvestibleLiquidAssetsSelect, findsOneWidget);
          expect(accountFundingSourceSelect, findsOneWidget);
          expect(accountEmploymentStatusSelect, findsOneWidget);
          expect(questionNextButton, findsOneWidget);
          await tester.tap(accountInvestibleLiquidAssetsSelect);
          await tester.pump();
          await tester.tap(find.text('0 - 200,000').last);
          await tester.pump();
          await tester.tap(accountFundingSourceSelect);
          await tester.pump();
          await tester.tap(find.text('investments').last);
          await tester.pump();
          await tester.tap(accountEmploymentStatusSelect);
          await tester.pump();
          await tester.tap(find.text('unemployed').last);
          await tester.pump();
          await tester.tap(questionNextButton);
          await tester.pump();
        }
      }
    });*/
  });
}

// int _randomSelectedIndex(int max) => Random().nextInt(max);
