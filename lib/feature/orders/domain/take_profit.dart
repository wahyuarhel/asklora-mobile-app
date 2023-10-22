import 'package:json_annotation/json_annotation.dart';

part 'take_profit.g.dart';

@JsonSerializable()
class TakeProfit {
  final String limitPrice;

  TakeProfit({required this.limitPrice});

  factory TakeProfit.fromJson(Map<String, dynamic> json) =>
      _$TakeProfitFromJson(json);

  Map<String, dynamic> toJson() => _$TakeProfitToJson(this);
}
