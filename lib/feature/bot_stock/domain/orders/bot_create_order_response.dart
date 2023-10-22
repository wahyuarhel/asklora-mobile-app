import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/date_utils.dart';
import '../../utils/bot_stock_utils.dart';

part 'bot_create_order_response.g.dart';

@JsonSerializable()
class BotCreateOrderResponse {
  final String uid;
  final String name;
  @JsonKey(name: 'bot_apps_name')
  final String botAppsName;
  final String status;
  @JsonKey(name: 'is_active')
  final bool isActive;
  final String symbol;
  @JsonKey(name: 'ticker_name')
  final String tickerName;
  @JsonKey(name: 'is_dummy')
  final bool isDummy;
  @JsonKey(name: 'spot_date')
  final String spotDate;
  @JsonKey(name: 'optimal_time')
  final String optimalTime;

  const BotCreateOrderResponse(
    this.uid,
    this.name,
    this.botAppsName,
    this.status,
    this.isActive,
    this.tickerName,
    this.isDummy,
    this.spotDate,
    this.symbol,
    this.optimalTime,
  );

  String get botName =>
      '${BotType.findByString(botAppsName).upperCaseName} $symbol';

  String get optimalTimeHKTString =>
      '${convertDateToHktString(optimalTime, dateFormat: 'dd/MM/yyyy HH:mm')} HKT';

  factory BotCreateOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$BotCreateOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BotCreateOrderResponseToJson(this);
}
