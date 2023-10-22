import 'package:asklora_mobile_app/core/domain/ai/component.dart';
import 'package:asklora_mobile_app/core/domain/ai/conversation.dart';
import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/core/domain/endpoints.dart';
import 'package:asklora_mobile_app/core/utils/storage/shared_preference.dart';
import 'package:asklora_mobile_app/feature/bot_stock/utils/bot_stock_utils.dart';
import 'package:asklora_mobile_app/feature/tabs/bloc/tab_screen_bloc.dart';
import 'package:asklora_mobile_app/feature/tabs/lora_gpt/bloc/lora_gpt_bloc.dart';
import 'package:asklora_mobile_app/feature/tabs/lora_gpt/domain/portfolio_details_request.dart';
import 'package:asklora_mobile_app/feature/tabs/lora_gpt/domain/portfolio_query_request.dart';
import 'package:asklora_mobile_app/feature/tabs/lora_gpt/domain/query_request.dart';
import 'package:asklora_mobile_app/feature/tabs/lora_gpt/domain/query_response.dart';
import 'package:asklora_mobile_app/feature/tabs/lora_gpt/repository/lora_gpt_repository.dart';
import 'package:asklora_mobile_app/feature/tabs/utils/tab_util.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'extended_case_lora_gpt_bloc_test.mocks.dart';

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

    const GeneralQueryRequest generalChatRequest = GeneralQueryRequest(
      input: '',
      userId: '',
      username: username,
      platform: aiPlatform,
      sessionId: '',
    );

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

    late final TabPage portfolioDetailTabPage;

    late final PortfolioDetailsRequest portfolioDetailsRequest;

    late final PortfolioDetailsRequest portfolioDetailWithSomeQueryRequest;

    final String portfolioDebugWithEmptyQuery =
        'endpoint : $endpointPortfolio\nparam : ${portfolioQueryRequest.params}\npayload : ${[]}';

    final String portfolioDebugWithSomeQuery =
        'endpoint : $endpointPortfolio\nparam : ${portfolioWithSomeQueryRequest.params}\npayload : ${[]}';

    final String generalDebugWithEmptyQuery =
        'endpoint : $endpointChat\nparam : ${generalChatRequest.params}';

    late final String botDetailDebugWithEmptyQuery;

    late final String botDetailDebugWithSomeQuery;

    final BotstockIntro botRequest = BotstockIntro(
        botType: BotType.plank.name,
        tickerSymbol: 'symbol',
        investmentHorizon: 'duration',
        ticker: 'ticker',
        userId: 'userId',
        platform: aiPlatform,
        username: 'userName');

    const String result =
        't is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout';

    const PromptButton promptButtonA = PromptButton('a', 'a');
    const PromptButton promptButtonB = PromptButton('b', 'b');
    const PromptButton promptButtonADisabledCallback =
        PromptButton('a', 'a', isNeedCallback: false);
    const PromptButton promptButtonBDisabledCallback =
        PromptButton('b', 'b', isNeedCallback: false);

    final BaseResponse<QueryResponse> fullQueryResponse = BaseResponse.complete(
        const QueryResponse('a', 'b', 'c', false,
            results: [result], components: [promptButtonA, promptButtonB]));

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

    ///BOT GENERAL CHAT CASE AND INTRO AI
    blocTest<LoraGptBloc, LoraGptState>(
      'open general chat and send some query, then close ai and open bot details'
      'it should trigger bot intro just after general chat responding'
      '-bot intro fetch completed after general chat animation done-',
      build: () {
        when(loraGptRepository.general(params: generalChatRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(const OnSearchQuery());
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        await Future.delayed(Duration.zero);
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        const LoraGptState(
          userName: username,
          status: ResponseState.unknown,
          isTypingAnimationDone: true,
          conversations: [meWithEmptyText],
        ),
        LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText],
            debugText: generalDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText, Lora(result)],
            debugText: generalDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText, Lora(result)],
            debugText: generalDebugWithEmptyQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false)
            ],
            debugText: generalDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonA,
            ],
            debugText: generalDebugWithEmptyQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
            ],
            debugText: generalDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonB
            ],
            debugText: generalDebugWithEmptyQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ],
            debugText: generalDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ],
            debugText: generalDebugWithEmptyQuery),

        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
            ]),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result)
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result)
            ]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonA
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),

        ///FETCH BOT EARNINGS
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result)
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result)
            ]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false)
            ]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonA
            ]),

        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback
            ]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonB
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
      },
    );

    ///BOT PORTFOLIO CHAT CASE AND INTRO AI
    blocTest<LoraGptBloc, LoraGptState>(
      'open portfolio chat and send some query, then close ai and open bot details'
      'it should trigger bot intro just after portfolio chat responding'
      '-bot intro fetch completed after general chat animation done-',
      build: () {
        when(loraGptRepository.portfolio(
            params: portfolioQueryRequest,
            data: [])).thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
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
        await Future.delayed(Duration.zero);
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
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

        ///FETCH BOT INTRO
        const LoraGptState(
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
            ]),

        const LoraGptState(
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result)
            ]),
        const LoraGptState(
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result)
            ]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          tabPage: TabPage.portfolio,
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          tabPage: TabPage.portfolio,
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonA
          ],
        ),
        const LoraGptState(
          tabPage: TabPage.portfolio,
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          tabPage: TabPage.portfolio,
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),
        const LoraGptState(
          tabPage: TabPage.portfolio,
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
        const LoraGptState(
          tabPage: TabPage.portfolio,
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),

        ///FETCH BOT EARNINGS
        const LoraGptState(
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        const LoraGptState(
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result)
            ]),
        const LoraGptState(
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result)
            ]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false)
            ]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonA
            ]),

        const LoraGptState(
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback
            ]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonB
            ]),
        const LoraGptState(
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        const LoraGptState(
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'open portfolio chat and send some query, then close ai and open bot details'
      'it should trigger bot intro just after portfolio chat responding,'
      'finally send some query'
      '-bot intro fetch completed after general chat animation done '
      'and final query fetch completed after bot intro animation done-',
      build: () {
        when(loraGptRepository.portfolio(
            params: portfolioQueryRequest,
            data: [])).thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.portfolio(
            params: portfolioWithSomeQueryRequest,
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
        await Future.delayed(Duration.zero);
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
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

        ///FETCH BOT INTRO
        const LoraGptState(
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
            ]),

        const LoraGptState(
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result)
            ]),
        const LoraGptState(
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result)
            ]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          tabPage: TabPage.portfolio,
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          tabPage: TabPage.portfolio,
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonA
          ],
        ),
        const LoraGptState(
          tabPage: TabPage.portfolio,
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          tabPage: TabPage.portfolio,
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),
        const LoraGptState(
          tabPage: TabPage.portfolio,
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
        const LoraGptState(
          tabPage: TabPage.portfolio,
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),

        ///FETCH BOT EARNINGS
        const LoraGptState(
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        const LoraGptState(
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result)
            ]),
        const LoraGptState(
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result)
            ]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false)
            ]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonA
            ]),

        const LoraGptState(
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback
            ]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonB
            ]),
        const LoraGptState(
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        const LoraGptState(
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),

        ///EDIT QUERY TRIGGERED
        const LoraGptState(
            query: someQuery,
            tabPage: TabPage.portfolio,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),

        ///SEARCH QUERY TRIGGERED
        const LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              meWithSomeText
            ]),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              meWithSomeText
            ],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              meWithSomeText
            ],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              meWithSomeText,
              Lora(result)
            ],
            debugText: portfolioDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              meWithSomeText,
              Lora(result)
            ],
            debugText: portfolioDebugWithSomeQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: TabPage.portfolio,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
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
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
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
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
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
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
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
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
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
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              meWithSomeText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ],
            debugText: portfolioDebugWithSomeQuery),
      },
    );

    ///BOT DETAIL CHAT CASE AND INTRO AI
    blocTest<LoraGptBloc, LoraGptState>(
      'open bot detail chat and send some query, then close ai and open bot details'
      'it should trigger bot intro just after bot detail chat responding'
      '-bot intro fetch completed after general chat animation done-',
      setUp: () {
        portfolioDetailTabPage = TabPage.portfolio.setData(arguments: (
          path: SubTabPage.recommendationsBotStockDetails.value,
          arguments: {
            'botType': BotType.plank.internalName,
            'symbol': 'AAPL.O',
            'ticker': 'AAPL',
            'duration': '2 weeks'
          }
        ));

        portfolioDetailsRequest = PortfolioDetailsRequest(
          ticker: portfolioDetailTabPage.getArguments.arguments['ticker'],
          input: '',
          userId: '',
          username: username,
          platform: aiPlatform,
          botType: portfolioDetailTabPage.getArguments.arguments['botType'],
          tickerSymbol: portfolioDetailTabPage.getArguments.arguments['symbol'],
          duration: portfolioDetailTabPage.getArguments.arguments['duration'],
        );

        botDetailDebugWithEmptyQuery =
            'endpoint : $endpointPortfolioDetailPage\nparam : ${portfolioDetailsRequest.params}';
      },
      build: () {
        when(loraGptRepository.portfolioDetails(
                params: portfolioDetailsRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(StoreTabPage(tabPage: portfolioDetailTabPage));
        await Future.delayed(Duration.zero);
        bloc.add(const OnSearchQuery());
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        await Future.delayed(Duration.zero);
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: const []),
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: const [meWithEmptyText]),
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText, Lora(result)],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText, Lora(result)],
            debugText: botDetailDebugWithEmptyQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
            ],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
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
            tabPage: portfolioDetailTabPage,
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
            tabPage: portfolioDetailTabPage,
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
            tabPage: portfolioDetailTabPage,
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
            tabPage: portfolioDetailTabPage,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ],
            debugText: botDetailDebugWithEmptyQuery),

        ///FETCH BOT INTRO
        LoraGptState(
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
            ]),

        LoraGptState(
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result)
            ]),
        LoraGptState(
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result)
            ]),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
          tabPage: portfolioDetailTabPage,
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: const [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
          tabPage: portfolioDetailTabPage,
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: const [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonA
          ],
        ),
        LoraGptState(
          tabPage: portfolioDetailTabPage,
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: const [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
          tabPage: portfolioDetailTabPage,
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: const [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),
        LoraGptState(
          tabPage: portfolioDetailTabPage,
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: const [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
        LoraGptState(
          tabPage: portfolioDetailTabPage,
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: const [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),

        ///FETCH BOT EARNINGS
        LoraGptState(
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        LoraGptState(
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result)
            ]),
        LoraGptState(
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result)
            ]),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false)
            ]),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonA
            ]),

        LoraGptState(
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback
            ]),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonB
            ]),
        LoraGptState(
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        LoraGptState(
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'open portfolio chat and send some query, then close ai and open bot details'
      'it should trigger bot intro just after portfolio chat responding,'
      'finally send some query'
      '-bot intro fetch completed after general chat animation done '
      'and final query fetch completed after bot intro animation done-',
      build: () {
        when(loraGptRepository.portfolioDetails(
          params: portfolioDetailWithSomeQueryRequest,
        )).thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.portfolioDetails(
                params: portfolioDetailWithSomeQueryRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      setUp: () {
        portfolioDetailWithSomeQueryRequest = PortfolioDetailsRequest(
          ticker: portfolioDetailTabPage.getArguments.arguments['ticker'],
          input: someQuery,
          userId: '',
          username: username,
          platform: aiPlatform,
          botType: portfolioDetailTabPage.getArguments.arguments['botType'],
          tickerSymbol: portfolioDetailTabPage.getArguments.arguments['symbol'],
          duration: portfolioDetailTabPage.getArguments.arguments['duration'],
        );
        botDetailDebugWithSomeQuery =
            'endpoint : $endpointPortfolioDetailPage\nparam : ${portfolioDetailWithSomeQueryRequest.params}';
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(StoreTabPage(tabPage: portfolioDetailTabPage));
        await Future.delayed(Duration.zero);
        bloc.add(const OnSearchQuery());
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        await Future.delayed(Duration.zero);
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
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
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: const []),
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.unknown,
            isTypingAnimationDone: true,
            conversations: const [meWithEmptyText]),
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText, Lora(result)],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [meWithEmptyText, Lora(result)],
            debugText: botDetailDebugWithEmptyQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
            ],
            debugText: botDetailDebugWithEmptyQuery),
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
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
            tabPage: portfolioDetailTabPage,
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
            tabPage: portfolioDetailTabPage,
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
            tabPage: portfolioDetailTabPage,
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
            tabPage: portfolioDetailTabPage,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ],
            debugText: botDetailDebugWithEmptyQuery),

        ///FETCH BOT INTRO
        LoraGptState(
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
            ]),

        LoraGptState(
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result)
            ]),
        LoraGptState(
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result)
            ]),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
          tabPage: portfolioDetailTabPage,
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: const [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
          tabPage: portfolioDetailTabPage,
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: const [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonA
          ],
        ),
        LoraGptState(
          tabPage: portfolioDetailTabPage,
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: const [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
          tabPage: portfolioDetailTabPage,
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: const [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),
        LoraGptState(
          tabPage: portfolioDetailTabPage,
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: const [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
        LoraGptState(
          tabPage: portfolioDetailTabPage,
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: const [
            meWithEmptyText,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),

        ///FETCH BOT EARNINGS
        LoraGptState(
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        LoraGptState(
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result)
            ]),
        LoraGptState(
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result)
            ]),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false)
            ]),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonA
            ]),

        LoraGptState(
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback
            ]),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonB
            ]),
        LoraGptState(
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        LoraGptState(
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),

        ///EDIT QUERY TRIGGERED

        LoraGptState(
            query: someQuery,
            tabPage: portfolioDetailTabPage,
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),

        ///SEARCH QUERY TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              meWithSomeText
            ]),
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              meWithSomeText
            ],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              meWithSomeText
            ],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              meWithSomeText,
              Lora(result)
            ],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              meWithSomeText,
              Lora(result)
            ],
            debugText: botDetailDebugWithSomeQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              meWithSomeText,
              Lora(result, isNeedCallback: false),
            ],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              meWithSomeText,
              Lora(result, isNeedCallback: false),
              promptButtonA
            ],
            debugText: botDetailDebugWithSomeQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              meWithSomeText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback
            ],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              meWithSomeText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonB
            ],
            debugText: botDetailDebugWithSomeQuery),

        ///ON FINISH TYPING TRIGGERED
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              meWithSomeText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ],
            debugText: botDetailDebugWithSomeQuery),
        LoraGptState(
            userName: username,
            tabPage: portfolioDetailTabPage,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: const [
              meWithEmptyText,
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              meWithSomeText,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ],
            debugText: botDetailDebugWithSomeQuery),
      },
    );

    tearDown(() => {loraGptBloc.close()});
  });
}
