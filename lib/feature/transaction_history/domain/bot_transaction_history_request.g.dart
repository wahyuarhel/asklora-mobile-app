// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bot_transaction_history_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BotTransactionHistoryRequest _$BotTransactionHistoryRequestFromJson(
        Map<String, dynamic> json) =>
    BotTransactionHistoryRequest(
      status:
          (json['status'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$BotTransactionHistoryRequestToJson(
    BotTransactionHistoryRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('status', instance.status);
  return val;
}
