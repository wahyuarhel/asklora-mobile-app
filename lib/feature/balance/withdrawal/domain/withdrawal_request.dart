import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'withdrawal_request.g.dart';

@JsonSerializable()
class WithdrawalRequest extends Equatable {
  final String amount;

  const WithdrawalRequest({required this.amount});

  factory WithdrawalRequest.fromJson(Map<String, dynamic> json) =>
      _$WithdrawalRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawalRequestToJson(this);

  @override
  List<Object?> get props => [amount];
}
