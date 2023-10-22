import 'package:asklora_mobile_app/core/domain/ai/component.dart';
import 'package:asklora_mobile_app/core/domain/ai/conversation.dart';
import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/core/domain/endpoints.dart';
import 'package:asklora_mobile_app/core/utils/storage/shared_preference.dart';
import 'package:asklora_mobile_app/feature/tabs/lora_gpt/bloc/lora_gpt_bloc.dart';
import 'package:asklora_mobile_app/feature/tabs/lora_gpt/domain/portfolio_query_request.dart';
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

    const PortfolioQueryRequest portfolioQueryRequest = PortfolioQueryRequest(
      totalPnl: 0,
      input: '',
      userId: '',
      username: username,
      platform: aiPlatform,
    );

    const PortfolioQueryRequest portfolioWithSomeQueryRequest =
        PortfolioQueryRequest(
      totalPnl: 0,
      input: someQuery,
      userId: '',
      username: username,
      platform: aiPlatform,
    );

    final String portfolioDebugWithEmptyQuery =
        'endpoint : $endpointPortfolio\nparam : ${portfolioQueryRequest.params}\npayload : ${[]}';

    final String portfolioDebugWithSomeQuery =
        'endpoint : $endpointPortfolio\nparam : ${portfolioWithSomeQueryRequest.params}\npayload : ${[]}';

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
      'open portfolio chat AI and send empty chat'
      'then get full response',
      build: () {
        when(loraGptRepository.portfolio(
            params: portfolioQueryRequest,
            data: [])).thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(const StoreTabPage(tabPage: TabPage.portfolio));
        await Future.delayed(Duration.zero);
        bloc.add(const OnSearchQuery());
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        const LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: []),
        const LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: [meWithEmptyText]),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText],
            debugText: portfolioDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText],
            debugText: portfolioDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText, Lora(result)],
            debugText: portfolioDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText, Lora(result)],
            debugText: portfolioDebugWithEmptyQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
            ],
            debugText: portfolioDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonA
            ],
            debugText: portfolioDebugWithEmptyQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback
            ],
            debugText: portfolioDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonB
            ],
            debugText: portfolioDebugWithEmptyQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ],
            debugText: portfolioDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ],
            debugText: portfolioDebugWithEmptyQuery),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'open portfolio chat AI and send empty chat'
      'then get result only response',
      build: () {
        when(loraGptRepository
                .portfolio(params: portfolioQueryRequest, data: []))
            .thenAnswer((_) async => Future.value(resultOnlyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(const StoreTabPage(tabPage: TabPage.portfolio));
        await Future.delayed(Duration.zero);
        bloc.add(const OnSearchQuery());
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
      },
      expect: () => {
        const LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: []),
        const LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: [meWithEmptyText]),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText],
            debugText: portfolioDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText, Lora(result)],
            debugText: portfolioDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText, Lora(result)],
            debugText: portfolioDebugWithEmptyQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false)
            ],
            debugText: portfolioDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
            ],
            debugText: portfolioDebugWithEmptyQuery),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'open portfolio chat AI and send empty chat'
      'then get components only response',
      build: () {
        when(loraGptRepository
                .portfolio(params: portfolioQueryRequest, data: []))
            .thenAnswer((_) async => Future.value(componentOnlyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(const StoreTabPage(tabPage: TabPage.portfolio));
        await Future.delayed(Duration.zero);
        bloc.add(const OnSearchQuery());
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        const LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: []),
        const LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: [meWithEmptyText]),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText],
            debugText: portfolioDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              promptButtonA,
            ],
            debugText: portfolioDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              promptButtonA,
            ],
            debugText: portfolioDebugWithEmptyQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              promptButtonADisabledCallback,
            ],
            debugText: portfolioDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              promptButtonADisabledCallback,
              promptButtonB
            ],
            debugText: portfolioDebugWithEmptyQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ],
            debugText: portfolioDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: const [
              meWithEmptyText,
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ],
            debugText: portfolioDebugWithEmptyQuery),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'open portfolio chat AI and send empty chat'
      'then get empty response',
      build: () {
        when(loraGptRepository
                .portfolio(params: portfolioQueryRequest, data: []))
            .thenAnswer((_) async => Future.value(emptyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(const StoreTabPage(tabPage: TabPage.portfolio));
        await Future.delayed(Duration.zero);
        bloc.add(const OnSearchQuery());
      },
      expect: () => {
        const LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: []),
        const LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: [meWithEmptyText]),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
            ],
            debugText: portfolioDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: const [meWithEmptyText],
            debugText: portfolioDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: const [meWithEmptyText],
            debugText: portfolioDebugWithEmptyQuery),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'open portfolio chat AI and send empty chat'
      'then get failed response',
      build: () {
        when(loraGptRepository
                .portfolio(params: portfolioQueryRequest, data: []))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(const StoreTabPage(tabPage: TabPage.portfolio));
        await Future.delayed(Duration.zero);
        bloc.add(const OnSearchQuery());
        await Future.delayed(Duration.zero);
        bloc.add(OnFinishTyping(LoraError(LoraError.message())));
      },
      expect: () => {
        const LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: []),
        const LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: [meWithEmptyText]),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
            ],
            debugText: portfolioDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [meWithEmptyText, LoraError(LoraError.message())],
            debugText: portfolioDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [meWithEmptyText, LoraError(LoraError.message())],
            debugText: portfolioDebugWithEmptyQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              LoraError(LoraError.message(), isNeedCallback: false)
            ],
            debugText: portfolioDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: [
              meWithEmptyText,
              LoraError(LoraError.message(), isNeedCallback: false)
            ],
            debugText: portfolioDebugWithEmptyQuery),
      },
    );

    ///#########################
    blocTest<LoraGptBloc, LoraGptState>(
      'open portfolio chat AI, type `something` and send the chat '
      'then get full response',
      build: () {
        when(loraGptRepository.portfolio(
            params: portfolioWithSomeQueryRequest,
            data: [])).thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(const StoreTabPage(tabPage: TabPage.portfolio));
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
        const LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: []),
        const LoraGptState(
            query: someQuery,
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: []),
        const LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: [meWithSomeText]),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText, Lora(result)],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText, Lora(result)],
            debugText: portfolioDebugWithSomeQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithSomeText,
              Lora(result, isNeedCallback: false),
            ],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithSomeText,
              Lora(result, isNeedCallback: false),
              promptButtonA
            ],
            debugText: portfolioDebugWithSomeQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithSomeText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback
            ],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithSomeText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonB
            ],
            debugText: portfolioDebugWithSomeQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithSomeText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: const [
              meWithSomeText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ],
            debugText: portfolioDebugWithSomeQuery),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'open portfolio chat AI, type `something` and send the chat '
      'then get result only response',
      build: () {
        when(loraGptRepository
                .portfolio(params: portfolioWithSomeQueryRequest, data: []))
            .thenAnswer((_) async => Future.value(resultOnlyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(const StoreTabPage(tabPage: TabPage.portfolio));
        await Future.delayed(Duration.zero);
        bloc.add(const OnEditQuery(someQuery));
        await Future.delayed(Duration.zero);
        bloc.add(const OnSearchQuery());
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
      },
      expect: () => {
        const LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: []),
        const LoraGptState(
            query: someQuery,
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: []),
        const LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: [meWithSomeText]),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText, Lora(result)],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText, Lora(result)],
            debugText: portfolioDebugWithSomeQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithSomeText,
              Lora(result, isNeedCallback: false),
            ],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: const [
              meWithSomeText,
              Lora(result, isNeedCallback: false),
            ],
            debugText: portfolioDebugWithSomeQuery),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'open portfolio chat AI, type `something` and send the chat '
      'then get components only response',
      build: () {
        when(loraGptRepository
                .portfolio(params: portfolioWithSomeQueryRequest, data: []))
            .thenAnswer((_) async => Future.value(componentOnlyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(const StoreTabPage(tabPage: TabPage.portfolio));
        await Future.delayed(Duration.zero);
        bloc.add(const OnEditQuery(someQuery));
        await Future.delayed(Duration.zero);
        bloc.add(const OnSearchQuery());
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        const LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: []),
        const LoraGptState(
            query: someQuery,
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: []),
        const LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: [meWithSomeText]),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText, promptButtonA],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText, promptButtonA],
            debugText: portfolioDebugWithSomeQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithSomeText,
              promptButtonADisabledCallback,
            ],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithSomeText,
              promptButtonADisabledCallback,
              promptButtonB
            ],
            debugText: portfolioDebugWithSomeQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithSomeText,
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: const [
              meWithSomeText,
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ],
            debugText: portfolioDebugWithSomeQuery),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'open portfolio chat AI, type `something` and send the chat '
      'then get empty response',
      build: () {
        when(loraGptRepository
                .portfolio(params: portfolioWithSomeQueryRequest, data: []))
            .thenAnswer((_) async => Future.value(emptyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(const StoreTabPage(tabPage: TabPage.portfolio));
        await Future.delayed(Duration.zero);
        bloc.add(const OnEditQuery(someQuery));
        await Future.delayed(Duration.zero);
        bloc.add(const OnSearchQuery());
      },
      expect: () => {
        const LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: []),
        const LoraGptState(
            query: someQuery,
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: []),
        const LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: [meWithSomeText]),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: const [meWithSomeText],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: const [meWithSomeText],
            debugText: portfolioDebugWithSomeQuery),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'open portfolio chat AI, type `something` and send the chat '
      'then get empty response',
      build: () {
        when(loraGptRepository
                .portfolio(params: portfolioWithSomeQueryRequest, data: []))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(const StoreTabPage(tabPage: TabPage.portfolio));
        await Future.delayed(Duration.zero);
        bloc.add(const OnEditQuery(someQuery));
        await Future.delayed(Duration.zero);
        bloc.add(const OnSearchQuery());
        await Future.delayed(Duration.zero);
        bloc.add(OnFinishTyping(LoraError(LoraError.message())));
      },
      expect: () => {
        const LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: []),
        const LoraGptState(
            query: someQuery,
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: []),
        const LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: [meWithSomeText]),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithSomeText],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [meWithSomeText, LoraError(LoraError.message())],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [meWithSomeText, LoraError(LoraError.message())],
            debugText: portfolioDebugWithSomeQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithSomeText,
              LoraError(LoraError.message(), isNeedCallback: false)
            ],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: [
              meWithSomeText,
              LoraError(LoraError.message(), isNeedCallback: false)
            ],
            debugText: portfolioDebugWithSomeQuery),
      },
    );

    tearDown(() => {loraGptBloc.close()});
  });
}
