import 'package:json_annotation/json_annotation.dart';

import 'query_request.dart';

part 'portfolio_details_request.g.dart';

@JsonSerializable()
class PortfolioDetailsRequest extends BaseQueryRequest {
  final String ticker;

  @JsonKey(name: 'user_id')
  final String userId;

  final String username;
  final String platform;

  @JsonKey(name: 'bot_type')
  final String botType;

  @JsonKey(name: 'ticker_symbol')
  final String tickerSymbol;

  final String duration;

  const PortfolioDetailsRequest.empty()
      : userId = '',
        ticker = '',
        username = '',
        platform = '',
        botType = '',
        tickerSymbol = '',
        duration = '';

  const PortfolioDetailsRequest(
      {required String input,
      required this.userId,
      required this.ticker,
      required this.username,
      required this.platform,
      required this.botType,
      required this.tickerSymbol,
      required this.duration})
      : super(input: input);

  Map<String, String> get params => {
        'input': input,
        'user_id': userId,
        'ticker': ticker,
        'username': username,
        'platform': platform,
        'bot_type': botType,
        'ticker_symbol': tickerSymbol,
        'duration': duration,
      };

  factory PortfolioDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$PortfolioDetailsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PortfolioDetailsRequestToJson(this);

  @override
  List<Object> get props =>
      [input, userId, username, platform, botType, tickerSymbol, duration];
}
