import 'dart:math';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/remote/base_api_client.dart';
import '../../../../../core/domain/base_response.dart';
import '../../../../../core/domain/pair.dart';
import '../../../../../core/domain/triplet.dart';
import '../../../../../core/utils/log.dart';
import '../../../../../core/utils/storage/cache/json_cache_shared_preferences.dart';
import '../../../../../core/utils/storage/shared_preference.dart';
import '../../../../../core/utils/storage/storage_keys.dart';
import '../../domain/fixture.dart';
import '../../domain/ppi_user_response.dart';
import '../../domain/ppi_user_response_request.dart';
import '../../domain/question.dart';
import '../../presentation/widget/omni_search_question_widget/bloc/omni_search_question_widget_bloc.dart';
import '../../repository/ppi_response_repository.dart';

part 'user_response_event.dart';

part 'user_response_state.dart';

class UserResponseBloc extends Bloc<UserResponseEvent, UserResponseState> {
  UserResponseBloc({
    required PpiResponseRepository ppiResponseRepository,
    required SharedPreference sharedPreference,
    required JsonCacheSharedPreferences jsonCacheSharedPreferences,
  })  : _ppiResponseRepository = ppiResponseRepository,
        _sharedPreference = sharedPreference,
        _jsonCacheSharedPreferences = jsonCacheSharedPreferences,
        super(UserResponseState(userResponse: List.empty(growable: true))) {
    on<UserResponseEvent>((event, emit) {});
    on<SendResponse>(_onSendAnswer);
    on<SkipResponse>(_onSkipResponse);
    on<UpdatePpiUserResponse>(_onUpdatePpiUserResponse);
    on<SendBulkResponse>(_onSendBulkResponse);
    on<SaveUserResponse>(_onUserResponseSave);
    on<SaveOmniSearchResponse>(_onSaveOmniSearchResponse);
    on<CalculateScore>(_onCalculateScore);
    on<ResetState>(_onResetState);
    on<InitiateUserResponse>(_onInitiateUserResponse);
    on<ReSendResponse>(_onReSendBulkResponse);
  }

  final PpiResponseRepository _ppiResponseRepository;
  final SharedPreference _sharedPreference;
  final JsonCacheSharedPreferences _jsonCacheSharedPreferences;

  void _onResetState(ResetState event, Emitter<UserResponseState> emit) async {
    if (event.wholeState) {
      emit(UserResponseState(userResponse: List.empty(growable: true)));
    } else {
      emit(state.copyWith(
          responseState: ResponseState.unknown,
          ppiResponseState: PpiResponseState.finishAddResponse));
    }
  }

  void _onSendAnswer(
      SendResponse event, Emitter<UserResponseState> emit) async {
    emit(state.copyWith(responseState: ResponseState.loading));

    final response =
        await _ppiResponseRepository.addAnswer(event.ppiUserResponseRequest);

    if (response.state == ResponseState.success) {
      emit(state.copyWith(
        responseState: ResponseState.success,
      ));
    } else {
      emit(state.copyWith(responseState: ResponseState.error));
    }
  }

  void _onUserResponseSave(
      SaveUserResponse event, Emitter<UserResponseState> emit) async {
    emit(state.copyWith(
        ppiResponseState: PpiResponseState.initAddResponse,
        responseState: ResponseState.loading));

    state.userResponse
        ?.removeWhere((element) => element.left == event.question.questionId);
    state.userResponse?.add(Triplet(
        event.question.questionId!, event.question, event.selectedAnswer));

    emit(state.copyWith(
        ppiResponseState: PpiResponseState.finishAddResponse,
        responseState: ResponseState.success));
  }

  void _onSaveOmniSearchResponse(
      SaveOmniSearchResponse event, Emitter<UserResponseState> emit) async {
    emit(state.copyWith(
        ppiResponseState: PpiResponseState.initAddResponse,
        responseState: ResponseState.loading));
    emit(state.copyWith(
        cachedDefaultChoices: List.from(event.cachedDefaultChoices),
        cachedSelectedChoices: List.from(event.cachedSelectedChoices),
        ppiResponseState: PpiResponseState.finishAddResponse,
        responseState: ResponseState.success));
  }

  void _onSkipResponse(
      SkipResponse event, Emitter<UserResponseState> emit) async {
    emit(state.copyWith(responseState: ResponseState.loading));
    emit(state.copyWith(responseState: ResponseState.success));
  }

  void _onInitiateUserResponse(
      InitiateUserResponse event, Emitter<UserResponseState> emit) async {
    emit(state.copyWith(
        ppiResponseState: PpiResponseState.initAddResponse,
        responseState: ResponseState.loading));
    var snapshot = await _ppiResponseRepository.getUserSnapShotFromLocal();
    if (snapshot != null) {
      List<Question> questions = Fixture().getInvestmentStyleQuestion;
      for (var e in questions) {
        Answer? answer = snapshot.scores.answers.firstWhereOrNull(
            (element) => element.question?.questionId == e.questionId);
        if (answer != null) {
          if (answer.question?.section ==
                  QuestionSection.investmentStyle.value &&
              answer.question?.questionType == QuestionType.choices.value) {
            state.userResponse
                ?.add(Triplet(e.questionId!, e, answer.id.toString()));
          } else if (answer.question?.section ==
              QuestionSection.omniSearch.value) {
            List<String> selectedChoices = answer.answer!.split(',');
            List<String> defaultChoices =
                List.of(defaultKeywords, growable: true);

            for (var e in selectedChoices) {
              if (!defaultKeywords.contains(e)) {
                defaultChoices.add(e);
              }
            }

            emit(state.copyWith(
                cachedDefaultChoices: defaultChoices,
                cachedSelectedChoices: selectedChoices));
          }
        }
      }
    }
    emit(state.copyWith(
        ppiResponseState: PpiResponseState.finishAddResponse,
        responseState: ResponseState.success));
  }

  void _onUpdatePpiUserResponse(
      UpdatePpiUserResponse event, Emitter<UserResponseState> emit) async {
    emit(state);
  }

  void _onCalculateScore(
      CalculateScore event, Emitter<UserResponseState> emit) async {
    emit(state.copyWith(
      responseState: ResponseState.loading,
      ppiResponseState: PpiResponseState.calculate,
    ));
    final result = await _isNotEligible();
    emit(state.copyWith(
      responseState: result ? ResponseState.error : ResponseState.success,
      ppiResponseState: PpiResponseState.calculate,
    ));
  }

  void _onSendBulkResponse(
      SendBulkResponse event, Emitter<UserResponseState> emit) async {
    try {
      emit(state.copyWith(
        responseState: ResponseState.loading,
        ppiResponseState: PpiResponseState.dispatchResponse,
      ));

      final tempId =
          await _sharedPreference.readIntData(StorageKeys.sfKeyPpiUserId) ?? 0;

      var requests = _getAllSelectionsInRequest(tempId);

      if (requests.isEmpty) {
        final cachedResponse = await _jsonCacheSharedPreferences
            .value(StorageKeys.sfKeyPpiAnswers);
        requests = List<PpiSelectionRequest>.from((cachedResponse)
            .map((e) => PpiSelectionRequest.fromJson(e, tempId)));
      } else {
        await _jsonCacheSharedPreferences.refresh(
            StorageKeys.sfKeyPpiAnswers, requests);
      }

      final response = await _ppiResponseRepository.addBulkAnswer(requests);

      if (response.state == ResponseState.success) {
        var userSnapShot =
            await _ppiResponseRepository.getUserSnapShotUserId(tempId);
        emit(state.copyWith(
          responseState: ResponseState.success,
          ppiResponseState: PpiResponseState.dispatchResponse,
          snapShot: userSnapShot,
        ));
      } else {
        emit(state.copyWith(
            responseState: ResponseState.error,
            ppiResponseState: PpiResponseState.dispatchResponse,
            message: 'Something went wrong! Please try again.',
            errorType: ErrorType.error400));
      }
    } on BadRequestException {
      emit(state.copyWith(
          responseState: ResponseState.error,
          ppiResponseState: PpiResponseState.dispatchResponse,
          message: 'Something went wrong! Please try again.',
          errorType: ErrorType.error400));
    } catch (e) {
      emit(state.copyWith(
          responseState: ResponseState.error,
          ppiResponseState: PpiResponseState.dispatchResponse,
          message: 'Something went wrong! Please try again.',
          errorType: ErrorType.error500));
    }
  }

  void _onReSendBulkResponse(
          ReSendResponse event, Emitter<UserResponseState> emit) async =>
      add(SendBulkResponse());

  Future<bool> _isNotEligible() async {
    final scores = await _calculate();
    return scores.left < 3 || scores.right < 3;
  }

  /// Assuming the last index (4) is for age. In case anything changes happen
  /// in the PPI questioner we need to update this logic.
  /// References:
  ///   A5 -> Age,
  ///   3rd index of list is "Risk Level" question.
  ///   4th index of list is age question.
  ///   Calculation Reference: https://loratechai.atlassian.net/wiki/spaces/SPD/pages/1144619026/PPI+Calculation
  /// Returns a Pair<Suitability Score, Objective Score> of Suitability Score and Objective Score
  Future<Pair<num, num>> _calculate() {
    if (state.userResponse != null && state.userResponse!.isNotEmpty) {
      final int age = int.parse(state.userResponse![4].right);
      final List<num> scores = List.empty(growable: true);

      Logger.log('age $age');

      for (var e in state.userResponse!) {
        String? score = e.middle.choices
                ?.firstWhereOrNull(
                    (element) => element.id.toString() == e.right)
                ?.score ??
            '0';
        scores.add(num.parse(score));
      }

      Logger.log('scores $scores');

      var ageScore = (6 - pow(age / 33, 2));

      Logger.log('ageScore before $ageScore');

      ageScore = ageScore <= 1
          ? 1
          : ageScore >= 5.5
              ? 5.5
              : ageScore;

      Logger.log('ageScore after $ageScore');

      scores.removeWhere((element) => element == 0);
      scores.add(ageScore);

      Logger.log('scores after adding age $scores');

      final mean = scores.reduce((a, b) => a + b) / scores.length;

      Logger.log('mean $mean');

      final maxOfScores = scores.reduce(max);

      Logger.log('maxOfScores $maxOfScores');

      var suitabilityScore = (mean + maxOfScores) / 2;

      Logger.log('suitabilityScore $suitabilityScore');

      final objectiveScore = scores[3];

      Logger.log('objectiveScore $objectiveScore');

      suitabilityScore = min(suitabilityScore, (objectiveScore + 0.5));

      Logger.log('min objectiveScore $objectiveScore');

      Logger.log(
          'suitabilityScore $suitabilityScore objectiveScore $objectiveScore');

      // this condition for identify user's age
      // if user's age < 18 we return with 0 score;
      if (age < 18) {
        return Future.value(const Pair(0, 0));
      } else {
        return Future.value(Pair(suitabilityScore, objectiveScore));
      }
    } else {
      return Future.value(const Pair(0, 0));
    }
  }

  List<PpiSelectionRequest> _getAllSelectionsInRequest(int id) =>
      state.userResponse
          ?.map((e) => PpiSelectionRequest(
              questionId: e.left, userId: id, answer: e.right))
          .toList() ??
      [];
}
