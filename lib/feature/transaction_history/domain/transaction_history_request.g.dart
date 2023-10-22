// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_history_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionHistoryRequest _$TransactionHistoryRequestFromJson(
        Map<String, dynamic> json) =>
    TransactionHistoryRequest(
      json['transaction_history_type'] as String,
    );

Map<String, dynamic> _$TransactionHistoryRequestToJson(
        TransactionHistoryRequest instance) =>
    <String, dynamic>{
      'transaction_history_type': instance.transactionHistoryType,
    };
