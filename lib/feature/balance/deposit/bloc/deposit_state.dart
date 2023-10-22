part of 'deposit_bloc.dart';

class DepositState extends Equatable {
  final BaseResponse<DepositResponse> response;
  final double depositAmount;
  final String depositAmountErrorText;
  final List<PlatformFile> proofOfRemittanceImages;
  final String proofOfRemittanceImagesErrorText;

  const DepositState({
    this.response = const BaseResponse(),
    this.depositAmount = 0,
    this.proofOfRemittanceImages = const [],
    this.depositAmountErrorText = '',
    this.proofOfRemittanceImagesErrorText = '',
  }) : super();

  @override
  List<Object?> get props => [
        depositAmount,
        proofOfRemittanceImages,
        depositAmountErrorText,
        proofOfRemittanceImagesErrorText,
        response
      ];

  DepositState copyWith({
    double? depositAmount,
    List<PlatformFile>? proofOfRemittanceImages,
    BaseResponse<DepositResponse>? response,
    String? depositAmountErrorText,
    String? proofOfRemittanceImagesErrorText,
  }) {
    return DepositState(
      response: response ?? this.response,
      depositAmount: depositAmount ?? this.depositAmount,
      depositAmountErrorText:
          depositAmountErrorText ?? this.depositAmountErrorText,
      proofOfRemittanceImagesErrorText: proofOfRemittanceImagesErrorText ??
          this.proofOfRemittanceImagesErrorText,
      proofOfRemittanceImages:
          proofOfRemittanceImages ?? this.proofOfRemittanceImages,
    );
  }

  bool disableDeposit(DepositType depositType) {
    if (depositType == DepositType.type2) {
      return depositAmount == 0 || depositAmountErrorText.isNotEmpty;
    } else {
      return (depositAmount == 0 ||
          proofOfRemittanceImages.isEmpty ||
          depositAmountErrorText.isNotEmpty ||
          depositAmount < depositType.minDeposit);
    }
  }
}
