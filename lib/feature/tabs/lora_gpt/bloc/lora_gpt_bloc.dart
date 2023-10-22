import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/ai/component.dart';
import '../../../../core/domain/ai/conversation.dart';
import '../../../../core/domain/base_response.dart';
import '../../../../core/domain/endpoints.dart';
import '../../../../core/utils/bloc_transformer/sequential.dart';
import '../../../../core/utils/storage/shared_preference.dart';
import '../../../../core/utils/storage/storage_keys.dart';
import '../../../bot_stock/utils/bot_stock_utils.dart';
import '../../bloc/tab_screen_bloc.dart';
import '../../utils/tab_util.dart';
import '../domain/portfolio_details_request.dart';
import '../domain/portfolio_query_request.dart';
import '../domain/query_request.dart';
import '../domain/query_response.dart';
import '../repository/lora_gpt_repository.dart';

part 'lora_gpt_event.dart';

part 'lora_gpt_state.dart';

class LoraGptBloc extends Bloc<LoraGptEvent, LoraGptState> {
  LoraGptBloc(
      {required this.loraGptRepository,
      required SharedPreference sharedPreference})
      : _sharedPreference = sharedPreference,
        super(const LoraGptState()) {
    on<OnEditQuery>(_onEditQuery);
    on<OnPromptTap>(_onPromptTap);
    on<OnLoraOpened>(_onLoraOpened);
    on<OnResetSession>(_onResetSession);
    on<OnStartTyping>(_onStartTyping);
    on<OnFinishTyping>(_onFinishTyping);
    on<OnAiOverlayClose>(_onAiOverlayClose);
    on<FetchIntros>(onFetchIntros);
    on<OnSearchQuery>(_onSearchQuery);
    on<StoreLora>(_onStoreLora);
    on<SubmitLora>(_onSubmitLora, transformer: sequential());
  }

  final LoraGptRepository loraGptRepository;
  final SharedPreference _sharedPreference;
  final List<Conversation> _conversationQueue = [];
  final Set<BotstockIntro> _botIntroQueryHistory = {};

  void onFetchIntros(FetchIntros event, Emitter<LoraGptState> emit) async {
    if (_isBotDetailsSubPage) {
      final BotstockIntro params = state.getIntroRequest(
          botType:
              BotType.findByValue(_tabPageArguments.arguments['botType']).name,
          tickerSymbol: _tabPageArguments.arguments['symbol'],
          investmentHorizon: _tabPageArguments.arguments['duration'],
          ticker: _tabPageArguments.arguments['ticker']);

      if (!_botIntroQueryHistory.contains(params)) {
        _botIntroQueryHistory.add(params);
        add(SubmitLora(future: loraGptRepository.botIntro(params: params)));
        add(SubmitLora(future: loraGptRepository.botEarnings(params: params)));
      }
    }
  }

  void _onLoraOpened(OnLoraOpened event, Emitter<LoraGptState> emit) async {
    final userName =
        await _sharedPreference.readData(StorageKeys.sfKeyPpiName) ?? 'Me';
    final askloraId =
        await _sharedPreference.readIntData(StorageKeys.sfKeyAskloraId);

    emit(state.copyWith(
        status: ResponseState.loading,
        conversations: [],
        sessionId: '',
        userName: userName,
        userId: askloraId.toString()));
  }

  void _onEditQuery(OnEditQuery event, Emitter<LoraGptState> emit) =>
      emit(state.copyWith(query: event.query));

  void _onPromptTap(OnPromptTap event, Emitter<LoraGptState> emit) {
    emit(state.copyWith(query: event.query));
    add(const OnSearchQuery());
  }

  void _onStartTyping(OnStartTyping event, Emitter<LoraGptState> emit) =>
      emit(state.copyWith(isTypingAnimationDone: false));

  void _onFinishTyping(OnFinishTyping event, Emitter<LoraGptState> emit) {
    final Conversation lastConversation = event.conversation;

    if (lastConversation.isNeedCallback) {
      List<Conversation> tempList = List<Conversation>.of(state.conversations);
      switch (lastConversation) {
        case final Lora conversation:
          tempList.remove(lastConversation);
          tempList.add(conversation.copyWith(isNeedCallback: false));
        case final PromptButton conversation:
          tempList.remove(lastConversation);
          tempList.add(conversation.copyWith(isNeedCallback: false));
        case final Loading conversation:
          tempList.remove(lastConversation);
          tempList.add(conversation.copyWith(isNeedCallback: false));
      }
      emit(state.copyWith(conversations: [...tempList]));
    }

    if (_conversationQueue.isNotEmpty) {
      _addConversationQueueToScreen(emit);
    } else if (_conversationQueue.isEmpty &&
        state.conversations.last is! Loading &&
        !state.conversations.last.isNeedCallback) {
      emit(state.copyWith(isTypingAnimationDone: true));
    }
  }

  void _onSubmitLora(SubmitLora event, Emitter<LoraGptState> emit) async {
    emit(state.copyWith(
        isTypingAnimationDone: false,
        status: ResponseState.loading,
        debugText: event.debugText));

    _addLoadingToQueues();
    _addConversationQueueToScreen(emit);

    var response = await event.future;
    _removeLoadingFromConversations(emit);
    _addConversationToQueues(response, emit,
        showErrorChat: event.isShowErrorChat);
    _addConversationQueueToScreen(emit);

    emit(state.copyWith(
      status: ResponseState.success,
    ));
  }

  void _onSearchQuery(OnSearchQuery event, Emitter<LoraGptState> emit) async {
    final tempList = List<Conversation>.of(state.conversations);

    _removeComponentFromConversations(tempList);
    _addMeToConversations(tempList);

    final LoraGptState tempState = state;
    emit(state.copyWith(query: '', conversations: tempList));

    if (_isBotDetailsSubPage) {
      PortfolioDetailsRequest request = tempState.getPortfolioDetailsRequest;
      add(SubmitLora(
          debugText:
              'endpoint : $endpointPortfolioDetailPage\nparam : ${request.params}',
          future: loraGptRepository.portfolioDetails(params: request),
          isShowErrorChat: true));
    } else if (_isPortfolioPage) {
      PortfolioQueryRequest request = tempState.getPortfolioRequest;
      add(SubmitLora(
          debugText:
              'endpoint : $endpointPortfolio\nparam : ${request.params}\npayload : ${tempState.botstocks}',
          future: loraGptRepository.portfolio(
              params: request, data: tempState.botstocks),
          isShowErrorChat: true));
    } else {
      GeneralQueryRequest request = tempState.getGeneralChatRequest;
      add(SubmitLora(
          debugText: 'endpoint : $endpointChat\nparam : ${request.params}',
          future: loraGptRepository.general(params: request),
          isShowErrorChat: true));
    }
  }

  void _onResetSession(OnResetSession event, Emitter<LoraGptState> emit) =>
      emit(state.copyWith(
          status: ResponseState.success,
          conversations: [],
          sessionId: '',
          query: ''));

  void _onAiOverlayClose(OnAiOverlayClose event, Emitter<LoraGptState> emit) {
    final tempList = List<Conversation>.of(state.conversations);
    _removeComponentFromConversations(tempList);
    emit(
        state.copyWith(conversations: tempList, status: ResponseState.unknown));
  }

  void _onStoreLora(StoreLora event, Emitter<LoraGptState> emit) {
    switch (event) {
      case final StorePortfolioDetails event:
        emit(state.copyWith(
            totalPnl: event.totalPortfolioPnl, status: ResponseState.unknown));
        break;
      case final StorePortfolio event:
        emit(state.copyWith(
            botstocks: event.botstocks, status: ResponseState.unknown));
        break;
      case final StoreTabPage event:
        emit(state.copyWith(
            tabPage: event.tabPage, status: ResponseState.unknown));
        break;
    }
  }

  void _addConversationQueueToScreen(Emitter<LoraGptState> emit) {
    if (_conversationQueue.isNotEmpty &&
        (_conversationQueue.first is Loading &&
                state.conversations.isNotEmpty &&
                !state.conversations.last.isNeedCallback ||
            _conversationQueue.first is Loading &&
                state.conversations.isEmpty ||
            state.conversations.isNotEmpty &&
                !state.conversations.last.isNeedCallback ||
            state.conversations.isEmpty)) {
      emit(state.copyWith(conversations: [
        ...List.from(state.conversations)..add(_conversationQueue.first)
      ]));
      _conversationQueue.remove(_conversationQueue.first);
    }
  }

  void _removeComponentFromConversations(
      List<Conversation> currentConversations) {
    currentConversations.removeWhere((element) => element is Component);
  }

  void _addMeToConversations(List<Conversation> currentConversations) {
    currentConversations.add(Me(state.query, state.userName));
  }

  void _addConversationToQueues(
      BaseResponse<QueryResponse> response, Emitter<LoraGptState> emit,
      {bool showErrorChat = false}) {
    if (response.state == ResponseState.success &&
        (response.data!.results!.isNotEmpty ||
            response.data!.components.isNotEmpty)) {
      String result = response.data!.getResult();
      if (result.isNotEmpty) {
        _conversationQueue.add(Lora(result));
      }
      if (response.data!.components.isNotEmpty) {
        _conversationQueue.addAll(response.data!.components);
      }
    } else if (response.state == ResponseState.error && showErrorChat) {
      _conversationQueue.add(LoraError(LoraError.message()));
    } else if (_conversationQueue.isEmpty &&
        (state.conversations.isNotEmpty &&
                state.conversations.last is! Loading &&
                !state.conversations.last.isNeedCallback ||
            state.conversations.isEmpty)) {
      emit(state.copyWith(isTypingAnimationDone: true));
    }
  }

  void _addLoadingToQueues() {
    _conversationQueue.add(const Loading());
  }

  void _removeLoadingFromConversations(Emitter<LoraGptState> emit) {
    _conversationQueue.remove(const Loading());
    emit(state.copyWith(
        conversations: [...state.conversations..remove(const Loading())]));
  }

  bool get _isBotDetailsSubPage {
    return _tabPageArguments.path.isNotEmpty &&
            _tabPageArguments.path ==
                SubTabPage.portfolioBotStockDetails.value ||
        _tabPageArguments.path ==
            SubTabPage.recommendationsBotStockDetails.value;
  }

  ({String path, Map<String, dynamic> arguments}) get _tabPageArguments =>
      state.tabPage.getArguments;

  bool get _isPortfolioPage => state.tabPage == TabPage.portfolio;
}
