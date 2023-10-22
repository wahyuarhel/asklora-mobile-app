import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'affiliated_person.dart';
import 'agreement.dart';
import 'proofs_of_address_request.dart';
import 'residence_info_request.dart';
import 'wealth_sources_request.dart';

part 'upgrade_account_response.g.dart';

@JsonSerializable(explicitToJson: true)
class UpgradeAccountResponse extends Equatable {
  @JsonKey(name: 'residence_info')
  final ResidenceInfoRequest? residenceInfo;

  @JsonKey(name: 'proofs_of_address')
  final List<ProofsOfAddressRequest>? proofsOfAddress;

  @JsonKey(name: 'employment_info')
  final ProofsOfAddressRequest? employmentInfo;

  @JsonKey(name: 'wealth_sources')
  final List<WealthSourcesRequest>? wealthSources;

  @JsonKey(name: 'affiliated_person')
  final AffiliatedPerson? affiliatedPerson;

  final List<Agreement>? agreements;

  const UpgradeAccountResponse({
    this.residenceInfo,
    this.proofsOfAddress,
    this.employmentInfo,
    this.wealthSources,
    this.affiliatedPerson,
    this.agreements,
  });

  factory UpgradeAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$UpgradeAccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpgradeAccountResponseToJson(this);

  @override
  List<Object> get props => [
        residenceInfo!,
        proofsOfAddress!,
        employmentInfo!,
        wealthSources!,
        affiliatedPerson!,
        agreements!,
      ];

  UpgradeAccountResponse copyWith({
    ResidenceInfoRequest? residenceInfo,
    List<ProofsOfAddressRequest>? proofsOfAddress,
    ProofsOfAddressRequest? employmentInfo,
    List<WealthSourcesRequest>? wealthSources,
    AffiliatedPerson? affiliatedPerson,
    List<Agreement>? agreements,
  }) {
    return UpgradeAccountResponse(
      residenceInfo: residenceInfo ?? this.residenceInfo,
      proofsOfAddress: proofsOfAddress ?? this.proofsOfAddress,
      employmentInfo: employmentInfo ?? this.employmentInfo,
      wealthSources: wealthSources ?? this.wealthSources,
      affiliatedPerson: affiliatedPerson ?? this.affiliatedPerson,
      agreements: agreements ?? this.agreements,
    );
  }
}
