import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/bloc/app_bloc.dart';
import '../../../../core/domain/base_response.dart';
import '../../../../core/domain/pair.dart';
import '../../../../core/domain/validation_enum.dart';
import '../../../../core/presentation/buttons/primary_button.dart';
import '../../../../core/presentation/custom_in_app_notification.dart';
import '../../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../../core/presentation/lora_animation_header.dart';
import '../../../../core/presentation/text_fields/master_text_field.dart';
import '../../../../core/presentation/text_fields/password_text_field.dart';
import '../../../../core/presentation/we_create/custom_text_button.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../generated/l10n.dart';
import '../../../onboarding/kyc/presentation/kyc_screen.dart';
import '../../../onboarding/ppi/presentation/investment_style_question/isq/presentation/isq_onboarding_screen.dart';
import '../../../onboarding/welcome/ask_name/presentation/ask_name_screen.dart';
import '../../../tabs/presentation/tab_screen.dart';
import '../../email_activation/presentation/email_activation_screen.dart';
import '../../forgot_password/presentation/forgot_password_screen.dart';
import '../../otp/presentation/otp_screen.dart';
import '../../utils/auth_utils.dart';
import '../bloc/sign_in_bloc.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
        listener: (context, state) async {
      CustomLoadingOverlay.of(context).show(state.response.state);
      var responseState = state.response.state;
      if (responseState == ResponseState.error) {
        if (state.response.validationCode == ValidationCode.unverifiedEmail) {
          EmailActivationScreen.open(
            context,
            EmailActivationScreenArguments(
                userName: state.emailAddress, isFromLoginScreen: true),
          );
        } else {
          context
              .read<SignInBloc>()
              .add(SignInEmailChanged(state.emailAddress));
          CustomInAppNotification.show(
              context, state.response.validationCode.getText(context));
        }
      } else if (responseState == ResponseState.success) {
        context.read<AppBloc>().add(const GetUserJourneyFromLocal());
        var arguments = Pair(state.emailAddress, state.password);
        if (state.isOtpRequired) {
          OtpScreen.openReplace(context, arguments);
        } else {
          switch (state.response.data!.userJourney) {
            case UserJourney.kyc:
              KycScreen.openAndRemoveAllRoute(context);
              break;
            case UserJourney.investmentStyle:
              IsqOnBoardingScreen.openAndRemoveAllRoute(context);
              break;
            default:
              TabScreen.openAndRemoveAllRoute(context);
              break;
          }
        }
      }
    }, child: LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: [
                        LoraAnimationHeader(
                            text: 'Welcome back!\n${S.of(context).readyToGo}'),
                        context.padding(),
                        _emailInput(),
                        context.padding(topPadding: 10),
                        _passwordInput(),
                        context.padding(topPadding: 10),
                        _forgotPasswordButton(context),
                        context.padding(topPadding: 10),
                      ],
                    ),
                    Column(
                      children: [
                        _loginButton(),
                        _createAnAccountButton(context),
                        context.padding(topPadding: 20),
                      ],
                    ),
                  ])));
    }));
  }

  Widget _emailInput() => BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) =>
          previous.emailAddress != current.emailAddress,
      builder: (context, state) => MasterTextField(
          key: const Key('sign_in_email_input'),
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.emailAddress,
          maxLine: 1,
          labelText: S.of(context).emailAddress,
          hintText: S.of(context).emailAddress,
          errorText: state.emailAddressValidation.getText(context),
          onChanged: (email) =>
              context.read<SignInBloc>().add(SignInEmailChanged(email))));

  Widget _passwordInput() => BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) => PasswordTextField(
          isShowingPasswordValidation: false,
          key: const Key('sign_in_password_input'),
          validPassword: (isValidPassword) => {},
          hintText: S.of(context).password,
          label: S.of(context).password,
          onChanged: (password) =>
              context.read<SignInBloc>().add(SignInPasswordChanged(password))));

  Widget _forgotPasswordButton(context) => CustomTextButton(
      key: const Key('forgot_password_button'),
      label: S.of(context).buttonForgetPassword,
      onTap: () => ForgotPasswordScreen.open(context));

  Widget _loginButton() => BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          return PrimaryButton(
              key: const Key('sign_in_submit_button'),
              label: S.of(context).signIn,
              disabled: (!state.emailAddress.isValidEmail() ||
                  state.password.isEmpty),
              onTap: () =>
                  context.read<SignInBloc>().add(const SignInSubmitted()));
        },
      );

  Widget _createAnAccountButton(BuildContext context) {
    return CustomTextButton(
      margin: const EdgeInsets.only(top: 20),
      label: S.of(context).createAnAccount,
      onTap: () => AskNameScreen.open(context),
    );
  }
}
