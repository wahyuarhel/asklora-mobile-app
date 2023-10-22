import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/feature/bot_stock/presentation/bot_performance/bloc/bot_performance_bloc.dart';
import 'package:asklora_mobile_app/feature/bot_stock/repository/bot_stock_repository.dart';
import 'package:asklora_mobile_app/feature/chart/domain/bot_portfolio_chart_models.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'bot_stock_bloc_test.mocks.dart';

@GenerateMocks([BotStockRepository])
void main() async {
  group('Bot Performance Bloc Tests', () {
    late MockBotStockRepository botStockRepository;
    late BotPerformanceBloc botPerformanceBloc;

    final BaseResponse<List<BotPortfolioChartDataSet>> botPerformanceResponse =
        BaseResponse.complete([]);

    final BaseResponse<List<BotPortfolioChartDataSet>>
        botPerformanceErrorResponse = BaseResponse.error();

    setUpAll(() async {
      botStockRepository = MockBotStockRepository();
    });

    setUp(() async {
      botPerformanceBloc = BotPerformanceBloc(
        botStockRepository: botStockRepository,
      );
    });

    test('Bot Performance Bloc init state response should be default one', () {
      expect(botPerformanceBloc.state, const BotPerformanceState());
    });

    blocTest<BotPerformanceBloc, BotPerformanceState>(
        'emits `BaseResponse.complete` WHEN '
        'fetching bot performance',
        build: () {
          when(botStockRepository.fetchBotPerformance('1'))
              .thenAnswer((_) => Future.value(botPerformanceResponse));
          return botPerformanceBloc;
        },
        act: (bloc) => bloc.add(const FetchBotPerformance(botOrderId: '1')),
        expect: () => {
              BotPerformanceState(
                  botPerformanceResponse: BaseResponse.loading()),
              BotPerformanceState(
                  botPerformanceResponse: botPerformanceResponse)
            });

    blocTest<BotPerformanceBloc, BotPerformanceState>(
        'emits `BaseResponse.error` WHEN '
        'failed fetching bot recommendation',
        build: () {
          when(botStockRepository.fetchBotPerformance('1'))
              .thenAnswer((_) => Future.value(botPerformanceErrorResponse));
          return botPerformanceBloc;
        },
        act: (bloc) => bloc.add(const FetchBotPerformance(botOrderId: '1')),
        expect: () => {
              BotPerformanceState(
                  botPerformanceResponse: BaseResponse.loading()),
              BotPerformanceState(
                  botPerformanceResponse: botPerformanceErrorResponse)
            });

    tearDown(() => {botPerformanceBloc.close()});
  });
}
