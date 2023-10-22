import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/base_response.dart';
import '../../../../../core/onfido/start_onfido.dart';
import '../../../../../core/presentation/buttons/button_pair.dart';
import '../../../../../core/presentation/custom_in_app_notification.dart';
import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../../core/presentation/round_colored_box.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../../auth/utils/auth_utils.dart';
import '../../bloc/kyc_bloc.dart';
import '../../domain/onfido/onfido_result_request.dart';
import '../../domain/upgrade_account/save_kyc_request.dart';
import '../widgets/custom_stepper/custom_stepper.dart';
import '../widgets/kyc_base_form.dart';

class VerifyIdentityScreen extends StatelessWidget {
  final double progress;

  const VerifyIdentityScreen({required this.progress, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KycBaseForm(
      onTapBack: () =>
          context.read<NavigationBloc<KycPageStep>>().add(const PagePop()),
      title: S.of(context).verifyIdentity,
      content: BlocListener<KycBloc, KycState>(
        listenWhen: (previous, current) =>
            previous.onfidoResponse.state != current.onfidoResponse.state,
        listener: (context, state) async {
          CustomLoadingOverlay.of(context).show(state.onfidoResponse.state);

          if (state.onfidoResponse.state == ResponseState.error) {
            CustomInAppNotification.show(
                context, state.onfidoResponse.validationCode.getText(context));
          }

          if (state is OnfidoSdkToken) {
            await _doVerificationOnfido(
                context: context, onFidoSdkTokenState: state);
          }

          if (state is OnfidoResultUpdated) {
            if (context.mounted) {
              context
                  .read<NavigationBloc<KycPageStep>>()
                  .add(const PageChanged(KycPageStep.signBrokerAgreements));
            }
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextNew(
              S.of(context).weNeedToVerifyYourId,
              key: const Key('sub_title'),
              style: AskLoraTextStyles.body1
                  .copyWith(color: AskLoraColors.charcoal),
            ),
            const SizedBox(
              height: 42,
            ),
            _verificationSteps(context)
          ],
        ),
      ),
      bottomButton: _bottomButton(context),
      progress: progress,
    );
  }

  Future<void> _doVerificationOnfido(
      {required BuildContext context,
      required OnfidoSdkToken onFidoSdkTokenState}) async {
    try {
      await startOnfido(onFidoSdkTokenState.token).then((value) => context
          .read<KycBloc>()
          .add(UpdateOnfidoResult(Reason.userCompleted.value, 'Onfido SDK',
              onFidoSdkTokenState.token)));
    } on PlatformException {
      context.read<KycBloc>().add(UpdateOnfidoResult(
          Reason.userExited.value, 'Onfido SDK', onFidoSdkTokenState.token));
    } catch (e) {
      context.read<KycBloc>().add(UpdateOnfidoResult(
          Reason.sdkError.value, 'Onfido SDK', onFidoSdkTokenState.token));
    }
  }

  Widget _verificationSteps(BuildContext context) => RoundColoredBox(
      key: const Key('verification_steps'),
      title: S.of(context).getReadyForTheVerification,
      content: CustomStepper(
        currentStep: 0,
        steps: [
          S.of(context).takePhotoFront,
          S.of(context).takePhotoBack,
          S.of(context).takeSelfie,
        ],
      ));

  Widget _bottomButton(BuildContext context) => ButtonPair(
        primaryButtonOnClick: () {
          ///TODO OPEN ONFIDO SCREEN LATER
          context.read<KycBloc>().add(GetSdkToken());
        },
        secondaryButtonOnClick: () => context
            .read<KycBloc>()
            .add(SaveKyc(SaveKycRequest.getRequestForSavingKyc(context))),
        primaryButtonLabel: S.of(context).verifyNow,
        secondaryButtonLabel: S.of(context).saveForLater,
      );
}
