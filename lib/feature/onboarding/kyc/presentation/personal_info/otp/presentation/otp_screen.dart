import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/domain/base_response.dart';
import '../../../../../../../core/presentation/buttons/button_pair.dart';
import '../../../../../../../core/presentation/custom_in_app_notification.dart';
import '../../../../../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../../../../core/presentation/text_fields/master_text_field.dart';
import '../../../../../../../core/styles/asklora_colors.dart';
import '../../../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../../../generated/l10n.dart';
import '../../../../../../auth/utils/auth_utils.dart';
import '../../../../../../tabs/presentation/tab_screen.dart';
import '../../../../bloc/kyc_bloc.dart';
import '../../../../bloc/personal_info/personal_info_bloc.dart';
import '../../../widgets/kyc_base_form.dart';
import '../bloc/otp_bloc.dart';

class OtpScreen extends StatelessWidget {
  final double progress;

  const OtpScreen({required this.progress, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpBloc, OtpState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        CustomLoadingOverlay.of(context).show(state.response.state);
        if (state is OtpValidationSuccess) {
          context
              .read<NavigationBloc<KycPageStep>>()
              .add(const PageChanged(KycPageStep.addressProof));
        } else {
          if (state.response.state == ResponseState.error ||
              state.response.state == ResponseState.success) {
            CustomInAppNotification.show(
                context, state.response.validationCode.getText(context));
          }
        }
      },
      child: KycBaseForm(
        title: 'Set Up Personal Info',
        onTapBack: () =>
            context.read<NavigationBloc<KycPageStep>>().add(const PagePop()),
        content: Column(
          children: [
            Text.rich(
              key: const Key('sub_title'),
              TextSpan(children: [
                TextSpan(
                  text:
                      'We\'ve sent you a code via SMS to verify your phone number ',
                  style: AskLoraTextStyles.body1
                      .copyWith(color: AskLoraColors.charcoal),
                ),
                TextSpan(
                    text: '(${_getPhoneNumber(context)}).',
                    style: AskLoraTextStyles.h6),
                TextSpan(
                    text: ' Please enter the OTP code below.',
                    style: AskLoraTextStyles.body1
                        .copyWith(color: AskLoraColors.charcoal)),
              ]),
            ),
            const SizedBox(
              height: 36,
            ),
            _otpInput(context),
          ],
        ),
        progress: progress,
        bottomButton: _bottomButton(context),
      ),
    );
  }

  Widget _bottomButton(BuildContext context) => BlocBuilder<OtpBloc, OtpState>(
        buildWhen: (previous, current) =>
            previous.resetTime != current.resetTime ||
            previous.response.state != current.response.state,
        builder: (context, state) {
          return ButtonPair(
            disablePrimaryButton: state.disableRequest,
            primaryButtonOnClick: () =>
                context.read<OtpBloc>().add(const OtpRequested()),
            secondaryButtonOnClick: () =>
                TabScreen.openAndRemoveAllRoute(context),
            primaryButtonLabel: state.disableRequest
                ? 'Request another OTP in ${_formatTimeMMSS(state.resetTime)}'
                : 'Resend OTP Code',
            secondaryButtonLabel: S.of(context).saveForLater,
          );
        },
      );

  Widget _otpInput(BuildContext context) {
    return BlocBuilder<OtpBloc, OtpState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return MasterTextField(
              key: const Key('otp_input'),
              initialValue: state.otp,
              labelText: 'OTP',
              textInputType: TextInputType.number,
              hintText: '000000 (6 digit)',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              errorText: state.otpError,
              textInputFormatterList: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6)
              ],
              onChanged: (otp) {
                context.read<OtpBloc>().add(const Reset());
                if (otp.length == 6) {
                  context.read<OtpBloc>().add(OtpSubmitted(otp));
                }
              },
              onFieldSubmitted: (otp) {
                if (otp.length == 6) {
                  context.read<OtpBloc>().add(OtpSubmitted(otp));
                } else {
                  context.read<OtpBloc>().add(const InValidOtpEvent());
                }
              });
        });
  }

  String _getPhoneNumber(BuildContext context) {
    PersonalInfoState state = context.read<PersonalInfoBloc>().state;
    return '+${state.phoneCountryCode} ${state.phoneNumber}';
  }

  String _formatTimeMMSS(int time) =>
      '${(time ~/ 60).toString().padLeft(2, '0')}:${(time % 60).toString().padLeft(2, '0')}';
}
