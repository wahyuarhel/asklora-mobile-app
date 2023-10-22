import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/base_response.dart';
import '../../../../../core/domain/pair.dart';
import '../../../../../core/utils/storage/shared_preference.dart';
import '../../../../../core/utils/storage/storage_keys.dart';
import '../../../../onboarding/ppi/domain/fixture.dart';
import '../../../../onboarding/ppi/domain/question.dart';
import '../../../../onboarding/ppi/repository/ppi_question_repository.dart';

part 'for_you_question_event.dart';

part 'for_you_question_state.dart';

class ForYouQuestionBloc
    extends Bloc<ForYouQuestionEvent, ForYouQuestionState> {
  ForYouQuestionBloc(
      {required PpiQuestionRepository ppiQuestionRepository,
      required SharedPreference sharedPreference})
      : _ppiQuestionRepository = ppiQuestionRepository,
        _sharedPreference = sharedPreference,
        super(const ForYouQuestionState()) {
    on<LoadQuestion>(_onLoadQuestion);
  }

  final PpiQuestionRepository _ppiQuestionRepository;
  final SharedPreference _sharedPreference;

  void _onLoadQuestion(
      LoadQuestion event, Emitter<ForYouQuestionState> emit) async {
    emit(state.copyWith(response: BaseResponse.loading()));
    try {
      final Fixture fixture =
          await _ppiQuestionRepository.fetchInvestmentStyleQuestions(
              await _sharedPreference.readData(StorageKeys.sfKeyPpiAccountId) ??
                  '');
      List<Question> data = fixture.getInvestmentStyleQuestion;
      if (data.isNotEmpty) {
        Question? omniSearchQuestion;
        List<Question> otherQuestions = [];
        for (var element in data) {
          if (element.questionType == QuestionType.omniSearch.value) {
            omniSearchQuestion = element;
          } else {
            otherQuestions.add(element);
          }
        }
        emit(state.copyWith(
            response: BaseResponse.complete(
                Pair(omniSearchQuestion, otherQuestions))));
      } else {
        emit(state.copyWith(response: BaseResponse.error()));
      }
    } catch (e) {
      emit(state.copyWith(response: BaseResponse.error()));
    }
  }
}
