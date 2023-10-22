import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../../core/utils/date_utils.dart';
import '../../../../../../core/utils/extensions.dart';
import '../../../utils/transaction_history_util.dart';

part 'bot_summary_transaction_history_model.g.dart';

@JsonSerializable()
class BotSummaryTransactionHistoryModel extends Equatable {
  final String uid;
  final String type;
  final String date;
  final double amount;
  final double fee;
  final String status;
  @JsonKey(name: 'total_pnl')
  final double totalPnL;

  String get totalPnLString {
    final double finalPnlAmountDouble = checkDouble(totalPnL);
    return (finalPnlAmountDouble > 0)
        ? '+\$$finalPnlAmountDouble'
        : (finalPnlAmountDouble < 0)
            ? '\$$finalPnlAmountDouble'
            : 'NA';
  }

  String get investmentAmountString {
    final double investmentAmountDouble = checkDouble(amount);
    return (investmentAmountDouble > 0)
        ? 'HKD ${investmentAmountDouble.convertToCurrencyDecimal()}'
        : 'NA';
  }

  String get feeString => 'HKD ${checkDouble(fee).convertToCurrencyDecimal()}';

  String get createdFormattedString {
    return '${convertDateToHktString(date, dateFormat: 'dd/MM/yyyy HH:mm:ss')} HKT';
  }

  BotSummaryType get botSummaryType => BotSummaryType.findByString(type);

  const BotSummaryTransactionHistoryModel(this.uid, this.type, this.date,
      this.status, this.amount, this.fee, this.totalPnL);

  factory BotSummaryTransactionHistoryModel.fromJson(
          Map<String, dynamic> json) =>
      _$BotSummaryTransactionHistoryModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$BotSummaryTransactionHistoryModelToJson(this);

  @override
  List<Object?> get props {
    return [uid, date, status, amount];
  }
}
