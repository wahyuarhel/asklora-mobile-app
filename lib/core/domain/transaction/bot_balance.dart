import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bot_balance.g.dart';

@JsonSerializable()
class BotBalance extends Equatable {
  @JsonKey(name: 'fully_settled_balance_hkd')
  final double fullySettledBalanceHkd;
  @JsonKey(name: 'fully_settled_balance_usd')
  final double fullySettledBalanceUsd;
  final String name;

  const BotBalance(
    this.fullySettledBalanceHkd,
    this.fullySettledBalanceUsd,
    this.name,
  );

  factory BotBalance.fromJson(Map<String, dynamic> json) =>
      _$BotBalanceFromJson(json);

  Map<String, dynamic> toJson() => _$BotBalanceToJson(this);

  @override
  List<Object> get props => [
        fullySettledBalanceHkd,
        fullySettledBalanceUsd,
        name,
      ];
}
