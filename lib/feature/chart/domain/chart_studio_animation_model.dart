import 'chart_models.dart';

class ChartStudioAnimationModel {
  final List<ChartDataStudioSet> chartData;
  final List<ChartDataStudioSet> botData;
  final List<UiData> uiData;

  ChartStudioAnimationModel(
      {required this.chartData, required this.botData, required this.uiData});
}
