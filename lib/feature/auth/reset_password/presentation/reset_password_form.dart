import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/base_response.dart';
import '../../../../core/presentation/custom_in_app_notification.dart';
import '../../../../core/presentation/custom_text_new.dart';
import '../../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../../core/presentation/text_fields/password_text_field.dart';
import '../../../../generated/l10n.dart';
import '../../utils/auth_utils.dart';
import '../bloc/reset_password_bloc.dart';
import 'reset_password_success_screen.dart';

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listenWhen: (previous, current) =>
          previous.response.state != current.response.state,
      listener: (context, state) {
        CustomLoadingOverlay.of(context).show(state.response.state);
        if (state.response.message.isNotEmpty) {
          CustomInAppNotification.show(
              context, state.response.validationCode.getText(context));
        }

        if (state.response.state == ResponseState.success) {
          ResetPasswordSuccessScreen.open(context);
        } else if (state.response.state == ResponseState.error) {
          context
              .read<ResetPasswordBloc>()
              .add(ResetPasswordPasswordChanged(state.password));
          context
              .read<ResetPasswordBloc>()
              .add(ResetPasswordConfirmPasswordChanged(state.confirmPassword));
        }
      },
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextNew(
                  S.of(context).enterANewPassword,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 16),
                ),
                _padding(),
                _passwordInput(),
                _padding(),
                _confirmPasswordInput(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _passwordInput() => BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) => PasswordTextField(
          key: const Key('reset_password_password_input'),
          validPassword: (isValidPassword) => {},
          hintText: S.of(context).newPassword,
          label: S.of(context).newPassword,
          errorText: _getErrorString(context, state.passwordValidationError),
          onChanged: (password) => context
              .read<ResetPasswordBloc>()
              .add(ResetPasswordPasswordChanged(password))));

  Widget _confirmPasswordInput() =>
      BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
          buildWhen: (previous, current) =>
              previous.password != current.password ||
              previous.confirmPassword != current.confirmPassword,
          builder: (context, state) {
            return PasswordTextField(
                key: const Key('reset_password_confirm_password_input'),
                isShowingPasswordValidation: false,
                validPassword: (isValidPassword) => {},
                hintText: S.of(context).newPassword,
                label: S.of(context).confirmNewPassword,
                errorText: _getErrorString(context, state.confirmPasswordError),
                onChanged: (confirmPassword) => context
                    .read<ResetPasswordBloc>()
                    .add(ResetPasswordConfirmPasswordChanged(confirmPassword)));
          });

  Padding _padding() => const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
      );

  String _getErrorString(
      BuildContext context, PasswordValidationError passwordValidationError) {
    switch (passwordValidationError) {
      case PasswordValidationError.passwordValidationError:
        return S.of(context).enterValidPassword;
      case PasswordValidationError.passwordDoesNotMatchError:
        return S.of(context).passwordDoesNotMatch;
      default:
        return '';
    }
  }
}
