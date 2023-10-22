// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_details_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioDetailsRequest _$PortfolioDetailsRequestFromJson(
        Map<String, dynamic> json) =>
    PortfolioDetailsRequest(
      input: json['input'] as String,
      userId: json['user_id'] as String,
      ticker: json['ticker'] as String,
      username: json['username'] as String,
      platform: json['platform'] as String,
      botType: json['bot_type'] as String,
      tickerSymbol: json['ticker_symbol'] as String,
      duration: json['duration'] as String,
    );

Map<String, dynamic> _$PortfolioDetailsRequestToJson(
        PortfolioDetailsRequest instance) =>
    <String, dynamic>{
      'input': instance.input,
      'ticker': instance.ticker,
      'user_id': instance.userId,
      'username': instance.username,
      'platform': instance.platform,
      'bot_type': instance.botType,
      'ticker_symbol': instance.tickerSymbol,
      'duration': instance.duration,
    };
