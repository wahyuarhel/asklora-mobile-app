import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/fixture.dart';
import '../../../domain/question.dart';

part 'privacy_question_event.dart';

part 'privacy_question_state.dart';

class PrivacyQuestionBloc
    extends Bloc<PrivacyQuestionEvent, PrivacyQuestionState> {
  PrivacyQuestionBloc({int initialIndex = 0})
      : _privacyQuestionIndex = initialIndex - 1,
        super(const PrivacyQuestionState()) {
    on<NextQuestion>(_onNavigationStepChanged);
    on<PreviousQuestion>(_onNavigationPop);
  }

  int _privacyQuestionIndex;
  List<Question> privacyQuestions = Fixture.instance.getPrivacyQuestions;

  void _onNavigationStepChanged(
      NextQuestion event, Emitter<PrivacyQuestionState> emit) async {
    ++_privacyQuestionIndex;

    if (_privacyQuestionIndex < privacyQuestions.length) {
      Question question = privacyQuestions[_privacyQuestionIndex];

      if (question.questionType == QuestionType.choices.value) {
        emit(OnNextQuestion<Question>(
          QuestionType.choices,
          question,
          privacyQuestionIndex: _privacyQuestionIndex,
        ));
      } else if (question.questionType == QuestionType.choices.value) {
        emit(OnNextQuestion<Question>(QuestionType.descriptive, question,
            privacyQuestionIndex: _privacyQuestionIndex));
      } else if (question.questionType == QuestionType.descriptive.value) {
        emit(OnNextQuestion<Question>(QuestionType.descriptive, question,
            privacyQuestionIndex: _privacyQuestionIndex));
      } else if (question.questionType == QuestionType.slider.value) {
        emit(OnNextQuestion<Question>(QuestionType.slider, question,
            privacyQuestionIndex: _privacyQuestionIndex));
      }

      /// In case we want to add any extra screens in the PPI section.
      // else if (question.questionType == QuestionType.unique.value) {
      //   emit(OnNextQuestion<Question>(QuestionType.unique, question,
      //       privacyQuestionIndex: _privacyQuestionIndex));
      // }
    } else {
      emit(OnNextResultSuccessScreen());
    }
  }

  void _onNavigationPop(
      PreviousQuestion event, Emitter<PrivacyQuestionState> emit) async {
    --_privacyQuestionIndex;
    if (_privacyQuestionIndex >= 0) {
      Question question = privacyQuestions[_privacyQuestionIndex];
      if (question.questionType == QuestionType.choices.value) {
        emit(OnNextQuestion<Question>(QuestionType.choices, question,
            privacyQuestionIndex: _privacyQuestionIndex));
      } else if (question.questionType == QuestionType.descriptive.value) {
        emit(OnNextQuestion<Question>(QuestionType.descriptive, question,
            privacyQuestionIndex: _privacyQuestionIndex));
      } else if (question.questionType == QuestionType.slider.value) {
        emit(OnNextQuestion<Question>(QuestionType.slider, question,
            privacyQuestionIndex: _privacyQuestionIndex));
      }

      /// In case we want to add any extra screens in the PPI section.
      // else if (question.questionType == QuestionType.unique.value) {
      //   emit(OnNextQuestion<Question>(QuestionType.unique, question,
      //       privacyQuestionIndex: _privacyQuestionIndex));
      // }
    } else if (_privacyQuestionIndex < 0) {
      emit(OnPreviousSignInSuccessScreen());
    }
  }
}
