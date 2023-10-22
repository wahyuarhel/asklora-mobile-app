import 'package:flutter/material.dart';

import '../../../../core/presentation/buttons/primary_button.dart';
import '../../../../core/presentation/custom_scaffold.dart';
import '../../../../core/presentation/custom_status_widget.dart';
import '../../../../core/presentation/custom_stretched_layout.dart';
import '../../../../generated/l10n.dart';
import '../../sign_in/presentation/sign_in_screen.dart';

class ResetPasswordSuccessScreen extends StatelessWidget {
  const ResetPasswordSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: CustomScaffold(
          enableBackNavigation: false,
          body: CustomStretchedLayout(
            content: CustomStatusWidget(
              title: S.of(context).resetPasswordSuccessful,
              subTitle: S.of(context).resetPasswordSuccessfulMessage,
              statusType: StatusType.success,
            ),
            bottomButton: _backToLoginButton(context),
          ),
        ),
      );

  Widget _backToLoginButton(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: PrimaryButton(
            key: const Key('back_to_login_button'),
            label: S.of(context).backToLogin,
            disabled: false,
            onTap: () => SignInScreen.open(context)),
      );

  static void open(BuildContext context) =>
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const ResetPasswordSuccessScreen(
          key: Key('reset_password_success_screen'),
        ),
      ));
}
