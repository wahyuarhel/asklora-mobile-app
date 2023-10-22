import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/fixture.dart';
import '../../../domain/question.dart';

part 'personalisation_question_event.dart';

part 'personalisation_question_state.dart';

class PersonalisationQuestionBloc
    extends Bloc<PersonalisationQuestionEvent, PersonalisationQuestionState> {
  PersonalisationQuestionBloc({int initialIndex = 0})
      : _personalizationIndex = initialIndex - 1,
        super(const PersonalisationQuestionState()) {
    on<NextPersonalisationQuestion>(_onNavigationStepChanged);
    on<PreviousPersonalisationQuestion>(_onNavigationPop);
  }

  int _personalizationIndex;
  List<Question> personalizationQuestions =
      Fixture.instance.getPersonalisedQuestion;

  void _onNavigationStepChanged(NextPersonalisationQuestion event,
      Emitter<PersonalisationQuestionState> emit) {
    ++_personalizationIndex;
    if (_personalizationIndex < personalizationQuestions.length) {
      Question question = personalizationQuestions[_personalizationIndex];
      if (question.questionType == QuestionType.choices.value) {
        emit(OnNextPersonalizationQuestion<Question>(
            QuestionType.choices, question,
            personalizationQuestionIndex: _personalizationIndex));
      } else if (question.questionType == QuestionType.choices.value) {
        emit(OnNextPersonalizationQuestion<Question>(
            QuestionType.descriptive, question,
            personalizationQuestionIndex: _personalizationIndex));
      } else if (question.questionType == QuestionType.descriptive.value) {
        emit(OnNextPersonalizationQuestion<Question>(
            QuestionType.descriptive, question,
            personalizationQuestionIndex: _personalizationIndex));
      } else if (question.questionType == QuestionType.slider.value) {
        emit(OnNextPersonalizationQuestion<Question>(
            QuestionType.slider, question,
            personalizationQuestionIndex: _personalizationIndex));
      }

      /// In case we want to add any extra screens in the PPI section.
      // else if (question.questionType == QuestionType.unique.value) {
      //   emit(OnNextPersonalizationQuestion<Question>(
      //       QuestionType.unique, question,
      //       personalizationQuestionIndex: _personalizationIndex));
      // }
    } else {
      emit(OnNextResultEndScreen());
    }
  }

  void _onNavigationPop(PreviousPersonalisationQuestion event,
      Emitter<PersonalisationQuestionState> emit) {
    --_personalizationIndex;
    if (_personalizationIndex >= 0) {
      Question question = personalizationQuestions[_personalizationIndex];
      if (question.questionType == QuestionType.choices.value) {
        emit(OnNextPersonalizationQuestion<Question>(
            QuestionType.choices, question,
            personalizationQuestionIndex: _personalizationIndex));
      } else if (question.questionType == QuestionType.descriptive.value) {
        emit(OnNextPersonalizationQuestion<Question>(
            QuestionType.descriptive, question,
            personalizationQuestionIndex: _personalizationIndex));
      } else if (question.questionType == QuestionType.slider.value) {
        emit(OnNextPersonalizationQuestion<Question>(
            QuestionType.slider, question,
            personalizationQuestionIndex: _personalizationIndex));
      }
    } else if (_personalizationIndex < 0) {
      emit(OnPreviousToPrivacyQuestionScreen());
    }
  }
}
