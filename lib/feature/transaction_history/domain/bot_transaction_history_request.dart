import 'package:json_annotation/json_annotation.dart';

part 'bot_transaction_history_request.g.dart';

@JsonSerializable()
class BotTransactionHistoryRequest {
  @JsonKey(name: 'status', includeIfNull: false)
  final List<String>? status;

  const BotTransactionHistoryRequest({this.status});

  factory BotTransactionHistoryRequest.fromJson(Map<String, dynamic> json) =>
      _$BotTransactionHistoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BotTransactionHistoryRequestToJson(this);
}
