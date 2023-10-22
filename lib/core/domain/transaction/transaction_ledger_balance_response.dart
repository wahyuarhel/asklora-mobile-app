import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../utils/extensions.dart';

part 'transaction_ledger_balance_response.g.dart';

@JsonSerializable()
class TransactionLedgerBalanceResponse extends Equatable {
  @JsonKey(name: 'fully_settled_balance_hkd')
  final double fullySettledBalanceHkd;
  @JsonKey(name: 'fully_settled_balance_usd')
  final double fullySettledBalanceUsd;
  @JsonKey(name: 'buying_power')
  final double buyingPower;
  @JsonKey(name: 'withdrawable_balance')
  final double withdrawableBalance;
  @JsonKey(name: 'account_name')
  final String accountName;
  @JsonKey(name: 'user_id')
  final double userId;

  const TransactionLedgerBalanceResponse(
    this.fullySettledBalanceHkd,
    this.fullySettledBalanceUsd,
    this.buyingPower,
    this.withdrawableBalance,
    this.accountName,
    this.userId,
  );

  factory TransactionLedgerBalanceResponse.fromJson(
          Map<String, dynamic> json) =>
      _$TransactionLedgerBalanceResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$TransactionLedgerBalanceResponseToJson(this);

  String get buyingPowerStr =>
      buyingPower != 0 ? buyingPower.convertToCurrencyDecimal() : '/';

  @override
  List<Object> get props => [
        fullySettledBalanceHkd,
        fullySettledBalanceUsd,
        buyingPower,
        withdrawableBalance,
        accountName,
        userId,
      ];
}
