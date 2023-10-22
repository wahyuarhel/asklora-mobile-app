part of 'signing_agreement_bloc.dart';

class SigningAgreementState extends Equatable {
  final bool isAskLoraClientAgreementOpened;
  final bool isBoundByAskloraAgreementChecked;
  final bool isUnderstandOnTheAgreementChecked;
  final bool isRiskDisclosureAgreementChecked;
  final bool isSignatureChecked;
  final String legalName;
  final String? signedTime;
  final String legalNameErrorText;
  final bool isInputNameValid;

  const SigningAgreementState({
    this.isAskLoraClientAgreementOpened = false,
    this.isBoundByAskloraAgreementChecked = false,
    this.isUnderstandOnTheAgreementChecked = false,
    this.isRiskDisclosureAgreementChecked = false,
    this.isSignatureChecked = false,
    this.legalName = '',
    this.signedTime,
    this.legalNameErrorText = '',
    this.isInputNameValid = false,
  });

  @override
  List<Object?> get props => [
        isAskLoraClientAgreementOpened,
        isRiskDisclosureAgreementChecked,
        isBoundByAskloraAgreementChecked,
        isUnderstandOnTheAgreementChecked,
        isSignatureChecked,
        legalName,
        signedTime ?? '',
        legalNameErrorText,
        isInputNameValid,
      ];

  SigningAgreementState copyWith({
    bool? isAskLoraClientAgreementOpened,
    bool? isBoundByAskloraAgreementChecked,
    bool? isUnderstandOnTheAgreementChecked,
    bool? isRiskDisclosureAgreementChecked,
    bool? isSignatureChecked,
    String? legalName,
    String? signedTime,
    String? legalNameErrorText,
    bool? isInputNameValid,
  }) {
    return SigningAgreementState(
      isAskLoraClientAgreementOpened:
          isAskLoraClientAgreementOpened ?? this.isAskLoraClientAgreementOpened,
      isBoundByAskloraAgreementChecked: isBoundByAskloraAgreementChecked ??
          this.isBoundByAskloraAgreementChecked,
      isUnderstandOnTheAgreementChecked: isUnderstandOnTheAgreementChecked ??
          this.isUnderstandOnTheAgreementChecked,
      isRiskDisclosureAgreementChecked: isRiskDisclosureAgreementChecked ??
          this.isRiskDisclosureAgreementChecked,
      isSignatureChecked: isSignatureChecked ?? this.isSignatureChecked,
      legalName: legalName ?? this.legalName,
      signedTime: signedTime ?? this.signedTime,
      legalNameErrorText: legalNameErrorText ?? this.legalNameErrorText,
      isInputNameValid: isInputNameValid ?? this.isInputNameValid,
    );
  }

  bool disabledBrokerButton() {
    if (isBoundByAskloraAgreementChecked && isUnderstandOnTheAgreementChecked) {
      return false;
    }
    return true;
  }

  bool disableAgreeButton() {
    if (isSignatureChecked && isInputNameValid) {
      return false;
    } else {
      return true;
    }
  }
}
