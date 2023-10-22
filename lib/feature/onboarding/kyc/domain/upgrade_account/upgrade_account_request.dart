import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/utils/extensions.dart';
import '../../bloc/address_proof/address_proof_bloc.dart';
import '../../bloc/disclosure_affiliation/disclosure_affiliation_bloc.dart';
import '../../bloc/financial_profile/financial_profile_bloc.dart';
import '../../bloc/source_of_wealth/source_of_wealth_bloc.dart';
import '../../utils/kyc_dropdown_enum.dart';
import 'affiliated_person.dart';
import 'agreement.dart';
import 'employment_info.dart';
import 'proofs_of_address_request.dart';
import 'residence_info_request.dart';
import 'wealth_sources_request.dart';

part 'upgrade_account_request.g.dart';

@JsonSerializable(explicitToJson: true)
class UpgradeAccountRequest extends Equatable {
  @JsonKey(name: 'residence_info')
  final ResidenceInfoRequest? residenceInfo;

  @JsonKey(name: 'proofs_of_address')
  final List<ProofsOfAddressRequest>? proofsOfAddress;

  @JsonKey(name: 'employment_info')
  final EmploymentInfo? employmentInfo;

  @JsonKey(name: 'wealth_sources', includeIfNull: false)
  final List<WealthSourcesRequest>? wealthSources;

  @JsonKey(name: 'affiliated_person', includeIfNull: false)
  final AffiliatedPerson? affiliatedPerson;

  final List<Agreement>? agreements;

  const UpgradeAccountRequest({
    this.residenceInfo,
    this.proofsOfAddress,
    this.employmentInfo,
    this.wealthSources,
    this.affiliatedPerson,
    this.agreements = const [
      Agreement(agreement: 'ACA'),
      Agreement(agreement: 'RDS'),
      Agreement(agreement: 'W8BEN'),
    ],
  });

  static UpgradeAccountRequest getRequestForSavingKyc(BuildContext context) {
    final AddressProofState addressProofState =
        context.read<AddressProofBloc>().state;
    final FinancialProfileState financialProfileState =
        context.read<FinancialProfileBloc>().state;
    final DisclosureAffiliationState disclosureAffiliationState =
        context.read<DisclosureAffiliationBloc>().state;
    final SourceOfWealthState sourceOfWealthState =
        context.read<SourceOfWealthBloc>().state;
    return UpgradeAccountRequest(
        residenceInfo: ResidenceInfoRequest(
          addressLine1: addressProofState.addressLine1,
          addressLine2: addressProofState.addressLine2,
          district: addressProofState.district?.value,
          region: addressProofState.region?.value,
        ),
        proofsOfAddress: addressProofState.addressProofImages
            .map((e) => ProofsOfAddressRequest(proofFile: e.base64Image()))
            .toList(),
        employmentInfo: EmploymentInfo(
            employmentStatus: financialProfileState.employmentStatus.value,
            employer: financialProfileState.employer,
            employerBusiness: financialProfileState.natureOfBusiness?.value,
            employerBusinessDescription:
                financialProfileState.natureOfBusinessDescription,
            occupation: financialProfileState.occupation != Occupations.other
                ? financialProfileState.occupation?.value
                : financialProfileState.otherOccupation,
            employerAddressLine1: financialProfileState.employerAddress,
            employerAddressLine2: financialProfileState.employerAddressTwo,
            district: financialProfileState.district?.value,
            region: financialProfileState.region?.value,
            country: financialProfileState.country,
            differentCountryReason:
                financialProfileState.detailInformationOfCountry),
        wealthSources: sourceOfWealthState.sourceOfWealthAnswers
            .map((e) => WealthSourcesRequest(
                  wealthSource: e.sourceOfWealthType.value,
                  percentage: e.amount,
                ))
            .toList(),
        affiliatedPerson: disclosureAffiliationState
                    .affiliatedPersonFirstName.isEmpty &&
                disclosureAffiliationState.affiliatedPersonLastName.isEmpty
            ? null
            : AffiliatedPerson(
                firstName: disclosureAffiliationState.affiliatedPersonFirstName,
                lastName: disclosureAffiliationState.affiliatedPersonLastName,
              ));
  }

  factory UpgradeAccountRequest.fromJson(Map<String, dynamic> json) =>
      _$UpgradeAccountRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpgradeAccountRequestToJson(this);

  @override
  List<Object> get props => [
        residenceInfo ?? '',
        proofsOfAddress ?? '',
        employmentInfo ?? '',
        wealthSources ?? '',
        affiliatedPerson ?? '',
        agreements ?? '',
      ];
}
