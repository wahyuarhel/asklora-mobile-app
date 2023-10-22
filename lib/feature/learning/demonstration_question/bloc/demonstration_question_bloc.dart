import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../onboarding/ppi/domain/fixture.dart';
import '../../../onboarding/ppi/domain/question.dart';
import '../repository/demonstration_question_repository.dart';

part 'demonstration_question_event.dart';

part 'demonstration_question_state.dart';

class DemonstrationQuestionBloc
    extends Bloc<DemonstrationQuestionEvent, DemonstrationQuestionState> {
  DemonstrationQuestionBloc(
      {required DemonstrationQuestionRepository
          demonstrationQuestionRepository})
      : _demonstrationQuestionRepository = demonstrationQuestionRepository,
        super(const DemonstrationQuestionState()) {
    on<FetchQuestion>(_onFetchQuestion);
    on<NextQuestion>(_onNextQuestion);
    on<PreviousQuestion>(_onPreviousQuestion);
    on<AnswerQuestion>(_onAnswerQuestion);
  }

  final DemonstrationQuestionRepository _demonstrationQuestionRepository;

  void _onFetchQuestion(
      FetchQuestion event, Emitter<DemonstrationQuestionState> emit) async {
    List<Question> questionCollection =
        await _demonstrationQuestionRepository.fetchQuestions();
    emit(state.copyWith(
        questionCollection: questionCollection,
        questionAnsweredList:
            _getDefaultQuestionAnsweredList(questionCollection)));
  }

  List<bool> _getDefaultQuestionAnsweredList(
      List<Question> questionCollection) {
    List<bool> defaultQuestionAnsweredList = [];
    for (int i = 0; i < questionCollection.length; i++) {
      if (questionCollection[i].questionType == QuestionType.omniSearch.value) {
        defaultQuestionAnsweredList.add(true);
      } else {
        defaultQuestionAnsweredList.add(false);
      }
    }
    return defaultQuestionAnsweredList;
  }

  void _onNextQuestion(
      NextQuestion event, Emitter<DemonstrationQuestionState> emit) {
    int questionIndex = state.questionIndex + 1;
    if (questionIndex < state.questionCollection.length) {
      emit(state.copyWith(
        questionIndex: questionIndex,
      ));
    }
  }

  void _onAnswerQuestion(
      AnswerQuestion event, Emitter<DemonstrationQuestionState> emit) {
    List<bool> questionAnsweredList = List.from(state.questionAnsweredList);
    questionAnsweredList[event.questionIndex] = true;
    emit(state.copyWith(questionAnsweredList: questionAnsweredList));
  }

  void _onPreviousQuestion(
      PreviousQuestion event, Emitter<DemonstrationQuestionState> emit) {
    int questionIndex = state.questionIndex - 1;
    if (questionIndex >= 0) {
      emit(state.copyWith(questionIndex: questionIndex));
    }
  }
}
