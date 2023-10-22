import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/base_response.dart';
import '../../../../core/presentation/buttons/primary_button.dart';
import '../../../../core/presentation/custom_in_app_notification.dart';
import '../../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../../core/presentation/lora_animation_header.dart';
import '../../../../core/presentation/text_fields/master_text_field.dart';
import '../../../../core/presentation/text_fields/password_text_field.dart';
import '../../../../core/presentation/we_create/custom_text_button.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/sign_in/presentation/sign_in_screen.dart';
import '../../../onboarding/welcome/welcome_screen.dart';
import '../../email_activation/presentation/email_activation_screen.dart';
import '../../utils/auth_utils.dart';
import '../bloc/sign_up_bloc.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(listenWhen: (old, current) {
      return old.response.state != current.response.state;
    }, listener: (context, state) {
      CustomLoadingOverlay.of(context).show(state.response.state);
      switch (state.response.state) {
        case ResponseState.error:
          context.read<SignUpBloc>().add(SignUpUsernameChanged(state.username));
          CustomInAppNotification.show(
              context, state.response.validationCode.getText(context));
          break;
        case ResponseState.success:
          EmailActivationScreen.open(context,
              EmailActivationScreenArguments(userName: state.username));
          break;
        default:
          break;
      }
    }, child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: [
                    LoraAnimationHeader(text: S.of(context).signUpTitle),
                    _userNameInput(),
                    _padding(),
                    _passwordInput(),
                    _padding(),
                  ],
                ),
                Column(
                  children: [
                    _signUpButton(),
                    _padding(),
                    _signInButton(context),
                    _maybeLaterButton(context),
                    _padding(padding: 28)
                  ],
                )
              ],
            ),
          ),
        );
      },
    ));
  }

  Widget _userNameInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: BlocBuilder<SignUpBloc, SignUpState>(
          buildWhen: (previous, current) =>
              previous.username != current.username,
          builder: (context, state) {
            return MasterTextField(
                key: const Key('sign_up_email_input'),
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.emailAddress,
                maxLine: 1,
                labelText: S.of(context).email,
                hintText: S.of(context).emailAddress,
                errorText: state.userNameValidation.getText(context),
                onChanged: (email) => context
                    .read<SignUpBloc>()
                    .add(SignUpUsernameChanged(email)));
          }),
    );
  }

  Widget _passwordInput() {
    return BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return PasswordTextField(
              key: const Key('sign_up_password_input'),
              validPassword: (isValidPassword) => {},
              hintText: S.of(context).password,
              label: S.of(context).password,
              onChanged: (password) => context
                  .read<SignUpBloc>()
                  .add(SignUpPasswordChanged(password)));
        });
  }

  Widget _signUpButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return PrimaryButton(
        key: const Key('sign_up_submit_button'),
        fontStyle: FontStyle.normal,
        label: S.of(context).buttonSignUp,
        disabled: !(state.isEmailValid && state.isPasswordValid),
        onTap: () => context.read<SignUpBloc>().add(const SignUpSubmitted()),
      );
    });
  }

  Widget _signInButton(BuildContext context) {
    return PrimaryButton(
      buttonPrimaryType: ButtonPrimaryType.ghostCharcoal,
      key: const Key('sign_up_have_an_account_button'),
      fontStyle: FontStyle.normal,
      label: S.of(context).buttonAlreadyHaveAnAccount,
      onTap: () => SignInScreen.open(context),
    );
  }

  Widget _maybeLaterButton(BuildContext context) {
    return CustomTextButton(
      key: const Key('sign_up_may_be_later_button'),
      margin: const EdgeInsets.only(top: 20),
      label: S.of(context).buttonMaybeLater,
      onTap: () => WelcomeScreen.openAndRemoveAllRoute(context),
    );
  }

  Padding _padding({double padding = 20}) => Padding(
        padding: EdgeInsets.only(top: padding),
      );
}
