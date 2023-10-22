import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../core/domain/bot/bot_info.dart';
import '../../../core/domain/bot/stock_info.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/utils/extensions.dart';
import '../../chart/domain/bot_recommendation_chart_model.dart';

part 'bot_recommendation_detail_model.g.dart';

@JsonSerializable()
class BotRecommendationDetailModel extends Equatable {
  @JsonKey(name: 'bot_info')
  final BotInfo botInfo;
  @JsonKey(name: 'stock_info')
  final StockInfo stockInfo;
  final double price;
  @JsonKey(name: 'prev_close_amt')
  final double prevCloseAmt;
  @JsonKey(name: 'prev_close_price')
  final double prevClosePrice;
  @JsonKey(name: 'est_stop_loss_price')
  final double estStopLossPrice;
  @JsonKey(name: 'est_take_profit_price')
  final double estTakeProfitPrice;
  @JsonKey(name: 'prev_close_pct')
  final double prevClosePct;
  @JsonKey(name: 'est_stop_loss_pct')
  final double estStopLossPct;
  @JsonKey(name: 'est_take_profit_pct')
  final double estTakeProfitPct;
  @JsonKey(name: 'prev_close_date')
  final String prevCloseDate;
  @JsonKey(name: 'start_date')
  final String startDate;
  @JsonKey(name: 'est_end_date')
  final String estEndDate;
  final List<BotRecommendationChartModel> performance;
  @JsonKey(name: 'bot_duration')
  final String botDuration;
  @JsonKey(name: 'market_cap')
  final String marketCap;

  String get prevCloseDateFormatted =>
      formatDateTimeAsString(prevCloseDate, dateFormat: 'dd/MM/yyyy');

  String get endDateHKTString =>
      addOneDayToDate(estEndDate, dateFormat: 'dd/MM/yyyy');

  String get estStopLossPriceFormatted =>
      checkDouble(estStopLossPrice).convertToCurrencyDecimal();

  String get priceFormatted => checkDouble(price).convertToCurrencyDecimal();

  String get estTakeProfitPriceFormatted =>
      checkDouble(estTakeProfitPrice).convertToCurrencyDecimal();

  String get estStopLossPctFormatted {
    final String estStopLossPctString =
        estStopLossPct.convertToCurrencyDecimal();
    return (estStopLossPct > 0)
        ? '+$estStopLossPctString%'
        : (estStopLossPct < 0)
            ? '$estStopLossPctString%'
            : '/';
  }

  String get estTakeProfitPctFormatted {
    final String estTakeProfitPctString =
        estTakeProfitPct.convertToCurrencyDecimal();
    return (estTakeProfitPct > 0)
        ? '+$estTakeProfitPctString%'
        : (estTakeProfitPct < 0)
            ? '$estTakeProfitPctString%'
            : '/';
  }

  const BotRecommendationDetailModel(
    this.botInfo,
    this.stockInfo,
    this.price,
    this.prevCloseAmt,
    this.prevClosePrice,
    this.estStopLossPrice,
    this.estTakeProfitPrice,
    this.prevClosePct,
    this.estStopLossPct,
    this.estTakeProfitPct,
    this.prevCloseDate,
    this.startDate,
    this.estEndDate,
    this.performance,
    this.botDuration,
    this.marketCap,
  );

  String get prevClosePctFormatted => prevClosePct > 0
      ? '+${prevClosePct.convertToCurrencyDecimal()}%'
      : (prevClosePct < 0)
          ? '${prevClosePct.convertToCurrencyDecimal()}%'
          : '0.00%';

  String get prevCloseAmtFormatted => prevCloseAmt > 0
      ? '+${prevCloseAmt.convertToCurrencyDecimal()}'
      : (prevCloseAmt < 0)
          ? prevCloseAmt.convertToCurrencyDecimal()
          : '0.00';

  String get formattedStartDate => convertDateToHktString(startDate);

  String get formattedAcknowledgementEstEndDate {
    return '${convertDateToEstString(estEndDate, dateFormat: 'dd/MM/yyyy HH:mm')} EST';
  }

  String format(DateTime sourceDateTime) {
    try {
      var outputFormat = DateFormat('dd/MM/yy');
      var outputDate = outputFormat.format(sourceDateTime);
      return outputDate;
    } catch (e) {
      return '';
    }
  }

  String get botPerformanceStartDate => format(performance[0].date);

  String get botPerformanceEndDate =>
      format(performance[performance.length - 1].date);

  factory BotRecommendationDetailModel.fromJson(Map<String, dynamic> json) =>
      _$BotRecommendationDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$BotRecommendationDetailModelToJson(this);

  @override
  List<Object?> get props => [
        botInfo,
        stockInfo,
        price,
        prevCloseAmt,
        prevClosePrice,
        estStopLossPrice,
        estTakeProfitPrice,
        prevClosePct,
        estStopLossPct,
        estTakeProfitPct,
        prevCloseDate,
        startDate,
        estEndDate,
        performance,
        botDuration,
        marketCap,
      ];
}
