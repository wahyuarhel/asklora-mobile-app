import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/core/domain/bot/bot_description.dart';
import 'package:asklora_mobile_app/core/domain/bot/bot_info.dart';
import 'package:asklora_mobile_app/core/domain/bot/stock_info.dart';
import 'package:asklora_mobile_app/core/domain/transaction/transaction_ledger_balance_response.dart';
import 'package:asklora_mobile_app/core/repository/transaction_repository.dart';
import 'package:asklora_mobile_app/feature/bot_stock/bloc/bot_stock_bloc.dart';
import 'package:asklora_mobile_app/feature/bot_stock/domain/bot_recommendation_detail_model.dart';
import 'package:asklora_mobile_app/feature/bot_stock/domain/bot_recommendation_model.dart';
import 'package:asklora_mobile_app/feature/bot_stock/domain/bot_recommendation_response.dart';
import 'package:asklora_mobile_app/feature/bot_stock/domain/orders/bot_create_order_response.dart';
import 'package:asklora_mobile_app/feature/bot_stock/repository/bot_stock_repository.dart';
import 'package:asklora_mobile_app/feature/bot_stock/utils/bot_stock_utils.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'bot_stock_bloc_test.mocks.dart';

@GenerateMocks([BotStockRepository])
@GenerateMocks([TransactionRepository])
void main() async {
  group('Bot Stock Bloc Tests', () {
    late MockBotStockRepository botStockRepository;
    late MockTransactionRepository transactionRepository;
    late BotStockBloc botStockBloc;
    late BotRecommendationResponse botRecommendationResponse =
        BotRecommendationResponse(
            updated: '2023-07-23T21:47:53.128966',
            data: defaultBotRecommendation);

    final BaseResponse<BotRecommendationResponse> botStockResponse =
        BaseResponse.complete(botRecommendationResponse);

    final BaseResponse<BotRecommendationResponse> freeBotStockResponse =
        BaseResponse.complete(botRecommendationResponse);

    final BaseResponse<BotCreateOrderResponse> botCreateOrderSuccessResponse =
        BaseResponse.complete(const BotCreateOrderResponse('a', 'b', 'c', 'd',
            true, 'a', true, '2023-06-06', 'APPLE', '2023-06-07'));
    final BaseResponse<BotCreateOrderResponse> botCreateOrderFailedResponse =
        BaseResponse.error();

    final BaseResponse<BotRecommendationResponse> errorResponse =
        BaseResponse.error();

    const BotRecommendationModel botRecommendationModel =
        BotRecommendationModel(
            1, '', '', '', 'Pullup', '', '', '', '', '', '', '');

    final BaseResponse<TransactionLedgerBalanceResponse> ledgerBalanceResponse =
        BaseResponse.complete(
            const TransactionLedgerBalanceResponse(0, 0, 0, 0, '', 0));

    final BaseResponse<TransactionLedgerBalanceResponse>
        ledgerBalanceErrorResponse = BaseResponse.error();

    final BaseResponse<BotRecommendationDetailModel> botDetailResponse =
        BaseResponse.complete(const BotRecommendationDetailModel(
            BotInfo('', '', BotDescriptionModel('detail', 'suited', 'works')),
            StockInfo(
                'symbol',
                'tickerName',
                'chineseName',
                'traditionalName',
                'description',
                'sector',
                'industry',
                'ceo',
                10,
                'headquarter',
                'founded'),
            20,
            20,
            20,
            0,
            0,
            0,
            0,
            0,
            '',
            '',
            '',
            [],
            '',
            ''));

    final BaseResponse<BotRecommendationDetailModel> botDetailErrorResponse =
        BaseResponse.error();

    setUpAll(() async {
      botStockRepository = MockBotStockRepository();
      transactionRepository = MockTransactionRepository();
    });

    setUp(() async {
      botStockBloc = BotStockBloc(
        botStockRepository: botStockRepository,
        transactionRepository: transactionRepository,
      );
    });

    test('Bot Stock Bloc init state response should be default one', () {
      expect(botStockBloc.state, const BotStockState());
    });

    blocTest<BotStockBloc, BotStockState>(
        'emits `BaseResponse.complete` WHEN '
        'fetching bot recommendation',
        build: () {
          when(botStockRepository.fetchBotRecommendation())
              .thenAnswer((_) => Future.value(botStockResponse));
          return botStockBloc;
        },
        act: (bloc) => bloc.add(FetchBotRecommendation()),
        expect: () => {
              BotStockState(botRecommendationResponse: BaseResponse.loading()),
              BotStockState(botRecommendationResponse: botStockResponse)
            });

    blocTest<BotStockBloc, BotStockState>(
        'emits `BaseResponse.error` WHEN '
        'failed fetching bot recommendation',
        build: () {
          when(botStockRepository.fetchBotRecommendation())
              .thenAnswer((_) => Future.value(errorResponse));
          return botStockBloc;
        },
        act: (bloc) => bloc.add(FetchBotRecommendation()),
        expect: () => {
              BotStockState(botRecommendationResponse: BaseResponse.loading()),
              BotStockState(botRecommendationResponse: errorResponse)
            });

    blocTest<BotStockBloc, BotStockState>(
        'emits `BaseResponse.complete` WHEN '
        'fetching free bot recommendation',
        build: () {
          when(botStockRepository.fetchFreeBotRecommendation())
              .thenAnswer((_) => Future.value(freeBotStockResponse));
          return botStockBloc;
        },
        act: (bloc) => bloc.add(FetchFreeBotRecommendation()),
        expect: () => {
              BotStockState(botRecommendationResponse: BaseResponse.loading()),
              BotStockState(botRecommendationResponse: freeBotStockResponse)
            });

    blocTest<BotStockBloc, BotStockState>(
        'emits `BaseResponse.error` WHEN '
        'failed fetching free bot recommendation',
        build: () {
          when(botStockRepository.fetchFreeBotRecommendation())
              .thenThrow(errorResponse);
          return botStockBloc;
        },
        act: (bloc) => bloc.add(FetchBotRecommendation()),
        expect: () => {
              BotStockState(botRecommendationResponse: BaseResponse.loading()),
              BotStockState(botRecommendationResponse: errorResponse)
            });

    blocTest<BotStockBloc, BotStockState>(
        'emits `BaseResponse.complete` WHEN '
        'fetch bot detail',
        build: () {
          when(botStockRepository.fetchBotDetail('AAPL', 'abc'))
              .thenAnswer((_) => Future.value(botDetailResponse));
          when(transactionRepository.fetchLedgerBalance())
              .thenAnswer((_) => Future.value(ledgerBalanceResponse));
          return botStockBloc;
        },
        act: (bloc) => bloc.add(const FetchBotDetail(
            ticker: 'AAPL', botId: 'abc', isFreeBot: false)),
        expect: () => {
              BotStockState(botDetailResponse: BaseResponse.loading()),
              BotStockState(
                  botDetailResponse: botDetailResponse, buyingPower: 0)
            });

    blocTest<BotStockBloc, BotStockState>(
        'emits `BaseResponse.error` WHEN '
        'error on fetch bot detail and succeed on fetch ledger balance',
        build: () {
          when(botStockRepository.fetchBotDetail('AAPL', 'abc'))
              .thenAnswer((_) => Future.value(botDetailErrorResponse));
          when(transactionRepository.fetchLedgerBalance())
              .thenAnswer((_) => Future.value(ledgerBalanceResponse));
          return botStockBloc;
        },
        act: (bloc) => bloc.add(const FetchBotDetail(
            ticker: 'AAPL', botId: 'abc', isFreeBot: false)),
        expect: () => {
              BotStockState(botDetailResponse: BaseResponse.loading()),
              BotStockState(botDetailResponse: botDetailErrorResponse)
            });

    blocTest<BotStockBloc, BotStockState>(
        'emits `BaseResponse.error` WHEN '
        'succeed on fetch bot detail and error on fetch ledger balance',
        build: () {
          when(botStockRepository.fetchBotDetail('AAPL', 'abc'))
              .thenAnswer((_) => Future.value(botDetailResponse));
          when(transactionRepository.fetchLedgerBalance())
              .thenAnswer((_) => Future.value(ledgerBalanceErrorResponse));
          return botStockBloc;
        },
        act: (bloc) => bloc.add(const FetchBotDetail(
            ticker: 'AAPL', botId: 'abc', isFreeBot: false)),
        expect: () => {
              BotStockState(
                botDetailResponse: BaseResponse.loading(),
              ),
              BotStockState(
                botDetailResponse:
                    BaseResponse.error(message: 'Error when fetching balance'),
              )
            });

    blocTest<BotStockBloc, BotStockState>(
        'emits `BaseResponse.complete` WHEN '
        'trade bot stock',
        build: () {
          when(botStockRepository.createOrder(
                  botRecommendationModel: botRecommendationModel,
                  tradeBotStockAmount: 0))
              .thenAnswer((_) => Future.value(botCreateOrderSuccessResponse));
          return botStockBloc;
        },
        act: (bloc) => bloc.add(const CreateBotOrder(
            botRecommendationModel: botRecommendationModel,
            tradeBotStockAmount: 0)),
        expect: () => {
              BotStockState(createBotOrderResponse: BaseResponse.loading()),
              BotStockState(
                  createBotOrderResponse: botCreateOrderSuccessResponse)
            });

    blocTest<BotStockBloc, BotStockState>(
        'emits `BaseResponse.error` WHEN '
        'failed trade bot stock',
        build: () {
          when(botStockRepository.createOrder(
                  botRecommendationModel: botRecommendationModel,
                  tradeBotStockAmount: 0))
              .thenAnswer((_) => Future.value(botCreateOrderFailedResponse));
          return botStockBloc;
        },
        act: (bloc) => bloc.add(const CreateBotOrder(
            botRecommendationModel: botRecommendationModel,
            tradeBotStockAmount: 0)),
        expect: () => {
              BotStockState(createBotOrderResponse: BaseResponse.loading()),
              BotStockState(
                  createBotOrderResponse: botCreateOrderFailedResponse)
            });

    blocTest<BotStockBloc, BotStockState>(
        'emits `faq active index = 1` WHEN '
        'tap faq on index 1',
        build: () => botStockBloc,
        act: (bloc) => bloc.add(const FaqActiveIndexChanged(1)),
        expect: () => {
              const BotStockState(faqActiveIndex: 1),
            });

    blocTest<BotStockBloc, BotStockState>(
        'emits `BaseResponse.complete` WHEN '
        'fetching bot recommendation',
        build: () => botStockBloc,
        act: (bloc) => bloc.add(const TradeBotStockAmountChanged(200)),
        expect: () => {
              const BotStockState(botStockTradeAmount: 200),
            });

    tearDown(() => {botStockBloc.close()});
  });
}
