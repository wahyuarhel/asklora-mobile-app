part of '../../deposit_screen.dart';

class UploadProofOfRemittanceStep extends StatelessWidget {
  const UploadProofOfRemittanceStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<DepositBloc, DepositState>(
      listenWhen: (previous, current) =>
          previous.proofOfRemittanceImagesErrorText !=
          current.proofOfRemittanceImagesErrorText,
      listener: (context, state) {
        if (state.proofOfRemittanceImagesErrorText.isNotEmpty) {
          CustomInAppNotification.show(
              context, state.proofOfRemittanceImagesErrorText);
        }
      },
      child: DepositBaseStep(
        drawLine: false,
        contents: [
          CustomTextNew(
            S.of(context).uploadProofOfRemittance,
            style: AskLoraTextStyles.h6.copyWith(color: AskLoraColors.charcoal),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextNew(
            S.of(context).thePorShouldShowYourBank,
            style:
                AskLoraTextStyles.body2.copyWith(color: AskLoraColors.charcoal),
          ),
          const SizedBox(
            height: 18,
          ),
          BlocBuilder<DepositBloc, DepositState>(
            buildWhen: (previous, current) =>
                previous.proofOfRemittanceImages !=
                current.proofOfRemittanceImages,
            builder: (context, state) => CustomImagePicker(
              disabledPick: state.proofOfRemittanceImages.length >=
                  maximumProofOfRemittanceImagesAllowed,
              initialValue: state.proofOfRemittanceImages,
              key: const Key('upload_proof_of_remittance'),
              onImageDeleted: (image) => context
                  .read<DepositBloc>()
                  .add(ProofOfRemittanceImageDeleted(image)),
              onImagePicked: (images) => context
                  .read<DepositBloc>()
                  .add(ProofOfRemittanceImagesChanged(images)),
              allowMultiple: false,
            ),
          ),
        ],
      ),
    );
  }
}
