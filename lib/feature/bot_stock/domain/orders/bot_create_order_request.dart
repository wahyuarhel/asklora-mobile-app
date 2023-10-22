import 'package:json_annotation/json_annotation.dart';

part 'bot_create_order_request.g.dart';

@JsonSerializable()
class BotCreateOrderRequest {
  final String ticker;
  @JsonKey(name: 'bot_id')
  final String botId;
  // @JsonKey(name: 'spot_date')
  // final String spotDate;
  @JsonKey(name: 'investment_amount')
  final double investmentAmount;
  // final double price;
  final bool fraction;
  final int margin;
  // @JsonKey(name: 'order_type')
  // final String orderType;
  @JsonKey(name: 'is_aggregate')
  final bool isAggregate;
  // @JsonKey(name: 'is_dummy')
  // final bool isDummy;

  const BotCreateOrderRequest({
    required this.ticker,
    required this.botId,
    // required this.spotDate,
    required this.investmentAmount,
    // required this.price,
    this.fraction = true,
    this.margin = 1,

    ///TODO : REVERT BACK THE ORDERTYPE TO `POOL` LATER AFTER TESTING
    // this.orderType = 'POOL',
    this.isAggregate = false,
    /*this.isDummy = false*/
  });

  factory BotCreateOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$BotCreateOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BotCreateOrderRequestToJson(this);
}
