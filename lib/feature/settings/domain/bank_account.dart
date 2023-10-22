import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bank_account.g.dart';

@JsonSerializable()
class BankAccount extends Equatable {
  final String? status;
  final String? country;
  @JsonKey(name: 'state_province')
  final String? stateProvince;
  @JsonKey(name: 'postal_code')
  final String? postalCode;
  final String? city;
  @JsonKey(name: 'street_address')
  final String? streetAddress;
  final String name;
  @JsonKey(name: 'bank_id')
  final String? bankId;
  @JsonKey(name: 'bank_code')
  final String bankCode;
  @JsonKey(name: 'bank_code_type')
  final String? bankCodeType;
  @JsonKey(name: 'bank_transfer_type')
  final String? bankTransferType;
  @JsonKey(name: 'account_number')
  final String accountNumber;
  @JsonKey(name: 'account_name')
  final String accountName;

  const BankAccount(
    this.status,
    this.country,
    this.stateProvince,
    this.postalCode,
    this.city,
    this.streetAddress,
    this.name,
    this.bankId,
    this.bankCode,
    this.bankCodeType,
    this.bankTransferType,
    this.accountNumber,
    this.accountName,
  );

  factory BankAccount.fromJson(Map<String, dynamic> json) =>
      _$BankAccountFromJson(json);

  Map<String, dynamic> toJson() => _$BankAccountToJson(this);

  @override
  List<Object?> get props => [
        status,
        country,
        stateProvince,
        postalCode,
        city,
        streetAddress,
        name,
        bankId,
        bankCode,
        bankCodeType,
        bankTransferType,
        accountNumber,
        accountName,
      ];
}
