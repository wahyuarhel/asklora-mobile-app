import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/bloc/app_bloc.dart';
import '../../../../app/repository/user_journey_repository.dart';
import '../../../../core/domain/base_response.dart';
import '../../../../core/domain/pair.dart';
import '../../../../core/domain/token/repository/token_repository.dart';
import '../../../../core/presentation/buttons/primary_button.dart';
import '../../../../core/presentation/custom_header.dart';
import '../../../../core/presentation/custom_in_app_notification.dart';
import '../../../../core/presentation/custom_scaffold.dart';
import '../../../../core/presentation/custom_stretched_layout.dart';
import '../../../../core/presentation/custom_text_new.dart';
import '../../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../../core/presentation/text_fields/master_text_field.dart';
import '../../../../core/styles/asklora_colors.dart';
import '../../../../core/styles/asklora_text_styles.dart';
import '../../../../core/utils/storage/shared_preference.dart';
import '../../../../generated/l10n.dart';
import '../../../backdoor/domain/backdoor_repository.dart';
import '../../../onboarding/kyc/repository/account_repository.dart';
import '../../../onboarding/ppi/repository/ppi_response_repository.dart';
import '../../../tabs/presentation/tab_screen.dart';
import '../../repository/auth_repository.dart';
import '../../sign_in/bloc/sign_in_bloc.dart';
import '../../utils/auth_utils.dart';
import '../bloc/otp_bloc.dart';
import '../repository/otp_repository.dart';

class OtpScreen extends StatelessWidget {
  static const String route = '/otp';

  final String email;
  final String password;

  const OtpScreen({required this.email, required this.password, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OtpBloc(otpRepository: OtpRepository())
            ..add(SmsOtpRequested(email)),
        ),
        BlocProvider(
          create: (context) => SignInBloc(
              authRepository: AuthRepository(
                TokenRepository(),
                BackdoorRepository(),
              ),
              userJourneyRepository: UserJourneyRepository(),
              accountRepository: AccountRepository(),
              sharedPreference: SharedPreference(),
              ppiResponseRepository: PpiResponseRepository()),
        ),
      ],
      child: BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
        return MultiBlocListener(
          listeners: [
            BlocListener<OtpBloc, OtpState>(
                listenWhen: (previous, current) =>
                    previous.response.state != current.response.state,
                listener: ((context, state) => CustomLoadingOverlay.of(context)
                    .show(state.response.state))),
            BlocListener<SignInBloc, SignInState>(
                listenWhen: (previous, current) =>
                    previous.response.state != current.response.state,
                listener: ((context, state) {
                  CustomLoadingOverlay.of(context).show(state.response.state);

                  switch (state.response.state) {
                    case ResponseState.error:
                      CustomInAppNotification.show(context,
                          state.response.validationCode.getText(context));
                      break;
                    case ResponseState.success:
                      context
                          .read<AppBloc>()
                          .add(const GetUserJourneyFromLocal());
                      TabScreen.openAndRemoveAllRoute(context);
                      break;
                    default:
                      break;
                  }
                }))
          ],
          child: CustomStretchedLayout(
            header: CustomHeader(title: S.of(context).otpScreenTitle),
            content: Column(
              children: [
                BlocBuilder<OtpBloc, OtpState>(
                  buildWhen: (previous, current) =>
                      previous.response.state != current.response.state,
                  builder: (context, state) {
                    return CustomTextNew(
                      S.of(context).otpScreenDescription(state.phoneNumber),
                    );
                  },
                ),
                const SizedBox(height: 36),
                _otpInput(context)
              ],
            ),
            bottomButton: _bottomButton(context),
          ),
        );
      }),
    ));
  }

  Widget _otpInput(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<OtpBloc, OtpState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            return MasterTextField(
              key: const Key('otp_box'),
              initialValue: state.otp,
              labelText: 'OTP',
              errorText: state.otpError ? 'The OTP is incorrect' : '',
              textInputType: TextInputType.number,
              hintText: S.of(context).otpDigit,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              textInputFormatterList: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6)
              ],
              onChanged: (otp) {
                context.read<OtpBloc>().add(OtpTyped(otp));
              },
            );
          },
        ),
        Positioned(
          top: 18,
          right: 15,
          child: BlocBuilder<OtpBloc, OtpState>(
            buildWhen: (previous, current) =>
                previous.resetTime != current.resetTime,
            builder: (context, state) {
              return GestureDetector(
                  key: const Key('request_otp_button'),
                  onTap: state.resetTime != 0
                      ? null
                      : () =>
                          context.read<OtpBloc>().add(SmsOtpRequested(email)),
                  child: CustomTextNew(
                    state.resetTime == 0
                        ? S.of(context).sendOtp
                        : S
                            .of(context)
                            .reSendOtp(_formatTimeToSeconds(state.resetTime)),
                    style: AskLoraTextStyles.subtitle3.copyWith(
                        color: state.resetTime != 0
                            ? AskLoraColors.gray
                            : AskLoraColors.charcoal),
                  ));
            },
          ),
        )
      ],
    );
  }

  Widget _bottomButton(BuildContext context) => Column(
        children: [
          BlocBuilder<OtpBloc, OtpState>(
            buildWhen: (previous, current) => previous.otp != current.otp,
            builder: (context, state) {
              return PrimaryButton(
                key: const Key('sign_up_again_button'),
                disabled: state.otp.isEmpty && state.otp.length < 6,
                label: S.of(context).buttonVerify,
                onTap: () => context
                    .read<SignInBloc>()
                    .add(SignInWithOtp(state.otp, email, password)),
              );
            },
          )
        ],
      );

  String _formatTimeToSeconds(int time) => (time).toString().padLeft(2, '0');

  static void openReplace(
          BuildContext context, Pair<String, String> arguments) =>
      Navigator.of(context).pushReplacementNamed(route, arguments: arguments);
}
