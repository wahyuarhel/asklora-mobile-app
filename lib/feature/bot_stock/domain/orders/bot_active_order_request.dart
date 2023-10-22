import 'package:json_annotation/json_annotation.dart';

part 'bot_active_order_request.g.dart';

@JsonSerializable()
class BotActiveOrderRequest {
  final String status;

  const BotActiveOrderRequest({required this.status});

  factory BotActiveOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$BotActiveOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BotActiveOrderRequestToJson(this);
}
