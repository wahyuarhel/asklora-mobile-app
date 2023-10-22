import '../../../core/utils/extensions.dart';
import 'chart_models.dart';

class BotPortfolioChartDataSet extends ChartDataSet {
  const BotPortfolioChartDataSet(
    super.date,
    super.price,
    super.hedgeShare,
    super.currentPnlRet, {
    super.index,
  });

  BotPortfolioChartDataSet.fromJson(Map<String, dynamic> json)
      : super(
            DateTime.parse(json['date']),
            checkDouble(json['price']),
            checkDouble(json['hedge_share'] ?? 0),
            checkDouble(json['pnl_amt'] ?? 0),
            index: json['i'] ?? 0);

  BotPortfolioChartDataSet copyWith({int? index}) => BotPortfolioChartDataSet(
        date,
        price,
        hedgeShare,
        currentPnlRet,
        index: index ?? this.index,
      );
}
