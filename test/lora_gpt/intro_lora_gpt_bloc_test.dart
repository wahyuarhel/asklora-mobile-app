import 'package:asklora_mobile_app/core/domain/ai/component.dart';
import 'package:asklora_mobile_app/core/domain/ai/conversation.dart';
import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/core/domain/endpoints.dart';
import 'package:asklora_mobile_app/core/utils/storage/shared_preference.dart';
import 'package:asklora_mobile_app/feature/bot_stock/utils/bot_stock_utils.dart';
import 'package:asklora_mobile_app/feature/tabs/lora_gpt/bloc/lora_gpt_bloc.dart';
import 'package:asklora_mobile_app/feature/tabs/lora_gpt/domain/portfolio_query_request.dart';
import 'package:asklora_mobile_app/feature/tabs/lora_gpt/domain/query_request.dart';
import 'package:asklora_mobile_app/feature/tabs/lora_gpt/domain/query_response.dart';
import 'package:asklora_mobile_app/feature/tabs/lora_gpt/repository/lora_gpt_repository.dart';
import 'package:asklora_mobile_app/feature/tabs/utils/tab_util.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'intro_lora_gpt_bloc_test.mocks.dart';

@GenerateMocks([LoraGptRepository])
@GenerateMocks([SharedPreference])
void main() async {
  group('Lora Gpt Bloc Tests', () {
    late MockLoraGptRepository loraGptRepository;
    late MockSharedPreference sharedPreferences;
    late LoraGptBloc loraGptBloc;

    const String username = 'Anton';

    final BotstockIntro botRequest = BotstockIntro(
        botType: BotType.plank.name,
        tickerSymbol: 'symbol',
        investmentHorizon: 'duration',
        ticker: 'ticker',
        userId: 'userId',
        platform: aiPlatform,
        username: username);

    GeneralQueryRequest mainAiRequest = const GeneralQueryRequest(
      input: '',
      userId: '',
      username: username,
      platform: aiPlatform,
      sessionId: '',
    );

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

    ///MAIN AI
    ///both succeed - welcome news fetch completed after welcome starter animation done
    blocTest<LoraGptBloc, LoraGptState>(
      'Both full response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [Lora(result, isNeedCallback: false), promptButtonA],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
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
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [
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
      'Welcome starter result only response and welcome news full response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(resultOnlyQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),

        ///FETCH BOT EARNINGS
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result, isNeedCallback: false), Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result, isNeedCallback: false), Lora(result)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false)
            ]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              promptButtonA
            ]),

        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback
            ]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonB
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: [
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Welcome starter components only response and welcome news full response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(componentOnlyQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [promptButtonA]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [promptButtonA]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [promptButtonADisabledCallback, promptButtonB],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
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
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result)
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
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
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Welcome starter empty response and welcome news full response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(emptyQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: []),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: []),

        ///FETCH BOT EARNINGS

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result, isNeedCallback: false)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonA
            ]),

        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback
            ]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonB
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'welcome news result only response and welcome starter full response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(resultOnlyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [Lora(result, isNeedCallback: false), promptButtonA],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
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
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [
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
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false)
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false)
            ]),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Welcome news components only response and welcome starter full response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(componentOnlyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [Lora(result, isNeedCallback: false), promptButtonA],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
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
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              promptButtonA,
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              promptButtonA,
            ]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              promptButtonADisabledCallback,
            ]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              promptButtonADisabledCallback,
              promptButtonB
            ]),

        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
            ]),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Welcome news empty response and welcome starter full response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(emptyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [Lora(result, isNeedCallback: false), promptButtonA],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
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
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
      },
    );

    ///##################################///
    ///both succeed - welcome news fetch completed before welcome starter animation done

    blocTest<LoraGptBloc, LoraGptState>(
      'Both full response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///FETCH BOT EARNINGS CHAT GOING TO QUEUE BECAUSE welcome starter EARNING NOT YET DONE
        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [Lora(result, isNeedCallback: false), promptButtonA],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result),
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonA
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
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
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Welcome news result only response and welcome starter full response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(resultOnlyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        bloc.add(const OnFinishTyping(Lora(result)));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///FETCH BOT EARNINGS CHAT GOING TO QUEUE BECAUSE welcome starter EARNING NOT YET DONE
        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [Lora(result, isNeedCallback: false), promptButtonA],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result),
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
          ],
        ),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Welcome news components only and welcome starter full response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(componentOnlyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///FETCH BOT EARNINGS CHAT GOING TO QUEUE BECAUSE welcome starter EARNING NOT YET DONE
        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [Lora(result, isNeedCallback: false), promptButtonA],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            promptButtonA,
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            promptButtonADisabledCallback
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Welcome news empty response and welcome starter full response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(emptyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///FETCH BOT EARNINGS CHAT GOING TO QUEUE BECAUSE welcome starter EARNING NOT YET DONE
        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [Lora(result, isNeedCallback: false), promptButtonA],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
          ],
        ),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Welcome starter result only response and welcome news full response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(resultOnlyQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///FETCH BOT EARNINGS CHAT GOING TO QUEUE BECAUSE welcome starter EARNING NOT YET DONE
        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            Lora(result),
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            Lora(result, isNeedCallback: false),
            promptButtonA,
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
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
            Lora(result, isNeedCallback: false),
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Welcome starter components only response and welcome news full response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(componentOnlyQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [promptButtonA]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [promptButtonA]),

        ///FETCH BOT EARNINGS CHAT GOING TO QUEUE BECAUSE welcome starter EARNING NOT YET DONE
        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [promptButtonADisabledCallback, promptButtonB],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result)
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonA
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
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
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Welcome starter empty response and welcome news full response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(emptyQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: []),

        ///FETCH BOT EARNINGS
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonA,
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
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
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
      },
    );

    ///#############################
    ///welcome starter failed - welcome news fetch completed after welcome starter animation done
    blocTest<LoraGptBloc, LoraGptState>(
      'Welcome starter failed response and welcome news full response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: []),

        ///FETCH BOT EARNINGS
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonA,
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
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
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
      },
    );
    blocTest<LoraGptBloc, LoraGptState>(
      'Welcome starter failed response and welcome news full response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(resultOnlyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: []),

        ///FETCH BOT EARNINGS
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
      },
    );
    blocTest<LoraGptBloc, LoraGptState>(
      'Welcome starter failed response and welcome news full response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(componentOnlyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: []),

        ///FETCH BOT EARNINGS
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [promptButtonA]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [promptButtonA]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [promptButtonADisabledCallback],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonB,
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
          ],
        ),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Welcome starter failed response and welcome news empty response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(emptyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: []),
      },
    );

    ///#############################
    ///welcome news failed - welcome news fetch completed after welcome starter animation done
    blocTest<LoraGptBloc, LoraGptState>(
      'Welcome news failed response and welcome starter full response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [Lora(result, isNeedCallback: false), promptButtonA],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),

        ///ON FINISH TYPING TRIGGERED

        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
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
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
            ]),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Welcome news failed response and welcome starter result only response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(resultOnlyQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),

        ///FETCH BOT EARNINGS
        const LoraGptState(
          userName: username,
          status: ResponseState.loading,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.loading,
          isTypingAnimationDone: true,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Welcome news failed response and welcome starter components only response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(componentOnlyQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [promptButtonA]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [promptButtonA]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [promptButtonADisabledCallback, promptButtonB],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
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
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: [
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Welcome news failed response and welcome starter empty response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(emptyQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: []),
      },
    );

    ///#############################
    ///welcome news failed - welcome news fetch completed before welcome starter animation done
    blocTest<LoraGptBloc, LoraGptState>(
      'Welcome news failed response and welcome starter full response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///FETCH BOT EARNINGS CHAT GOING TO QUEUE BECAUSE welcome starter EARNING NOT YET DONE
        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [Lora(result, isNeedCallback: false), promptButtonA],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
          ],
        ),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Welcome news failed response and welcome starter result only response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(resultOnlyQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///FETCH BOT EARNINGS CHAT GOING TO QUEUE BECAUSE welcome starter EARNING NOT YET DONE
        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Welcome news failed response and welcome starter components only response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(componentOnlyQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [promptButtonA]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [promptButtonA]),

        ///FETCH BOT EARNINGS CHAT GOING TO QUEUE BECAUSE welcome starter EARNING NOT YET DONE
        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [promptButtonADisabledCallback, promptButtonB],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Welcome news failed response and welcome starter empty response',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(emptyQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: []),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: []),
      },
    );

    ///#############################
    ///both failed
    blocTest<LoraGptBloc, LoraGptState>(
      'Both intro failed',
      build: () {
        when(loraGptRepository.welcomeStarter(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        when(loraGptRepository.welcomeNews(params: mainAiRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeStarter(params: mainAiRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.welcomeNews(params: mainAiRequest)));
      },
      expect: () => {
        ///FETCH WELCOME STARTER
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: []),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: []),
      },
    );

    ///***************
    ///***************
    ///***************
    ///***************

    ///BOT INTRO AI
    ///both succeed - bot earnings fetch completed after bot Intro animation done
    blocTest<LoraGptBloc, LoraGptState>(
      'Both full response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
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
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [Lora(result, isNeedCallback: false), promptButtonA],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
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
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [
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
      'Bot Intro result only response and bot earnings full response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(resultOnlyQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),

        ///FETCH BOT EARNINGS
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result, isNeedCallback: false), Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result, isNeedCallback: false), Lora(result)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false)
            ]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              promptButtonA
            ]),

        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback
            ]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonB
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: [
              Lora(result, isNeedCallback: false),
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Bot Intro components only response and bot earnings full response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(componentOnlyQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
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
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [promptButtonA]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [promptButtonA]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [promptButtonADisabledCallback, promptButtonB],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
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
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result)
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
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
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Bot Intro empty response and bot earnings full response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(emptyQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: []),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: []),

        ///FETCH BOT EARNINGS

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result, isNeedCallback: false)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonA
            ]),

        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback
            ]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonB
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'bot earnings result only response and bot Intro full response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(resultOnlyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
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
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [Lora(result, isNeedCallback: false), promptButtonA],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
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
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [
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
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false)
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              Lora(result, isNeedCallback: false)
            ]),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Bot earnings components only response and bot Intro full response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(componentOnlyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
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
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [Lora(result, isNeedCallback: false), promptButtonA],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
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
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              promptButtonA,
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              promptButtonA,
            ]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              promptButtonADisabledCallback,
            ]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              promptButtonADisabledCallback,
              promptButtonB
            ]),

        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
            ]),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Bot earnings empty response and bot Intro full response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(emptyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [Lora(result, isNeedCallback: false), promptButtonA],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
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
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
      },
    );

    ///##################################///
    ///both succeed - bot earnings fetch completed before bot Intro animation done

    blocTest<LoraGptBloc, LoraGptState>(
      'Both full response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///FETCH BOT EARNINGS CHAT GOING TO QUEUE BECAUSE BOT INTRO EARNING NOT YET DONE
        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [Lora(result, isNeedCallback: false), promptButtonA],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result),
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonA
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
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
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Bot earnings result only response and bot Intro full response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(resultOnlyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        bloc.add(const OnFinishTyping(Lora(result)));
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///FETCH BOT EARNINGS CHAT GOING TO QUEUE BECAUSE BOT INTRO EARNING NOT YET DONE
        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [Lora(result, isNeedCallback: false), promptButtonA],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result),
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
          ],
        ),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Bot earnings components only and bot Intro full response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(componentOnlyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///FETCH BOT EARNINGS CHAT GOING TO QUEUE BECAUSE BOT INTRO EARNING NOT YET DONE
        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [Lora(result, isNeedCallback: false), promptButtonA],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            promptButtonA,
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            promptButtonADisabledCallback
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Bot earnings empty response and bot Intro full response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(emptyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///FETCH BOT EARNINGS CHAT GOING TO QUEUE BECAUSE BOT INTRO EARNING NOT YET DONE
        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [Lora(result, isNeedCallback: false), promptButtonA],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
          ],
        ),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Bot Intro result only response and bot earnings full response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(resultOnlyQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///FETCH BOT EARNINGS CHAT GOING TO QUEUE BECAUSE BOT INTRO EARNING NOT YET DONE
        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            Lora(result),
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            Lora(result, isNeedCallback: false),
            promptButtonA,
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
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
            Lora(result, isNeedCallback: false),
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Bot Intro components only response and bot earnings full response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(componentOnlyQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [promptButtonA]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [promptButtonA]),

        ///FETCH BOT EARNINGS CHAT GOING TO QUEUE BECAUSE BOT INTRO EARNING NOT YET DONE
        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [promptButtonADisabledCallback, promptButtonB],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result)
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonA
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
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
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Bot Intro empty response and bot earnings full response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(emptyQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: []),

        ///FETCH BOT EARNINGS
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonA,
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
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
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
      },
    );

    ///#############################
    ///bot Intro failed - bot earnings fetch completed after bot Intro animation done
    blocTest<LoraGptBloc, LoraGptState>(
      'Bot Intro failed response and bot earnings full response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: []),

        ///FETCH BOT EARNINGS
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonA,
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
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
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
      },
    );
    blocTest<LoraGptBloc, LoraGptState>(
      'Bot Intro failed response and bot earnings full response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(resultOnlyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: []),

        ///FETCH BOT EARNINGS
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
      },
    );
    blocTest<LoraGptBloc, LoraGptState>(
      'Bot Intro failed response and bot earnings full response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(componentOnlyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: []),

        ///FETCH BOT EARNINGS
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [promptButtonA]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [promptButtonA]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [promptButtonADisabledCallback],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonB,
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
          ],
        ),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Bot Intro failed response and bot earnings empty response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(emptyQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: []),
      },
    );

    ///#############################
    ///bot earnings failed - bot earnings fetch completed after bot Intro animation done
    blocTest<LoraGptBloc, LoraGptState>(
      'Bot Earnings failed response and bot intro full response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [Lora(result, isNeedCallback: false), promptButtonA],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),

        ///ON FINISH TYPING TRIGGERED

        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
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
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: [
              Lora(result, isNeedCallback: false),
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback,
            ]),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Bot Earnings failed response and bot intro result only response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(resultOnlyQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),

        ///FETCH BOT EARNINGS
        const LoraGptState(
          userName: username,
          status: ResponseState.loading,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.loading,
          isTypingAnimationDone: true,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Bot Earnings failed response and bot intro components only response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(componentOnlyQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [promptButtonA]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [promptButtonA]),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [promptButtonADisabledCallback, promptButtonB],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
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
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: [
              promptButtonADisabledCallback,
              promptButtonBDisabledCallback
            ]),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Bot Earnings failed response and bot intro empty response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(emptyQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: []),
      },
    );

    ///#############################
    ///bot earnings failed - bot earnings fetch completed before bot Intro animation done
    blocTest<LoraGptBloc, LoraGptState>(
      'Bot earnings failed response and bot Intro full response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(fullQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///FETCH BOT EARNINGS CHAT GOING TO QUEUE BECAUSE BOT INTRO EARNING NOT YET DONE
        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [Lora(result, isNeedCallback: false), promptButtonA],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonB
          ],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
            Lora(result, isNeedCallback: false),
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback,
          ],
        ),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Bot earnings failed response and bot Intro result only response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(resultOnlyQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(Lora(result)));
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [Lora(result)]),

        ///FETCH BOT EARNINGS CHAT GOING TO QUEUE BECAUSE BOT INTRO EARNING NOT YET DONE
        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
            Lora(result, isNeedCallback: false),
          ],
        ),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Bot earnings failed response and bot Intro components only response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(componentOnlyQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(const OnFinishTyping(promptButtonA));
        bloc.add(const OnFinishTyping(promptButtonB));
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: [promptButtonA]),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: false,
            conversations: [promptButtonA]),

        ///FETCH BOT EARNINGS CHAT GOING TO QUEUE BECAUSE BOT INTRO EARNING NOT YET DONE
        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [promptButtonADisabledCallback, promptButtonB],
        ),

        ///ON FINISH TYPING TRIGGERED
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: false,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
        const LoraGptState(
          userName: username,
          status: ResponseState.success,
          isTypingAnimationDone: true,
          conversations: [
            promptButtonADisabledCallback,
            promptButtonBDisabledCallback
          ],
        ),
      },
    );

    blocTest<LoraGptBloc, LoraGptState>(
      'Bot earnings failed response and bot Intro empty response',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(emptyQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: []),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: []),
      },
    );

    ///#############################
    ///both failed
    blocTest<LoraGptBloc, LoraGptState>(
      'Both intro failed',
      build: () {
        when(loraGptRepository.botIntro(params: botRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        when(loraGptRepository.botEarnings(params: botRequest))
            .thenAnswer((_) async => Future.value(failedQueryResponse));
        return loraGptBloc;
      },
      seed: () => const LoraGptState(userName: username),
      act: (bloc) async {
        bloc.add(
            SubmitLora(future: loraGptRepository.botIntro(params: botRequest)));
        await Future.delayed(Duration.zero);
        bloc.add(SubmitLora(
            future: loraGptRepository.botEarnings(params: botRequest)));
      },
      expect: () => {
        ///FETCH BOT INTRO
        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: false,
            conversations: []),

        const LoraGptState(
            userName: username,
            status: ResponseState.loading,
            isTypingAnimationDone: true,
            conversations: []),
        const LoraGptState(
            userName: username,
            status: ResponseState.success,
            isTypingAnimationDone: true,
            conversations: []),
      },
    );

    tearDown(() => {loraGptBloc.close()});
  });
}
