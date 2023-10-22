import 'package:json_annotation/json_annotation.dart';

part 'stop_loss.g.dart';

@JsonSerializable()
class StopLoss {
  final String stopPrice;
  final String? limitPrice;

  StopLoss({required this.stopPrice, this.limitPrice});

  factory StopLoss.fromJson(Map<String, dynamic> json) =>
      _$StopLossFromJson(json);

  Map<String, dynamic> toJson() => _$StopLossToJson(this);
}
