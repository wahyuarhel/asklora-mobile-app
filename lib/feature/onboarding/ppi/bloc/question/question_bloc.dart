import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/domain/base_response.dart';
import '../../domain/fixture.dart';
import '../../repository/ppi_question_repository.dart';

part 'question_event.dart';

part 'question_state.dart';

enum QuestionPageStep {
  privacy,
  privacyResultSuccess,
  privacyResultFailed,
  personalisation,
  personalisationResultEnd,
  unknown
}

enum QuestionPageType { privacy, personalisation }

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  QuestionBloc({
    required PpiQuestionRepository ppiQuestionRepository,
    required QuestionPageType questionPageType,
  })  : _questionCollectionRepository = ppiQuestionRepository,
        _questionPageType = questionPageType,
        super(const QuestionState()) {
    on<LoadQuestions>(_onLoadQuestions);
    on<PrivacyQuestionIndexChanged>(_onPrivacyQuestionIndexChanged);
    on<PersonalisationQuestionIndexChanged>(_onPersonalisationIndexChanged);
    on<CurrentPrivacyPageIncremented>(_onCurrentPrivacyPageIncremented);
    on<CurrentPersonalisationPageIncremented>(
        _onCurrentPersonalisationPageIncremented);
    on<CurrentPrivacyPageDecremented>(_onCurrentPrivacyPageDecremented);
    on<CurrentPersonalisationPageDecremented>(
        _onCurrentPersonalisationPageDecremented);
    on<ResetPrivacyAndPersonalisationPage>(
        _onResetPrivacyAndPersonalisationPage);
  }

  final PpiQuestionRepository _questionCollectionRepository;
  final QuestionPageType _questionPageType;

  void _onPrivacyQuestionIndexChanged(
      PrivacyQuestionIndexChanged event, Emitter<QuestionState> emit) {
    emit(state.copyWith(privacyQuestionIndex: event.privacyQuestionIndex));
  }

  void _onPersonalisationIndexChanged(
      PersonalisationQuestionIndexChanged event, Emitter<QuestionState> emit) {
    emit(state.copyWith(
        personalisationQuestionIndex: event.personalisationQuestionIndex));
  }

  void _onLoadQuestions(
      LoadQuestions event, Emitter<QuestionState> emit) async {
    emit(state.copyWith(response: BaseResponse.loading()));
    try {
      final Fixture fixture = await _questionCollectionRepository
          .fetchPersonalAndPrivacyQuestions();

      emit(state.copyWith(response: BaseResponse.complete(fixture)));
      //+1 for privacy result
      int totalPrivacyPages = fixture.getPrivacyQuestions.length + 1;
      emit(state.copyWith(
        response: BaseResponse.complete(fixture),
        currentPrivacyPages: _questionPageType == QuestionPageType.privacy
            ? 1
            : totalPrivacyPages,

        currentPersonalisationPages:
            _questionPageType == QuestionPageType.personalisation ? 1 : 0,
        totalPrivacyPages: totalPrivacyPages,
        //+1 for personalisation result
        totalPersonalisationPages: fixture.getPersonalisedQuestion.length + 1,
      ));
    } catch (e) {
      emit(state.copyWith(response: BaseResponse.error()));
    }
  }

  void _onCurrentPrivacyPageIncremented(
      CurrentPrivacyPageIncremented event, Emitter<QuestionState> emit) async {
    emit(state.copyWith(currentPrivacyPages: state.currentPrivacyPages + 1));
  }

  void _onCurrentPersonalisationPageIncremented(
      CurrentPersonalisationPageIncremented event,
      Emitter<QuestionState> emit) async {
    emit(state.copyWith(
        currentPersonalisationPages: state.currentPersonalisationPages + 1));
  }

  void _onCurrentPrivacyPageDecremented(
      CurrentPrivacyPageDecremented event, Emitter<QuestionState> emit) async {
    emit(state.copyWith(currentPrivacyPages: state.currentPrivacyPages - 1));
  }

  void _onCurrentPersonalisationPageDecremented(
      CurrentPersonalisationPageDecremented event,
      Emitter<QuestionState> emit) async {
    emit(state.copyWith(
        currentPersonalisationPages: state.currentPersonalisationPages - 1));
  }

  void _onResetPrivacyAndPersonalisationPage(
      ResetPrivacyAndPersonalisationPage event,
      Emitter<QuestionState> emit) async {
    emit(state.copyWith(
        currentPersonalisationPages: 0,
        currentPrivacyPages: 0,
        privacyQuestionIndex: 0,
        personalisationQuestionIndex: 0));
  }
}
