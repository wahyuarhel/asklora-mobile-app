import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../app/bloc/app_bloc.dart';
import '../../../../core/domain/base_response.dart';
import '../../../../core/presentation/buttons/button_pair.dart';
import '../../../../core/presentation/custom_in_app_notification.dart';
import '../../../../core/presentation/custom_text_new.dart';
import '../../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/feature_flags.dart';
import '../../../../generated/l10n.dart';
import '../bloc/address_proof/address_proof_bloc.dart';
import '../bloc/disclosure_affiliation/disclosure_affiliation_bloc.dart';
import '../bloc/financial_profile/financial_profile_bloc.dart';
import '../bloc/kyc_bloc.dart';
import '../bloc/personal_info/personal_info_bloc.dart';
import '../bloc/source_of_wealth/source_of_wealth_bloc.dart';
import '../domain/upgrade_account/affiliated_person.dart';
import '../domain/upgrade_account/employment_info.dart';
import '../domain/upgrade_account/proofs_of_address_request.dart';
import '../domain/upgrade_account/residence_info_request.dart';
import '../domain/upgrade_account/save_kyc_request.dart';
import '../domain/upgrade_account/upgrade_account_request.dart';
import '../domain/upgrade_account/wealth_sources_request.dart';
import '../utils/kyc_dropdown_enum.dart';
import '../utils/source_of_wealth_enum.dart';
import 'financial_profile/widgets/financial_profile_summary_content.dart';
import 'personal_info/widgets/personal_info_summary_content.dart';
import 'sign_agreements/widgets/sign_agreement_summary_content.dart';
import 'widgets/kyc_base_form.dart';

class KycSummaryScreen extends StatelessWidget {
  final PersonalInfoState personalInfoState;
  final AddressProofState addressProofState;
  final DisclosureAffiliationState disclosureAffiliationState;
  final FinancialProfileState financialProfileState;
  final SourceOfWealthState sourceOfWealthState;
  final double progress;

  const KycSummaryScreen(
      {required this.personalInfoState,
      required this.progress,
      required this.addressProofState,
      required this.disclosureAffiliationState,
      required this.financialProfileState,
      required this.sourceOfWealthState,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KycBaseForm(
      onTapBack: () =>
          context.read<NavigationBloc<KycPageStep>>().add(const PagePop()),
      title: S.of(context).summary,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PersonalInfoSummaryContent(
            key: const Key('personal_info_summary_content'),
            personalInfoState: personalInfoState,
            addressProofState: addressProofState,
            title: S.of(context).personalInfo,
          ),
          const SizedBox(
            height: 56,
          ),
          FinancialProfileSummaryContent(
            key: const Key('financial_profile_summary_content'),
            disclosureAffiliationState: disclosureAffiliationState,
            financialProfileState: financialProfileState,
            sourceOfWealthState: sourceOfWealthState,
            title: S.of(context).financialProfile,
          ),
          const SizedBox(
            height: 56,
          ),
          SignAgreementSummaryContent(
              key: const Key('sign_agreement_summary_content'),
              title: S.of(context).agreements),
          const SizedBox(height: 50),
          CustomTextNew(
            S.of(context).summaryAgreementInformation,
            textAlign: TextAlign.center,
          )
        ],
      ),
      bottomButton: _bottomButton(context),
      progress: progress,
    );
  }

  Widget _bottomButton(BuildContext context) => BlocListener<KycBloc, KycState>(
        listenWhen: (previous, current) =>
            previous.submitKycResponse.state != current.submitKycResponse.state,
        listener: (context, state) {
          CustomLoadingOverlay.of(context).show(state.submitKycResponse.state);
          switch (state.submitKycResponse.state) {
            case ResponseState.error:
              CustomInAppNotification.show(
                  context, state.submitKycResponse.message);
              break;
            case ResponseState.success:
              context
                  .read<AppBloc>()
                  .add(const SaveUserJourney(UserJourney.deposit));
              context
                  .read<NavigationBloc<KycPageStep>>()
                  .add(const PageChanged(KycPageStep.kycResultScreen));
              break;
            default:
              break;
          }
        },
        child: ButtonPair(
          primaryButtonOnClick: () {
            context.read<KycBloc>().add(_submitKyc());
          },
          secondaryButtonOnClick: () => context
              .read<KycBloc>()
              .add(SaveKyc(SaveKycRequest.getRequestForSavingKyc(context))),
          primaryButtonLabel: S.of(context).submitApplication,
          secondaryButtonLabel: S.of(context).saveForLater,
        ),
      );

  SubmitKyc _submitKyc() {
    return SubmitKyc(UpgradeAccountRequest(
        residenceInfo: ResidenceInfoRequest(
          addressLine1: addressProofState.addressLine1,
          addressLine2: addressProofState.addressLine2,
          district: addressProofState.district?.value,
          region: addressProofState.region?.value,
        ),
        proofsOfAddress: addressProofState.addressProofImages.map((e) {
          return ProofsOfAddressRequest(proofFile: e.base64Image());
        }).toList(),
        employmentInfo: EmploymentInfo(

            /// TODO: Confirm with James if we want to show the source of wealth and employment or not.
            /// Disabling the source of wealth and employment as there are few demo with potential investors.
            employmentStatus: FeatureFlags.isDemoEnable
                ? EmploymentStatus.unemployed.value
                : financialProfileState.employmentStatus.value,
            employer: financialProfileState.employer,
            employerBusiness: financialProfileState.natureOfBusiness?.value,
            employerBusinessDescription:
                financialProfileState.natureOfBusinessDescription,
            occupation: financialProfileState.occupation?.value,
            employerAddressLine1: financialProfileState.employerAddress,
            employerAddressLine2: financialProfileState.employerAddressTwo,
            district: financialProfileState.district?.value,
            region: financialProfileState.region?.value,
            country: financialProfileState.country,
            differentCountryReason:
                financialProfileState.detailInformationOfCountry),

        /// TODO: Confirm with James if we want to show the source of wealth and employment or not.
        /// Disabling the source of wealth and employment as there are few demo with potential investors.
        wealthSources: FeatureFlags.isDemoEnable
            ? [
                WealthSourcesRequest(
                    wealthSource: SourceOfWealthType.incomeFromEmployment.value,
                    percentage: 100)
              ]
            : sourceOfWealthState.sourceOfWealthAnswers
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
              )));
  }
}
