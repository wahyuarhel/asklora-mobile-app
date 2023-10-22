import 'package:json_annotation/json_annotation.dart';

part 'bot_order_request.g.dart';

@JsonSerializable()
class BotOrderRequest {
  @JsonKey(name: 'bot_id')
  final String botId;

  const BotOrderRequest(this.botId);

  factory BotOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$BotOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BotOrderRequestToJson(this);
}
