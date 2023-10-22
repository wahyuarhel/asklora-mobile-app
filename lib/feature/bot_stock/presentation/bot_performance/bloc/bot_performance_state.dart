part of 'bot_performance_bloc.dart';

class BotPerformanceState extends Equatable {
  const BotPerformanceState({
    this.botPerformanceResponse = const BaseResponse(),
  });

  final BaseResponse<List<BotPortfolioChartDataSet>> botPerformanceResponse;

  @override
  List<Object?> get props {
    return [
      botPerformanceResponse,
    ];
  }

  BotPerformanceState copyWith({
    BaseResponse<List<BotPortfolioChartDataSet>>? botPerformanceResponse,
  }) {
    return BotPerformanceState(
      botPerformanceResponse:
          botPerformanceResponse ?? this.botPerformanceResponse,
    );
  }
}
