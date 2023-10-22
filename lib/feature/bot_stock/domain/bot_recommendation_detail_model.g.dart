// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bot_recommendation_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BotRecommendationDetailModel _$BotRecommendationDetailModelFromJson(
        Map<String, dynamic> json) =>
    BotRecommendationDetailModel(
      BotInfo.fromJson(json['bot_info'] as Map<String, dynamic>),
      StockInfo.fromJson(json['stock_info'] as Map<String, dynamic>),
      (json['price'] as num).toDouble(),
      (json['prev_close_amt'] as num).toDouble(),
      (json['prev_close_price'] as num).toDouble(),
      (json['est_stop_loss_price'] as num).toDouble(),
      (json['est_take_profit_price'] as num).toDouble(),
      (json['prev_close_pct'] as num).toDouble(),
      (json['est_stop_loss_pct'] as num).toDouble(),
      (json['est_take_profit_pct'] as num).toDouble(),
      json['prev_close_date'] as String,
      json['start_date'] as String,
      json['est_end_date'] as String,
      (json['performance'] as List<dynamic>)
          .map((e) =>
              BotRecommendationChartModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['bot_duration'] as String,
      json['market_cap'] as String,
    );

Map<String, dynamic> _$BotRecommendationDetailModelToJson(
        BotRecommendationDetailModel instance) =>
    <String, dynamic>{
      'bot_info': instance.botInfo,
      'stock_info': instance.stockInfo,
      'price': instance.price,
      'prev_close_amt': instance.prevCloseAmt,
      'prev_close_price': instance.prevClosePrice,
      'est_stop_loss_price': instance.estStopLossPrice,
      'est_take_profit_price': instance.estTakeProfitPrice,
      'prev_close_pct': instance.prevClosePct,
      'est_stop_loss_pct': instance.estStopLossPct,
      'est_take_profit_pct': instance.estTakeProfitPct,
      'prev_close_date': instance.prevCloseDate,
      'start_date': instance.startDate,
      'est_end_date': instance.estEndDate,
      'performance': instance.performance,
      'bot_duration': instance.botDuration,
      'market_cap': instance.marketCap,
    };
