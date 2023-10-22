import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'deposit_response.g.dart';

@JsonSerializable()
class DepositResponse extends Equatable {
  final String detail;

  const DepositResponse(this.detail);

  factory DepositResponse.fromJson(Map<String, dynamic> json) =>
      _$DepositResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DepositResponseToJson(this);

  @override
  List<Object?> get props => [detail];
}
