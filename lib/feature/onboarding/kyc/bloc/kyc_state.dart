part of 'kyc_bloc.dart';

enum KycStatus {
  success,
  failure,
  unknown,
  fetchingAccount,
  submittingKyc,
  fetchingOnfidoToken,
  submittingOnfidoResult,
  submittingTaxInfo
}

enum KycPageStep {
  progress,
  residentCheck,
  personalInfoRejected,
  personalInfo,
  otp,
  addressProof,
  personalInfoSummary,
  disclosureAffiliationPerson,
  disclosureAffiliationPersonInput,
  disclosureAffiliationAssociates,
  disclosureAffiliationAssociatesInput,
  disclosureAffiliationCommissions,
  disclosureRejected,
  financialProfileSummary,
  financialProfileEmployment,
  financialProfileSourceOfWealth,
  verifyIdentity,
  signBrokerAgreements,
  signRiskDisclosureAgreements,
  signTaxAgreements,
  kycSummary,
  kycResultScreen
}

class KycState extends Equatable {
  const KycState({
    this.submitKycResponse = const BaseResponse(),
    this.saveKycResponse = const BaseResponse(),
    this.fetchKycResponse = const BaseResponse(),
    this.onfidoResponse = const BaseResponse(),
  });

  final BaseResponse submitKycResponse;
  final BaseResponse saveKycResponse;
  final BaseResponse onfidoResponse;
  final BaseResponse<SaveKycRequest> fetchKycResponse;

  @override
  List<Object?> get props {
    return [
      submitKycResponse,
      saveKycResponse,
      fetchKycResponse,
      onfidoResponse
    ];
  }

  KycState copyWith({
    BaseResponse? submitKycResponse,
    BaseResponse? saveKycResponse,
    BaseResponse? onfidoResponse,
    BaseResponse<SaveKycRequest>? fetchKycResponse,
  }) {
    return KycState(
      submitKycResponse: submitKycResponse ?? this.submitKycResponse,
      saveKycResponse: saveKycResponse ?? this.saveKycResponse,
      fetchKycResponse: fetchKycResponse ?? this.fetchKycResponse,
      onfidoResponse: onfidoResponse ?? this.onfidoResponse,
    );
  }
}

class OnfidoSdkToken extends KycState {
  final String token;

  const OnfidoSdkToken(this.token);
}

class OnfidoResultUpdated extends KycState {
  final OnfidoResultResponse onfidoResultResponse;

  const OnfidoResultUpdated(this.onfidoResultResponse);
}
