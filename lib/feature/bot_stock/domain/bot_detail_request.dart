import 'package:json_annotation/json_annotation.dart';

part 'bot_detail_request.g.dart';

@JsonSerializable()
class BotDetailRequest {
  final String ticker;
  @JsonKey(name: 'bot_id')
  final String botId;

  const BotDetailRequest(
    this.ticker,
    this.botId,
  );

  factory BotDetailRequest.fromJson(Map<String, dynamic> json) =>
      _$BotDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BotDetailRequestToJson(this);
}
