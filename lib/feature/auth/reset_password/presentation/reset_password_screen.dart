import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/token/repository/token_repository.dart';
import '../../../../core/presentation/buttons/primary_button.dart';
import '../../../../core/presentation/custom_header.dart';
import '../../../../core/presentation/custom_scaffold.dart';
import '../../../../core/presentation/custom_stretched_layout.dart';
import '../../../../generated/l10n.dart';
import '../../../backdoor/domain/backdoor_repository.dart';
import '../../repository/auth_repository.dart';
import '../bloc/reset_password_bloc.dart';
import 'reset_password_form.dart';

class ResetPasswordScreen extends StatelessWidget {
  static const String route = '/reset_password_screen';

  const ResetPasswordScreen({required this.resetPasswordToken, Key? key})
      : super(key: key);

  final String resetPasswordToken;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordBloc(
          authRepository: AuthRepository(
        TokenRepository(),
        BackdoorRepository(),
      )),
      child: CustomScaffold(
        body: CustomStretchedLayout(
          header: CustomHeader(
            title: S.of(context).resetPassword,
          ),
          content: const ResetPasswordForm(),
          bottomButton: Column(
            children: [
              _resetPasswordButton(),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _resetPasswordButton() =>
      BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
        buildWhen: (previous, current) =>
            previous.confirmPasswordError != current.confirmPasswordError,
        builder: (context, state) {
          return PrimaryButton(
              key: const Key('reset_password_submit_button'),
              label: S.of(context).resetPassword,
              disabled: state.disableSubmitButton(),
              onTap: () => context
                  .read<ResetPasswordBloc>()
                  .add(ResetPasswordSubmitted(resetPasswordToken)));
        },
      );

  static void open(BuildContext context,
          {required String resetPasswordToken}) =>
      Navigator.pushNamed(context, route, arguments: resetPasswordToken);
}
