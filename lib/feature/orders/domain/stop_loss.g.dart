// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stop_loss.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StopLoss _$StopLossFromJson(Map<String, dynamic> json) => StopLoss(
      stopPrice: json['stopPrice'] as String,
      limitPrice: json['limitPrice'] as String?,
    );

Map<String, dynamic> _$StopLossToJson(StopLoss instance) => <String, dynamic>{
      'stopPrice': instance.stopPrice,
      'limitPrice': instance.limitPrice,
    };
