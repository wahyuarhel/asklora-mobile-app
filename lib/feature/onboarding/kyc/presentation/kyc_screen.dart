import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/repository/user_journey_repository.dart';
import '../../../../core/domain/base_response.dart';
import '../../../../core/presentation/custom_in_app_notification.dart';
import '../../../../core/presentation/custom_scaffold.dart';
import '../../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../core/presentation/navigation/custom_navigation_widget.dart';
import '../../../../core/utils/storage/shared_preference.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/otp/repository/otp_repository.dart';
import '../../../tabs/presentation/tab_screen.dart';
import '../bloc/address_proof/address_proof_bloc.dart';
import '../bloc/disclosure_affiliation/disclosure_affiliation_bloc.dart';
import '../bloc/financial_profile/financial_profile_bloc.dart';
import '../bloc/kyc_bloc.dart';
import '../bloc/personal_info/personal_info_bloc.dart';
import '../bloc/signing_agreement/signing_agreement_bloc.dart';
import '../bloc/source_of_wealth/source_of_wealth_bloc.dart';
import '../domain/upgrade_account/save_kyc_request.dart';
import '../repository/account_repository.dart';
import '../repository/signing_broker_agreement_repository.dart';
import 'financial_profile/disclosure_affiliation_associates_screen.dart';
import 'financial_profile/disclosure_affiliation_commission_screen.dart';
import 'financial_profile/disclosure_affiliation_input_screen/disclosure_affiliation_person_input_screen.dart';
import 'financial_profile/disclosure_affiliation_person_screen.dart';
import 'financial_profile/financial_profile_employment_question.dart';
import 'financial_profile/financial_profile_source_of_wealth_screen.dart';
import 'financial_profile/financial_profile_summary_screen.dart';
import 'kyc_progress/kyc_progress_screen.dart';
import 'kyc_rejected_screen.dart';
import 'kyc_result_screen.dart';
import 'kyc_summary_screen.dart';
import 'personal_info/address_proof_screen.dart';
import 'personal_info/otp/bloc/otp_bloc.dart';
import 'personal_info/otp/presentation/otp_screen.dart';
import 'personal_info/personal_info_summary_screen.dart';
import 'personal_info/personal_info_screen.dart';
import 'personal_info/resident_check_screen.dart';
import 'sign_agreements/broker_agreement_screen.dart';
import 'sign_agreements/risk_disclosure_agreement_screen.dart';
import 'sign_agreements/tax_agreement_screen.dart';
import 'verify_identity/verify_identity_screen.dart';

class KycScreen extends StatelessWidget {
  static const String route = '/kyc_screen';
  final KycPageStep initialKycPageStep;

  const KycScreen({this.initialKycPageStep = KycPageStep.progress, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      enableBackNavigation: false,
      body: BlocProvider(
        create: (context) => KycBloc(
            accountRepository: AccountRepository(),
            userJourneyRepository: UserJourneyRepository())
          ..add(const FetchKyc()),
        child: BlocConsumer<KycBloc, KycState>(
          listener: (context, state) {
            CustomLoadingOverlay.of(context).show(state.fetchKycResponse.state);
          },
          buildWhen: (previous, current) =>
              previous.fetchKycResponse.state != current.fetchKycResponse.state,
          builder: (context, state) {
            SaveKycRequest? saveKycRequest = state.fetchKycResponse.data;
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (_) =>
                        NavigationBloc<KycPageStep>(initialKycPageStep)),
                BlocProvider(
                    lazy: !(saveKycRequest?.personalInfoRequest != null),
                    create: (context) =>
                        PersonalInfoBloc(accountRepository: AccountRepository())
                          ..add(InitiatePersonalInfo(
                              saveKycRequest?.personalInfoRequest))),
                BlocProvider(
                  create: (context) => OtpBloc(
                      otpRepository: OtpRepository(),
                      sharedPreference: SharedPreference()),
                ),
                BlocProvider(
                  lazy: !(saveKycRequest?.upgradeAccountRequest.residenceInfo !=
                          null ||
                      saveKycRequest?.upgradeAccountRequest.proofsOfAddress !=
                          null),
                  create: (context) => AddressProofBloc()
                    ..add(InitiateAddressProof(
                        saveKycRequest?.upgradeAccountRequest.residenceInfo,
                        saveKycRequest?.upgradeAccountRequest.proofsOfAddress)),
                ),
                BlocProvider(
                  lazy: !(saveKycRequest?.immediateFamilyAffiliation != null ||
                      saveKycRequest?.associatesAffiliation != null ||
                      saveKycRequest?.upgradeAccountRequest.affiliatedPerson !=
                          null),
                  create: (context) => DisclosureAffiliationBloc()
                    ..add(InitiateDisclosureAffiliation(
                        saveKycRequest?.immediateFamilyAffiliation,
                        saveKycRequest?.associatesAffiliation,
                        saveKycRequest
                            ?.upgradeAccountRequest.affiliatedPerson)),
                ),
                BlocProvider(
                  lazy:
                      !(saveKycRequest?.upgradeAccountRequest.employmentInfo !=
                          null),
                  create: (context) => FinancialProfileBloc()
                    ..add(InitiateFinancialProfile(
                        saveKycRequest?.upgradeAccountRequest.employmentInfo)),
                ),
                BlocProvider(
                  lazy: !(saveKycRequest?.upgradeAccountRequest.wealthSources !=
                      null),
                  create: (context) => SourceOfWealthBloc()
                    ..add(InitiateSourceOfWealth(
                        saveKycRequest?.upgradeAccountRequest.wealthSources)),
                ),
                BlocProvider(
                  lazy: saveKycRequest != null ? false : true,
                  create: (context) => SigningAgreementBloc(
                      signingBrokerAgreementRepository:
                          SigningBrokerAgreementRepository(),
                      personalInfoBloc: context.read<PersonalInfoBloc>())
                    ..add(InitiateSignAgreement(
                        saveKycRequest?.isBoundByAskloraAgreementChecked,
                        saveKycRequest?.isUnderstandOnTheAgreementChecked,
                        saveKycRequest?.isRiskDisclosureAgreementChecked,
                        saveKycRequest?.isSignatureChecked,
                        saveKycRequest?.legalNameSignature)),
                ),
              ],
              child: BlocListener<KycBloc, KycState>(
                listenWhen: (previous, current) =>
                    previous.saveKycResponse.state !=
                    current.saveKycResponse.state,
                listener: (context, state) {
                  CustomLoadingOverlay.of(context)
                      .show(state.saveKycResponse.state);

                  if (state.saveKycResponse.state == ResponseState.success) {
                    TabScreen.openAndRemoveAllRoute(context);
                  } else if (state.saveKycResponse.state ==
                      ResponseState.error) {
                    CustomInAppNotification.show(
                        context, state.saveKycResponse.message);
                  }
                },
                child: Builder(
                  builder: (context) => CustomNavigationWidget<KycPageStep>(
                    padding: EdgeInsets.zero,
                    header: const SizedBox.shrink(),
                    onBackPressed: () {
                      context
                          .read<NavigationBloc<KycPageStep>>()
                          .add(const PagePop());
                    },
                    child: BlocListener<NavigationBloc<KycPageStep>,
                            NavigationState>(
                        listenWhen: (_, current) => current.lastPage == true,
                        listener: (context, state) => Navigator.pop(context),
                        child: _getPages),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget get _getPages {
    return BlocBuilder<NavigationBloc<KycPageStep>, NavigationState>(
        buildWhen: (previous, current) => previous.page != current.page,
        builder: (context, state) {
          switch (state.page) {
            case KycPageStep.progress:
              return const KycProgressScreen(
                currentStep: 1,
              );
            case KycPageStep.residentCheck:
              return const ResidentCheckScreen(
                progress: 0.05,
              );
            case KycPageStep.personalInfoRejected:
              return KycRejectedScreen(
                rejectedReason:
                    'Asklora is only available to Hong Kong Residents who are NOT US Citizens',
                onGoBack: () =>
                    context.read<PersonalInfoBloc>().add(ResetResidentAnswer()),
              );
            case KycPageStep.personalInfo:
              return const PersonalInfoScreen(
                progress: 0.1,
              );
            case KycPageStep.otp:
              return const OtpScreen(
                progress: 0.15,
              );
            case KycPageStep.addressProof:
              return const AddressProofScreen(
                progress: 0.20,
              );
            case KycPageStep.personalInfoSummary:
              return PersonalInfoSummaryScreen(
                personalInfoState: context.read<PersonalInfoBloc>().state,
                progress: 0.25,
                addressProofState: context.read<AddressProofBloc>().state,
              );

            case KycPageStep.disclosureAffiliationPerson:
              return const DisclosureAffiliationPersonScreen(
                progress: 0.3,
              );
            case KycPageStep.disclosureAffiliationCommissions:
              return const DisclosureAffiliationCommissionScreen(
                progress: 0.45,
              );
            case KycPageStep.financialProfileEmployment:
              return const FinancialProfileEmploymentQuestion(
                progress: 0.35,
              );
            case KycPageStep.financialProfileSourceOfWealth:
              return FinancialProfileSourceOfWealthScreen(
                progress: 0.45,
              );
            case KycPageStep.disclosureAffiliationAssociates:
              return const DisclosureAffiliationAssociatesScreen(
                progress: 0.45,
              );
            case KycPageStep.disclosureAffiliationPersonInput:
              return DisclosureAffiliationPersonInputScreen(
                progress: 0.45,
                disclosureAffiliationState:
                    context.read<DisclosureAffiliationBloc>().state,
              );
            case KycPageStep.financialProfileSummary:
              return FinancialProfileSummaryScreen(
                progress: 0.5,
                disclosureAffiliationState:
                    context.read<DisclosureAffiliationBloc>().state,
                financialProfileState:
                    context.read<FinancialProfileBloc>().state,
                sourceOfWealthState: context.read<SourceOfWealthBloc>().state,
              );
            case KycPageStep.disclosureRejected:
              return KycRejectedScreen(
                rejectedReason: S.of(context).kycRejectedExplanationOfAffiliate,
                onGoBack: () => context
                    .read<DisclosureAffiliationBloc>()
                    .add(ResetAffiliatedAnswer()),
              );
            case KycPageStep.verifyIdentity:
              return const VerifyIdentityScreen(
                progress: 0.75,
              );
            case KycPageStep.signBrokerAgreements:
              return const BrokerAgreementScreen(
                progress: 0.8,
              );
            case KycPageStep.signRiskDisclosureAgreements:
              return const RiskDisclosureAgreementScreen(
                progress: 0.88,
              );
            case KycPageStep.signTaxAgreements:
              return TaxAgreementScreen(
                  progress: 0.96,
                  personalInfoBloc: context.read<PersonalInfoBloc>());
            case KycPageStep.kycSummary:
              return KycSummaryScreen(
                personalInfoState: context.read<PersonalInfoBloc>().state,
                progress: 1,
                addressProofState: context.read<AddressProofBloc>().state,
                disclosureAffiliationState:
                    context.read<DisclosureAffiliationBloc>().state,
                financialProfileState:
                    context.read<FinancialProfileBloc>().state,
                sourceOfWealthState: context.read<SourceOfWealthBloc>().state,
              );
            case KycPageStep.kycResultScreen:
              return const KycResultScreen();
            default:
              return const SizedBox.shrink();
          }
        });
  }

  static void open(BuildContext context) =>
      Navigator.of(context, rootNavigator: true).pushNamed(route);

  static void openAndRemoveAllRoute(BuildContext context) =>
      Navigator.of(context, rootNavigator: true)
          .pushNamedAndRemoveUntil(route, (Route<dynamic> route) => false);
}
