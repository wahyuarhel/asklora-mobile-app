import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction_history_request.g.dart';

@JsonSerializable()
class TransactionHistoryRequest extends Equatable {
  @JsonKey(name: 'transaction_history_type')
  final String transactionHistoryType;

  const TransactionHistoryRequest(
    this.transactionHistoryType,
  );

  factory TransactionHistoryRequest.fromJson(Map<String, dynamic> json) =>
      _$TransactionHistoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionHistoryRequestToJson(this);

  @override
  List<Object?> get props {
    return [
      transactionHistoryType,
    ];
  }
}
