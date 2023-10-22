import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/token/repository/token_repository.dart';
import '../../../../core/presentation/custom_header.dart';
import '../../../../core/presentation/custom_scaffold.dart';
import '../../../../core/presentation/custom_status_widget.dart';
import '../../../../core/presentation/custom_stretched_layout.dart';
import '../../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../../generated/l10n.dart';
import '../../../backdoor/domain/backdoor_repository.dart';
import '../../repository/auth_repository.dart';
import '../../reset_password/presentation/reset_password_screen.dart';
import '../bloc/forgot_password_bloc.dart';

class ForgotPasswordSuccessScreen extends StatelessWidget {
  const ForgotPasswordSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) {
          return ForgotPasswordBloc(
              authRepository: AuthRepository(
            TokenRepository(),
            BackdoorRepository(),
          ))
            ..add(const StartListenOnDeeplink());
        },
        child: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            CustomLoadingOverlay.of(context).show(state.response.state);

            if (state.deeplinkStatus == DeeplinkStatus.success) {
              ResetPasswordScreen.open(context,
                  resetPasswordToken: state.resetPasswordToken);
            }
          },
          child: CustomScaffold(
            body: CustomStretchedLayout(
              header: CustomHeader(
                title: S.of(context).forgotPassword,
              ),
              content: Padding(
                padding: const EdgeInsets.only(top: 48),
                child: CustomStatusWidget(
                  title: S.of(context).passwordLinkHasBeenSent,
                  statusType: StatusType.success,
                ),
              ),
            ),
          ),
        ),
      );

  static void open(BuildContext context) =>
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const ForgotPasswordSuccessScreen(
            key: Key('forgot_password_success_screen'),
          ),
        ),
      );
}
