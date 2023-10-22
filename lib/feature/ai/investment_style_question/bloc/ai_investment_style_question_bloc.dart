import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/ai/component.dart';
import '../../../../core/domain/ai/conversation.dart';
import '../../../../core/domain/base_response.dart';
import '../../../../core/utils/log.dart';
import '../../../../core/utils/storage/shared_preference.dart';
import '../../../../core/utils/storage/storage_keys.dart';
import '../../../onboarding/ppi/domain/fixture.dart';
import '../../../onboarding/ppi/domain/ppi_user_response_request.dart';
import '../../../onboarding/ppi/domain/question.dart';
import '../../../onboarding/ppi/repository/ppi_question_repository.dart';
import '../../../onboarding/ppi/repository/ppi_response_repository.dart';
import '../../../tabs/lora_gpt/repository/lora_gpt_repository.dart';
import '../domain/interaction.dart';
import '../domain/investment_style_question_query_request.dart';
import '../domain/investment_style_question_query_response.dart';

part 'ai_investment_style_question_event.dart';

part 'ai_investment_style_question_state.dart';

class AiInvestmentStyleQuestionBloc extends Bloc<AiInvestmentStyleQuestionEvent,
    AiInvestmentStyleQuestionState> {
  AiInvestmentStyleQuestionBloc(
      {required SharedPreference sharedPreference,
      required LoraGptRepository loraGptRepository,
      required PpiQuestionRepository ppiQuestionRepository,
      required PpiResponseRepository ppiResponseRepository})
      : _sharedPreference = sharedPreference,
        _loraGptRepository = loraGptRepository,
        _ppiQuestionRepository = ppiQuestionRepository,
        _ppiResponseRepository = ppiResponseRepository,
        super(const AiInvestmentStyleQuestionState()) {
    on<InitiateAI>(_onInitiateAI);
    on<QueryChanged>(_onQueryChanged);
    on<SubmitQuery>(_onSubmitQuery);
    on<SubmitAnswer>(_onSubmitAnswer);
    on<NextQuestion>(_onNextQuestion);
    on<ResetSession>(_onResetSession);
    on<FinishChatAnimation>(_onFinishChatAnimation);
    on<SendResultToPpi>(_onSendResultToPpi);
  }

  final SharedPreference _sharedPreference;
  final LoraGptRepository _loraGptRepository;
  final PpiQuestionRepository _ppiQuestionRepository;
  final PpiResponseRepository _ppiResponseRepository;
  late final Fixture? fixture;

  void _onInitiateAI(InitiateAI onEditQuery,
      Emitter<AiInvestmentStyleQuestionState> emit) async {
    final userName =
        await _sharedPreference.readData(StorageKeys.sfKeyPpiName) ?? 'Me';
    final askloraId =
        await _sharedPreference.readIntData(StorageKeys.sfKeyAskloraId);
    final tempList = List<Conversation>.of(state.conversations);
    final ppiAccountId =
        await _sharedPreference.readData(StorageKeys.sfKeyPpiAccountId) ?? '';
    emit(state.copyWith(
        sessionId: '',
        userName: userName,
        userId: askloraId.toString(),
        isTyping: true,
        conversations: tempList..add(const Loading())));
    fixture = await _ppiQuestionRepository
        .fetchInvestmentStyleQuestionsWithTryCatch(ppiAccountId);
    tempList.removeLast();
    if (fixture != null) {
      add(const SubmitQuery(isNewSession: true));
    } else {
      emit(state.copyWith(
          isTyping: false, conversations: tempList..add(_errorChat)));
    }
  }

  void _onQueryChanged(
      QueryChanged event, Emitter<AiInvestmentStyleQuestionState> emit) {
    emit(state.copyWith(query: event.query));
  }

  void _onNextQuestion(
      NextQuestion event, Emitter<AiInvestmentStyleQuestionState> emit) {
    final tempList = List<Conversation>.of(state.conversations)
      ..removeLast()
      ..add(Me('Keywords saved for botstock search.', state.userName));
    emit(state.copyWith(
        query: '',
        conversations: tempList,
        interaction: const EmptyInteraction()));
    add(const SubmitQuery(answerId: '1'));
  }

  void _onSendResultToPpi(SendResultToPpi event,
      Emitter<AiInvestmentStyleQuestionState> emit) async {
    emit(state.copyWith(ppiResponseState: ResponseState.loading));
    final List<PpiSelectionRequest> ppiSelectionRequest = [];
    final int ppiUserId =
        await _sharedPreference.readIntData(StorageKeys.sfKeyPpiUserId) ?? 0;

    ///mapping question choices with AI ISQ result
    ///quid15 is omnisearch
    ///quid16 is investment horizon (eg : 2 weeks, 3 months, etc)
    ///quid17 is risk preference
    ///quid18 is preferred method
    for (var element in fixture!.getInvestmentStyleQuestion) {
      if (element.questionId == 'quid15' && state.result!.keywords.isNotEmpty) {
        ppiSelectionRequest.add(PpiSelectionRequest(
          userId: ppiUserId,
          questionId: element.questionId!,
          answer: state.result!.keywords.join(', '),
        ));
      } else if (element.questionId == 'quid16' && element.choices != null) {
        String investmentHorizonMapped =
            _investmentHorizon[state.result!.investmentHorizon] ?? '';
        _addAnswerPpi(
            element.choices!.firstWhereOrNull(
                (element) => element.name == investmentHorizonMapped),
            ppiSelectionRequest,
            element.questionId!,
            ppiUserId);
      } else if (element.questionId == 'quid17' && element.choices != null) {
        _addAnswerPpi(
            element.choices!.firstWhereOrNull((element) =>
                element.score == state.result!.riskPreference.toString()),
            ppiSelectionRequest,
            element.questionId!,
            ppiUserId);
      } else if (element.questionId == 'quid18' && element.choices != null) {
        _addAnswerPpi(
            element.choices!.firstWhereOrNull((element) =>
                element.score == state.result!.preferredMethod.toString()),
            ppiSelectionRequest,
            element.questionId!,
            ppiUserId);
      }
    }

    final response =
        await _ppiResponseRepository.addBulkAnswer(ppiSelectionRequest);

    if (response.state == ResponseState.success) {
      emit(state.copyWith(ppiResponseState: ResponseState.success));
    } else {
      emit(state.copyWith(
          conversations: [...state.conversations, _errorChat],
          ppiResponseState: ResponseState.error,
          interaction: const ErrorInteraction()));
    }
  }

  void _addAnswerPpi(
      Choices? choices,
      List<PpiSelectionRequest> ppiUserResponseRequest,
      String questionId,
      int ppiUserId) {
    if (choices != null && choices.id != null) {
      ppiUserResponseRequest.add(PpiSelectionRequest(
        userId: ppiUserId,
        questionId: questionId,
        answer: choices.id!.toString(),
      ));
    } else {
      Logger.log('Exception while processing AI ISQ into PPI ISQ.');
    }
  }

  void _onSubmitAnswer(
      SubmitAnswer event, Emitter<AiInvestmentStyleQuestionState> emit) {
    emit(state.copyWith(
        query: '',
        interaction: const EmptyInteraction(),
        conversations: state.conversations
          ..add(Me(event.answerText, state.userName))));
    add(SubmitQuery(answerId: event.answerId));
  }

  void _onSubmitQuery(
      SubmitQuery event, Emitter<AiInvestmentStyleQuestionState> emit) async {
    final tempList = List<Conversation>.of(state.conversations);

    ///this check is needed to remove NextButton from conversation when
    ///user send a reply instead of pressing next button on Q1
    if (tempList.isNotEmpty && tempList.last is NextButton) {
      tempList.removeLast();
    }
    if (!event.isNewSession && state.query.isNotEmpty) {
      tempList.add(Me(state.query, state.userName));
    }
    tempList.removeWhere((element) => element is Component);

    tempList.add(const Loading());

    final query = state.query;

    emit(state.copyWith(
      query: '',
      isTyping: true,
      conversations: tempList,
    ));

    var response = await _loraGptRepository.investmentStyle(
        params: InvestmentStyleQuestionQueryRequest(
            userId: state.userId,
            username: state.userName,
            input: query,
            start: event.isNewSession,
            answer: int.parse(event.answerId)));

    tempList.removeLast();
    if (response.state == ResponseState.success) {
      tempList.add(Lora(response.data!.response));

      if (_isFirstQuestion(response) && response.data!.components.isNotEmpty) {
        tempList.addAll(response.data!.components);
      }

      ///show next button on question 1
      if (_isNeedToAddNextButton(response)) {
        tempList.add(const NextButton());
      }

      ///save the result to the state on question 5
      if (_isNeedToSaveResult(response)) {
        emit(state.copyWith(
            result: response.data!.investmentStyleQuestionProgress
                .investmentStyleQuestionResult));
      }
      emit(state.copyWith(
        isChatAnimationRunning: true,
        isTyping: false,
        conversations: tempList,
        interaction: _getInteraction(response.data!.choices,
            response.data!.investmentStyleQuestionProgress.currentQuestion),
      ));
    } else {
      tempList.add(_errorChat);
      emit(state.copyWith(
          conversations: tempList,
          isTyping: false,
          interaction: const ErrorInteraction()));
    }
  }

  Conversation get _errorChat => const Lora(
        'Sorry I cannot connect to the server right now, please try again',
      );

  bool _isNeedToAddNextButton(
          BaseResponse<InvestmentStyleQuestionQueryResponse> response) =>
      _isFirstQuestion(response) && response.data!.choices.isNotEmpty;

  bool _isFirstQuestion(
          BaseResponse<InvestmentStyleQuestionQueryResponse> response) =>
      response.data!.investmentStyleQuestionProgress.currentQuestion == 1;

  bool _isNeedToSaveResult(
          BaseResponse<InvestmentStyleQuestionQueryResponse> response) =>
      response.data!.investmentStyleQuestionProgress.currentQuestion == 5;

  ISQInteraction _getInteraction(
      Map<String, String> choices, int currentQuestion) {
    if (currentQuestion == 1) {
      return const TextFieldInteraction();
    } else if (currentQuestion == 5) {
      return const SummaryInteraction();
    } else {
      return ChoicesInteraction(choices);
    }
  }

  void _onResetSession(ResetSession onResetSession,
      Emitter<AiInvestmentStyleQuestionState> emit) {
    emit(state.copyWith(
        conversations: [],
        isTyping: false,
        sessionId: '',
        query: '',
        interaction: const TextFieldInteraction()));
    add(const SubmitQuery(isNewSession: true));
  }

  void _onFinishChatAnimation(FinishChatAnimation onFinishTyping,
          Emitter<AiInvestmentStyleQuestionState> emit) =>
      emit(state.copyWith(isChatAnimationRunning: false, isTyping: false));

  final Map<String, String> _investmentHorizon = {
    '12 months': '1 year',
    '6 months': 'Half a year',
    '3 months': '3 Months',
    '1 month': '1 Month',
    '2 weeks': '2 Weeks'
  };
}
