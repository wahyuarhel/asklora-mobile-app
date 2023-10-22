import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'withdrawal_response.g.dart';

@JsonSerializable()
class WithdrawalResponse extends Equatable {
  final String amount;
  final String uid;

  const WithdrawalResponse(this.amount, this.uid);

  factory WithdrawalResponse.fromJson(Map<String, dynamic> json) =>
      _$WithdrawalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawalResponseToJson(this);

  @override
  List<Object?> get props => [amount, uid];
}
