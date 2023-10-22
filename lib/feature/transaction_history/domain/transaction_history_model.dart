import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../core/utils/date_utils.dart';
import '../../../core/utils/extensions.dart';
import '../../../generated/l10n.dart';
import '../utils/transaction_history_util.dart';

part 'transaction_history_model.g.dart';

enum TransactionHistoryType { all, bot, transfer, subscription }

@JsonSerializable()
class TransactionHistoryModel extends Equatable {
  @JsonKey(name: 'history_type')
  final TransactionHistoryType transactionHistoryType;
  final dynamic id;
  final String? created;
  final String updated;
  final String title;
  final String status;
  final dynamic amount;
  @JsonKey(name: 'bank_code')
  final String? bankCode;
  @JsonKey(name: 'bank_account_number')
  final String? bankAccountNumber;
  @JsonKey(name: 'time_complete')
  final String? timeComplete;
  @JsonKey(name: 'time_rejected')
  final String? timeRejected;
  @JsonKey(name: 'is_refunded')
  final bool? isRefunded;
  @JsonKey(name: 'is_dummy')
  final bool isDummy;

  DateTime? get createdDateTimeFormat {
    if (created != null) {
      try {
        return DateTime.parse(created!);
      } catch (_) {
        return null;
      }
    } else {
      return null;
    }
  }

  const TransactionHistoryModel(
    this.id,
    this.transactionHistoryType,
    this.created,
    this.updated,
    this.title,
    this.status,
    this.amount, {
    this.timeComplete,
    this.timeRejected,
    this.isRefunded,
    this.bankCode,
    this.bankAccountNumber,
    this.isDummy = false,
  });

  String get amountString => checkDouble(amount).convertToCurrencyDecimal();

  String get idString => id.toString();

  TransferStatus get transferStatus => TransferStatus.find(status,
      isRefunded: isRefunded, timeRejected: timeRejected);

  TransferType get transferType => TransferType.findByString(title);

  String depositOrWithdrawalAmountTitle(BuildContext context) =>
      transferType == TransferType.withdraw
          ? S.of(context).withdrawalAmount
          : S.of(context).depositAmount;

  String get createdFormatted {
    if (created != null && created!.isNotEmpty) {
      DateTime localTime = formatDateTimeToLocal(created);
      return '${formatDateTimeAsString(localTime, dateFormat: 'dd/MM/yyyy HH:mm')}${localTime.timeZoneName}';
    } else {
      return '-';
    }
  }

  String get timeCompletedFormatted {
    if (timeComplete != null && timeComplete!.isNotEmpty) {
      DateTime localTime = formatDateTimeToLocal(timeComplete);
      return '${formatDateTimeAsString(localTime, dateFormat: 'dd/MM/yyyy HH:mm')}${localTime.timeZoneName}';
    }
    return '-';
  }

  String get bankAccountNumberString => '$bankCode-$bankAccountNumber';

  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionHistoryModelToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      created,
      title,
      status,
      amount,
      transactionHistoryType,
      isDummy
    ];
  }
}
