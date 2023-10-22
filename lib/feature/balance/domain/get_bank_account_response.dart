import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_bank_account_response.g.dart';

@JsonSerializable()
class GetBankAccountResponse extends Equatable {
  final String? uid;
  final String? country;
  @JsonKey(name: 'state_province')
  final String? stateProvince;
  @JsonKey(name: 'postal_code')
  final String? postalCode;
  final String? city;
  @JsonKey(name: 'street_address')
  final String? streetAddress;
  final String? name;
  @JsonKey(name: 'bank_code')
  final String? bankCode;
  @JsonKey(name: 'bank_type')
  final String? bankType;
  @JsonKey(name: 'bank_transfer_type')
  final String? bankTransferType;
  @JsonKey(name: 'account_name')
  final String? accountName;
  @JsonKey(name: 'account_number')
  final String? accountNumber;

  const GetBankAccountResponse(
      this.stateProvince,
      this.bankType,
      this.uid,
      this.bankCode,
      this.accountName,
      this.accountNumber,
      this.bankTransferType,
      this.country,
      this.name,
      this.postalCode,
      this.city,
      this.streetAddress);

  factory GetBankAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBankAccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetBankAccountResponseToJson(this);

  @override
  List<Object?> get props => [
        uid,
        bankTransferType,
        bankCode,
        accountName,
        accountNumber,
        country,
        name,
        postalCode,
        city,
        streetAddress
      ];
}
