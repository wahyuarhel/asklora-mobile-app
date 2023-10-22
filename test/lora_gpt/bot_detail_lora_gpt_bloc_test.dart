import 'package:asklora_mobile_app/core/domain/ai/component.dart';
import 'package:asklora_mobile_app/core/domain/ai/conversation.dart';
import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/core/domain/endpoints.dart';
import 'package:asklora_mobile_app/core/utils/storage/shared_preference.dart';
import 'package:asklora_mobile_app/feature/bot_stock/utils/bot_stock_utils.dart';
import 'package:asklora_mobile_app/feature/tabs/bloc/tab_screen_bloc.dart';
import 'package:asklora_mobile_app/feature/tabs/lora_gpt/bloc/lora_gpt_bloc.dart';
import 'package:asklora_mobile_app/feature/tabs/lora_gpt/domain/portfolio_details_request.dart';
import 'package:asklora_mobile_app/feature/tabs/lora_gpt/domain/query_response.dart';
import 'package:asklora_mobile_app/feature/tabs/lora_gpt/repository/lora_gpt_repository.dart';
import 'package:asklora_mobile_app/feature/tabs/utils/tab_util.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'portfolio_lora_gpt_bloc_test.mocks.dart';

@GenerateMocks([LoraGptRepository])
@GenerateMocks([SharedPreference])
void main() async {
  group('Lora Gpt Bloc Tests', () {
    late MockLoraGptRepository loraGptRepository;
    late MockSharedPreference sharedPreferences;
    late LoraGptBloc loraGptBloc;

    const String username = 'Anton';
    const String someQuery = 'something';
    const Me meWithSomeText = Me(someQuery, username);
    const Me meWithEmptyText = Me('', username);

    TabPage tabPage = TabPage.forYou.setData(arguments: (
      path: SubTabPage.recommendationsBotStockDetails.value,
      arguments: {
        'botType': BotType.plank.internalName,
        'symbol': 'AAPL.O',
        'ticker': 'AAPL',
        'duration': '2 weeks'
      }
    ));

    PortfolioDetailsRequest portfolioDetailsRequest = PortfolioDetailsRequest(
      ticker: tabPage.getArguments.arguments['ticker'],
      input: '',
      userId: '',
      username: username,
      platform: aiPlatform,
      botType: tabPage.getArguments.arguments['botType'],
      tickerSymbol: tabPage.getArguments.arguments['symbol'],
      duration: tabPage.getArguments.arguments['duration'],
    );

    PortfolioDetailsRequest portfolioDetailWithSomeQueryRequest =
        PortfolioDetailsRequest(
      ticker: tabPage.getArguments.arguments['ticker'],
      input: someQuery,
      userId: '',
      username: username,
      platform: aiPlatform,
      botType: tabPage.getArguments.arguments['botType'],
      tickerSymbol: tabPage.getArguments.arguments['symbol'],
      duration: tabPage.getArguments.arguments['duration'],
    );

    final String botDetailDebugWithEmptyQuery =
        'endpoint : $endpointPortfolioDetailPage\nparam : ${portfolioDetailsRequest.params}';

    final String botDetailDebugWithSomeQuery =
        'endpoint : $endpointPortfolioDetailPage\nparam : ${portfolioDetailWithSomeQueryRequest.params}';

    const String result =
        't is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout';

    const PromptButton promptButtonA = PromptButton('a', 'a');
    const PromptButton promptButtonB = PromptButton('b', 'b');
    const PromptButton promptButtonADisabledCallback =
        PromptButton('a', 'a', isNeedCallback: false);
    const PromptButton promptButtonBDisabledCallback =
        PromptButton('b', 'b', isNeedCallback: false);

    final BaseResponse<QueryResponse> failedQueryResponse =
        BaseResponse.error();

    final BaseResponse<QueryResponse> fullQueryResponse = BaseResponse.complete(
        const QueryResponse('a', 'b', 'c', false,
            results: [result], components: [promptButtonA, promptButtonB]));
    final BaseResponse<QueryResponse> resultOnlyQueryResponse =
        BaseResponse.complete(
            const QueryResponse('a', 'b', 'c', false, results: [result]));
    final BaseResponse<QueryResponse> componentOnlyQueryResponse =
        BaseResponse.complete(const QueryResponse('a', 'b', 'c', false,
            components: [promptButtonA, promptButtonB]));

    final BaseResponse<QueryResponse> emptyQueryResponse =
        BaseResponse.complete(const QueryResponse(
      'a',
      'b',
      'c',
      false,
    ));

    setUpAll(() async {
      loraGptRepository = MockLoraGptRepository();
      sharedPreferences = MockSharedPreference();
    });

    setUp(() async {
      loraGptBloc = LoraGptBloc(
        loraGptRepository: loraGptRepository,
        sharedPreference: sharedPreferences,
      );
    });

    test('Lora Gpt Bloc init state response should be default one', () {
      expect(
          loraGptBloc.state,
          const LoraGptState(
            debugText: '',
            query: '',
            sessionId: '',
            status: ResponseState.unknown,
            userName: '',
            userId: '',
            conversations: [],
            isTypingAnimationDone: true,
            botstocks: [],
            totalPnl: 0,
            tabPage: TabPage.forYou,
          ));
    });

    blocTest<LoraGptBloc, LoraGptState>(
      'open bot detail chat AI and send empty chat'
      'then get full response',
      build: () {
        when(loraGptRepository.portfolioDetails(
          params: portfolioDetailsRequest,
        )).thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(StoreTabPage(tabPage: tabPage));
        await Future.delayed(Duration.zero);
        bloc.add(const OnSearchQuery());
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: const [meWithEmptyText]),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText, Lora(result)],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText, Lora(result)],
            debugText: botDetailDebugWithEmptyQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
            ],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonA
            ],
            debugText: botDetailDebugWithEmptyQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback
            ],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonB
            ],
            debugText: botDetailDebugWithEmptyQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ],
            debugText: botDetailDebugWithEmptyQuery),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'open bot detail chat AI and send empty chat'
      'then get result only response',
      build: () {
        when(loraGptRepository.portfolioDetails(
          params: portfolioDetailsRequest,
        )).thenAnswer((_) async => Future.value(resultOnlyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(StoreTabPage(tabPage: tabPage));
        await Future.delayed(Duration.zero);
        bloc.add(const OnSearchQuery());
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
      },
      expect: () => {
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: const [meWithEmptyText]),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText, Lora(result)],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText, Lora(result)],
            debugText: botDetailDebugWithEmptyQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
            ],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
            ],
            debugText: botDetailDebugWithEmptyQuery),
      },
    );
    blocTest<LoraGptBloc, LoraGptState>(
      'open bot detail chat AI and send empty chat'
      'then get components only response',
      build: () {
        when(loraGptRepository.portfolioDetails(
          params: portfolioDetailsRequest,
        )).thenAnswer((_) async => Future.value(componentOnlyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(StoreTabPage(tabPage: tabPage));
        await Future.delayed(Duration.zero);
        bloc.add(const OnSearchQuery());
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: const [meWithEmptyText]),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText, promptButtonA],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText, promptButtonA],
            debugText: botDetailDebugWithEmptyQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              promptButtonADisabledCallback
            ],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              promptButtonADisabledCallback,
              promptButtonB
            ],
            debugText: botDetailDebugWithEmptyQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: const [
              meWithEmptyText,
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ],
            debugText: botDetailDebugWithEmptyQuery),
      },
    );
    blocTest<LoraGptBloc, LoraGptState>(
      'open bot detail chat AI and send empty chat'
      'then get empty response',
      build: () {
        when(loraGptRepository.portfolioDetails(
          params: portfolioDetailsRequest,
        )).thenAnswer((_) async => Future.value(emptyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(StoreTabPage(tabPage: tabPage));
        await Future.delayed(Duration.zero);
        bloc.add(const OnSearchQuery());
      },
      expect: () => {
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: const [meWithEmptyText]),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: const [meWithEmptyText],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: const [meWithEmptyText],
            debugText: botDetailDebugWithEmptyQuery),
      },
    );
    blocTest<LoraGptBloc, LoraGptState>(
      'open bot detail chat AI and send empty chat'
      'then get failed response',
      build: () {
        when(loraGptRepository.portfolioDetails(
          params: portfolioDetailsRequest,
        )).thenAnswer((_) async => Future.value(failedQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(StoreTabPage(tabPage: tabPage));
        await Future.delayed(Duration.zero);
        bloc.add(const OnSearchQuery());
        await Future.delayed(Duration.zero);
        bloc.add(OnFinishTyping(LoraError(LoraError.message())));
      },
      expect: () => {
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: const [meWithEmptyText]),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [meWithEmptyText, LoraError(LoraError.message())],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [meWithEmptyText, LoraError(LoraError.message())],
            debugText: botDetailDebugWithEmptyQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              LoraError(LoraError.message(), isNeedCallback: false)
            ],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: [
              meWithEmptyText,
              LoraError(LoraError.message(), isNeedCallback: false)
            ],
            debugText: botDetailDebugWithEmptyQuery),
      },
    );

    ///#########################

    blocTest<LoraGptBloc, LoraGptState>(
      'open bot detail chat AI, type `something` and send the chat '
      'then get full response',
      build: () {
        when(loraGptRepository.portfolioDetails(
          params: portfolioDetailWithSomeQueryRequest,
        )).thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(StoreTabPage(tabPage: tabPage));
        await Future.delayed(Duration.zero);
        bloc.add(const OnEditQuery(someQuery));
        await Future.delayed(Duration.zero);
        bloc.add(const OnSearchQuery());
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        LoraGptState(
            query: someQuery,
            userName: username,
            tabPage: tabPage,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: const []),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: const [meWithSomeText]),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText, Lora(result)],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText, Lora(result)],
            debugText: botDetailDebugWithSomeQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithSomeText,
              Lora(result, isNeedCallback: false),
            ],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithSomeText,
              Lora(result, isNeedCallback: false),
              promptButtonA
            ],
            debugText: botDetailDebugWithSomeQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithSomeText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback
            ],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithSomeText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonB
            ],
            debugText: botDetailDebugWithSomeQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithSomeText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: const [
              meWithSomeText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ],
            debugText: botDetailDebugWithSomeQuery),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'open bot detail chat AI, type `something` and send the chat '
      'then get result only response',
      build: () {
        when(loraGptRepository.portfolioDetails(
          params: portfolioDetailWithSomeQueryRequest,
        )).thenAnswer((_) async => Future.value(resultOnlyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(StoreTabPage(tabPage: tabPage));
        await Future.delayed(Duration.zero);
        bloc.add(const OnEditQuery(someQuery));
        await Future.delayed(Duration.zero);
        bloc.add(const OnSearchQuery());
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
      },
      expect: () => {
        LoraGptState(
            query: someQuery,
            userName: username,
            tabPage: tabPage,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: const []),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: const [meWithSomeText]),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText, Lora(result)],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText, Lora(result)],
            debugText: botDetailDebugWithSomeQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithSomeText,
              Lora(result, isNeedCallback: false),
            ],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: const [
              meWithSomeText,
              Lora(result, isNeedCallback: false),
            ],
            debugText: botDetailDebugWithSomeQuery),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'open bot detail chat AI, type `something` and send the chat '
      'then get components only response',
      build: () {
        when(loraGptRepository.portfolioDetails(
          params: portfolioDetailWithSomeQueryRequest,
        )).thenAnswer((_) async => Future.value(componentOnlyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(StoreTabPage(tabPage: tabPage));
        await Future.delayed(Duration.zero);
        bloc.add(const OnEditQuery(someQuery));
        await Future.delayed(Duration.zero);
        bloc.add(const OnSearchQuery());
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        LoraGptState(
            query: someQuery,
            userName: username,
            tabPage: tabPage,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: const []),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: const [meWithSomeText]),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText, promptButtonA],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText, promptButtonA],
            debugText: botDetailDebugWithSomeQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithSomeText,
              promptButtonADisabledCallback
            ],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithSomeText,
              promptButtonADisabledCallback,
              promptButtonB
            ],
            debugText: botDetailDebugWithSomeQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithSomeText,
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: const [
              meWithSomeText,
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ],
            debugText: botDetailDebugWithSomeQuery),
      },
    );
    blocTest<LoraGptBloc, LoraGptState>(
      'open bot detail chat AI, type `something` and send the chat '
      'then get empty response',
      build: () {
        when(loraGptRepository.portfolioDetails(
          params: portfolioDetailWithSomeQueryRequest,
        )).thenAnswer((_) async => Future.value(emptyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(StoreTabPage(tabPage: tabPage));
        await Future.delayed(Duration.zero);
        bloc.add(const OnEditQuery(someQuery));
        await Future.delayed(Duration.zero);
        bloc.add(const OnSearchQuery());
      },
      expect: () => {
        LoraGptState(
            query: someQuery,
            userName: username,
            tabPage: tabPage,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: const []),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: const [meWithSomeText]),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: const [
              meWithSomeText,
            ],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: const [
              meWithSomeText,
            ],
            debugText: botDetailDebugWithSomeQuery),
      },
    );
    blocTest<LoraGptBloc, LoraGptState>(
      'open bot detail chat AI, type `something` and send the chat '
      'then get failed response',
      build: () {
        when(loraGptRepository.portfolioDetails(
          params: portfolioDetailWithSomeQueryRequest,
        )).thenAnswer((_) async => Future.value(failedQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(StoreTabPage(tabPage: tabPage));
        await Future.delayed(Duration.zero);
        bloc.add(const OnEditQuery(someQuery));
        await Future.delayed(Duration.zero);
        bloc.add(const OnSearchQuery());
        await Future.delayed(Duration.zero);
        bloc.add(OnFinishTyping(LoraError(LoraError.message())));
      },
      expect: () => {
        LoraGptState(
            query: someQuery,
            userName: username,
            tabPage: tabPage,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: const []),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: const [meWithSomeText]),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [meWithSomeText, LoraError(LoraError.message())],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [meWithSomeText, LoraError(LoraError.message())],
            debugText: botDetailDebugWithSomeQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithSomeText,
              LoraError(LoraError.message(), isNeedCallback: false)
            ],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: tabPage,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: [
              meWithSomeText,
              LoraError(LoraError.message(), isNeedCallback: false)
            ],
            debugText: botDetailDebugWithSomeQuery),
      },
    );

    tearDown(() => {loraGptBloc.close()});
  });
}
