part of 'demonstration_bot_bloc.dart';

class DemonstrationBotState extends Equatable {
  const DemonstrationBotState({
    this.botDemonstrationResponse = const BaseResponse(),
    this.chartDataResponse = const BaseResponse(),
    this.tradeChartDataResponse = const BaseResponse(),
  });

  final BaseResponse<List<BotRecommendationModel>> botDemonstrationResponse;
  final BaseResponse<List<ChartDataSet>> chartDataResponse;
  final BaseResponse<ChartStudioAnimationModel> tradeChartDataResponse;

  @override
  List<Object?> get props {
    return [botDemonstrationResponse, chartDataResponse];
  }

  DemonstrationBotState copyWith({
    BaseResponse<List<BotRecommendationModel>>? botDemonstrationResponse,
    BaseResponse<List<ChartDataSet>>? chartDataResponse,
    BaseResponse<ChartStudioAnimationModel>? tradeChartDataResponse,
  }) {
    return DemonstrationBotState(
      botDemonstrationResponse:
          botDemonstrationResponse ?? this.botDemonstrationResponse,
      chartDataResponse: chartDataResponse ?? this.chartDataResponse,
      tradeChartDataResponse:
          tradeChartDataResponse ?? this.tradeChartDataResponse,
    );
  }
}
