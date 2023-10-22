import 'package:json_annotation/json_annotation.dart';
import '../../../../../core/domain/bot/bot_detail_model.dart';
import '../../../../../core/domain/bot/bot_info.dart';
import 'bot_activities_transaction_history_model.dart';
import 'bot_summary_transaction_history_model.dart';

part 'bot_detail_transaction_history_response.g.dart';

@JsonSerializable()
class BotDetailTransactionHistoryResponse extends BotDetailModel {
  final List<BotSummaryTransactionHistoryModel> summary;
  final List<BotActivitiesTransactionHistoryModel> activities;

  const BotDetailTransactionHistoryResponse(
      String uid,
      String name,
      BotInfo botInfo,
      double investmentAmount,
      double? finalReturn,
      String botDuration,
      String spotDate,
      String? expireDate,
      double estMaxLoss,
      double estMaxProfit,
      String status,
      int rolloverCount,
      double botStockValue,
      double totalPnLPct,
      this.summary,
      this.activities)
      : super(
            uid,
            name,
            botInfo,
            investmentAmount,
            finalReturn,
            botDuration,
            spotDate,
            expireDate,
            estMaxLoss,
            estMaxProfit,
            status,
            rolloverCount,
            botStockValue,
            totalPnLPct);

  factory BotDetailTransactionHistoryResponse.fromJson(
          Map<String, dynamic> json) =>
      _$BotDetailTransactionHistoryResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$BotDetailTransactionHistoryResponseToJson(this);
}
