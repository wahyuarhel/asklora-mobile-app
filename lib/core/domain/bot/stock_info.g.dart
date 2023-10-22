// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockInfo _$StockInfoFromJson(Map<String, dynamic> json) => StockInfo(
      json['symbol'] as String,
      json['ticker_name'] as String,
      json['chinese_name'] as String,
      json['traditional_name'] as String,
      json['description'] as String,
      json['sector'] as String,
      json['industry'] as String,
      json['ceo'] as String,
      json['employees'] as int,
      json['headquarter'] as String,
      json['founded'] as String,
    );

Map<String, dynamic> _$StockInfoToJson(StockInfo instance) => <String, dynamic>{
      'symbol': instance.symbol,
      'ticker_name': instance.tickerName,
      'chinese_name': instance.chineseName,
      'traditional_name': instance.traditionalName,
      'description': instance.description,
      'sector': instance.sector,
      'industry': instance.industry,
      'ceo': instance.ceo,
      'employees': instance.employees,
      'headquarter': instance.headquarter,
      'founded': instance.founded,
    };
