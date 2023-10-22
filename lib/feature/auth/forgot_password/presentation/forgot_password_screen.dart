import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/token/repository/token_repository.dart';
import '../../../../core/presentation/buttons/primary_button.dart';
import '../../../../core/presentation/custom_header.dart';
import '../../../../core/presentation/custom_scaffold.dart';
import '../../../../core/presentation/custom_stretched_layout.dart';
import '../../../../core/presentation/custom_text_new.dart';
import '../../../../core/styles/asklora_text_styles.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../generated/l10n.dart';
import '../../../backdoor/domain/backdoor_repository.dart';
import '../../repository/auth_repository.dart';
import '../bloc/forgot_password_bloc.dart';
import 'forgot_password_form.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: BlocProvider(
        create: (context) => ForgotPasswordBloc(
            authRepository: AuthRepository(
          TokenRepository(),
          BackdoorRepository(),
        )),
        child: CustomStretchedLayout(
          header: CustomHeader(
            title: S.of(context).forgotPassword,
          ),
          content: const ForgotPasswordForm(),
          bottomButton: _forgotPasswordButton(),
        ),
      ),
    );
  }

  Widget _forgotPasswordButton() =>
      BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return Column(
            children: [
              CustomTextNew(
                S.of(context).cannotRememberEmailAddress,
                textAlign: TextAlign.center,
                style: AskLoraTextStyles.subtitle3,
              ),
              const SizedBox(
                height: 30,
              ),
              PrimaryButton(
                  key: const Key('forgot_password_submit_button'),
                  label: S.of(context).buttonSubmit,
                  disabled: !state.email.isValidEmail(),
                  onTap: () => context
                      .read<ForgotPasswordBloc>()
                      .add(const ForgotPasswordSubmitted())),
              const SizedBox(height: 30)
            ],
          );
        },
      );

  static void open(BuildContext context) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
        ),
      );
}
