// import 'dart:math';
//
// import 'package:asklora_mobile_app/feature/onboarding/ppi/bloc/question/question_bloc.dart';
// import 'package:asklora_mobile_app/feature/onboarding/ppi/domain/fixture.dart';
// import 'package:asklora_mobile_app/feature/onboarding/ppi/domain/question.dart';
// import 'package:asklora_mobile_app/feature/onboarding/ppi/presentation/ppi_screen.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// import '../../mocks/mocks.dart';

void main() {
  group('Personalisation Question Screen Test', () {
    // var multipleChoiceQuestionBuilder =
    //     find.byKey(const Key('multiple_choice_question_builder'));
    // var descriptiveQuestionInput =
    //     find.byKey(const Key('descriptive_question_input'));
    // var questionHeader = find.byKey(const Key('question_header'));
    // var questionNavigationButtonWidget =
    //     find.byKey(const Key('question_navigation_button_widget'));
    // var questionNextButton = find.byKey(const Key('question_next_button'));
    //
    // List<Question> personalisedQuestions =
    //     Fixture.instance.getPersonalisedQuestion;
    // Future<void> builderPersonalisationQuestionScreen(
    //     WidgetTester tester) async {
    //   final mockObserver = MockNavigatorObserver();
    //   await tester.pumpWidget(MaterialApp(
    //     home: const PpiScreen(
    //       questionPageType: QuestionPageType.privacy,
    //       initialQuestionPage: QuestionPageStep.personalisation,
    //     ),
    //     navigatorObservers: [mockObserver],
    //   ));
    // }

    ///TODO: Fix this test cases

    /*testWidgets(
        'Rendering Personalisation Question Screen and Navigation through personalisation question 1-3',
        (tester) async {
      await builderPersonalisationQuestionScreen(tester);
      await tester.pumpAndSettle();

      for (int index = 0; index < personalisedQuestions.length; index++) {
        if (personalisedQuestions[index].questions!.types ==
            QuestionType.choices.value) {
          expect(multipleChoiceQuestionBuilder, findsOneWidget);
          expect(descriptiveQuestionInput, findsNothing);
          expect(questionHeader, findsOneWidget);
          expect(questionNavigationButtonWidget, findsOneWidget);
          expect(questionNextButton, findsOneWidget);
          await tester.pumpAndSettle();
          await tester.tap(find.byKey(Key(
              '${personalisedQuestions[index].uid}-${_randomSelectedIndex(personalisedQuestions[index].questions!.choices!.length)}')));
          await tester.pump();
          await tester.tap(questionNextButton);
          await tester.pump();
        } else if (personalisedQuestions[index].questions!.types ==
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
        }
      }
    });*/
  });
}

// int _randomSelectedIndex(int max) => Random().nextInt(max);
