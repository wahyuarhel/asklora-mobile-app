import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/date_utils.dart';

part 'bot_order_response.g.dart';

@JsonSerializable()
class BotOrderResponse {
  final String detail;

  const BotOrderResponse(this.detail);

  factory BotOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$BotOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BotOrderResponseToJson(this);
}

@JsonSerializable()
class TerminateOrderResponse {
  final String detail;
  @JsonKey(name: 'optimal_time')
  final String optimalTime;

  TerminateOrderResponse(this.detail, this.optimalTime);

  factory TerminateOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$TerminateOrderResponseFromJson(json);

  String get optimalTimeHKTString {
    return '${convertDateToHktString(optimalTime, dateFormat: 'dd/MM/yyyy HH:mm')} HKT';
  }

  Map<String, dynamic> toJson() => _$TerminateOrderResponseToJson(this);
}

@JsonSerializable()
class RolloverOrderResponse extends BotOrderResponse {
  @JsonKey(name: 'new_expire_date')
  final String newExpireDate;

  RolloverOrderResponse(
    super.detail,
    this.newExpireDate,
  );

  factory RolloverOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$RolloverOrderResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RolloverOrderResponseToJson(this);
}
