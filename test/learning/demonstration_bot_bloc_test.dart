import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/feature/bot_stock/domain/bot_recommendation_model.dart';
import 'package:asklora_mobile_app/feature/bot_stock/repository/bot_stock_repository.dart';
import 'package:asklora_mobile_app/feature/bot_stock/utils/bot_stock_utils.dart';
import 'package:asklora_mobile_app/feature/chart/domain/chart_models.dart';
import 'package:asklora_mobile_app/feature/chart/domain/chart_studio_animation_model.dart';
import 'package:asklora_mobile_app/feature/learning/demonstration_bot/bloc/demonstration_bot_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'demonstration_bot_bloc_test.mocks.dart';

@GenerateMocks([BotStockRepository])
void main() async {
  group('Bot Demonstration Bloc Tests', () {
    late MockBotStockRepository botStockRepository;
    late DemonstrationBotBloc demonstrationBotBloc;

    final BaseResponse<List<BotRecommendationModel>> response =
        BaseResponse.complete(defaultBotRecommendation);

    final BaseResponse<List<ChartDataSet>> chartResponse =
        BaseResponse.complete([]);

    final BaseResponse<ChartStudioAnimationModel> tradeChartResponse =
        BaseResponse.complete(
            ChartStudioAnimationModel(chartData: [], botData: [], uiData: []));

    final BaseResponse<List<BotRecommendationModel>> errorResponse =
        BaseResponse.error();

    final BaseResponse<List<ChartDataSet>> chartErrorResponse =
        BaseResponse.error();

    final BaseResponse<ChartStudioAnimationModel> tradeChartErrorResponse =
        BaseResponse.error();

    setUpAll(() async {
      botStockRepository = MockBotStockRepository();
    });

    setUp(() async {
      demonstrationBotBloc =
          DemonstrationBotBloc(botStockRepository: botStockRepository);
    });

    test('Demonstration Bot Bloc init state response should be default one',
        () {
      expect(demonstrationBotBloc.state, const DemonstrationBotState());
    });

    blocTest<DemonstrationBotBloc, DemonstrationBotState>(
        'emits `BaseResponse.complete` WHEN '
        'fetching bot demonstration',
        build: () {
          when(
            botStockRepository.fetchBotDemonstration(),
          ).thenAnswer((_) => Future.value(response));
          return demonstrationBotBloc;
        },
        act: (bloc) => bloc.add(FetchBotDemonstration()),
        expect: () => {
              DemonstrationBotState(
                  botDemonstrationResponse: BaseResponse.loading()),
              DemonstrationBotState(botDemonstrationResponse: response),
            });

    blocTest<DemonstrationBotBloc, DemonstrationBotState>(
        'emits `BaseResponse.error` WHEN '
        'failed fetching bot demonstration',
        build: () {
          when(
            botStockRepository.fetchBotDemonstration(),
          ).thenThrow(errorResponse);
          return demonstrationBotBloc;
        },
        act: (bloc) => bloc.add(FetchBotDemonstration()),
        expect: () => {
              DemonstrationBotState(
                  botDemonstrationResponse: BaseResponse.loading()),
              DemonstrationBotState(botDemonstrationResponse: errorResponse),
            });

    blocTest<DemonstrationBotBloc, DemonstrationBotState>(
        'emits `BaseResponse.complete` WHEN '
        'fetching chart data',
        build: () {
          when(botStockRepository.fetchChartDataJson())
              .thenAnswer((_) => Future.value(chartResponse));
          return demonstrationBotBloc;
        },
        act: (bloc) => bloc.add(FetchChartData()),
        expect: () => {
              DemonstrationBotState(chartDataResponse: chartResponse),
            });

    blocTest<DemonstrationBotBloc, DemonstrationBotState>(
        'emits `BaseResponse.error` WHEN '
        'failed fetching chart data',
        build: () {
          when(
            botStockRepository.fetchChartDataJson(),
          ).thenThrow(chartErrorResponse);
          return demonstrationBotBloc;
        },
        act: (bloc) => bloc.add(FetchChartData()),
        expect: () =>
            {DemonstrationBotState(chartDataResponse: chartErrorResponse)});

    blocTest<DemonstrationBotBloc, DemonstrationBotState>(
        'emits `BaseResponse.complete` WHEN '
        'fetching trade chart data',
        build: () {
          when(botStockRepository.fetchTradeChartDataJson()).thenAnswer(
            (_) => Future.value(tradeChartResponse),
          );
          return demonstrationBotBloc;
        },
        act: (bloc) => bloc.add(FetchTradeChartData()),
        expect: () => {
              DemonstrationBotState(tradeChartDataResponse: tradeChartResponse),
            });

    blocTest<DemonstrationBotBloc, DemonstrationBotState>(
        'emits `BaseResponse.error` WHEN '
        'failed fetching trade chart data',
        build: () {
          when(botStockRepository.fetchTradeChartDataJson())
              .thenThrow(tradeChartErrorResponse);
          return demonstrationBotBloc;
        },
        act: (bloc) => bloc.add(FetchTradeChartData()),
        expect: () => {
              DemonstrationBotState(
                  tradeChartDataResponse: tradeChartErrorResponse),
            });

    tearDown(() => {demonstrationBotBloc.close()});
  });
}
