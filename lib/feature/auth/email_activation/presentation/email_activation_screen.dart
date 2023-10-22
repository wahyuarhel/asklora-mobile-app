import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/bloc/app_bloc.dart';
import '../../../../core/domain/base_response.dart';
import '../../../../core/domain/token/repository/token_repository.dart';
import '../../../../core/presentation/buttons/button_pair.dart';
import '../../../../core/presentation/custom_in_app_notification.dart';
import '../../../../core/presentation/custom_scaffold.dart';
import '../../../../core/presentation/custom_stretched_layout.dart';
import '../../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../../core/presentation/lora_animation_header.dart';
import '../../../../core/utils/storage/cache/json_cache_shared_preferences.dart';
import '../../../../core/utils/storage/shared_preference.dart';
import '../../../../generated/l10n.dart';
import '../../../onboarding/kyc/repository/account_repository.dart';
import '../../../onboarding/ppi/bloc/response/user_response_bloc.dart';
import '../../../onboarding/ppi/presentation/investment_style_question/isq/presentation/isq_onboarding_screen.dart';
import '../../../onboarding/ppi/repository/ppi_response_repository.dart';
import '../../../onboarding/welcome/ask_name/bloc/lora_ask_name_bloc.dart';
import '../../../onboarding/welcome/ask_name/repository/add_user_name_repository.dart';
import '../../sign_up/repository/sign_up_repository.dart';
import '../../utils/auth_utils.dart';
import '../email_activation_bloc.dart';

class EmailActivationScreen extends StatelessWidget {
  static const route = '/email_activation_screen';
  final EmailActivationScreenArguments arguments;

  const EmailActivationScreen({
    super.key,
    required this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => UserResponseBloc(
                sharedPreference: SharedPreference(),
                ppiResponseRepository: PpiResponseRepository(),
                jsonCacheSharedPreferences: JsonCacheSharedPreferences())),
        BlocProvider(
            create: (_) => LoraAskNameBloc(
                addUserNameRepository: AddUserNameRepository(),
                sharedPreference: SharedPreference())),
        BlocProvider(create: (_) {
          EmailActivationBloc emailActivationBloc = EmailActivationBloc(
              SignUpRepository(),
              TokenRepository(),
              SharedPreference(),
              PpiResponseRepository(),
              AccountRepository())
            ..add(const StartListenOnDeeplink());
          if (arguments.isFromLoginScreen) {
            emailActivationBloc
                .add(ResendEmailActivationLink(arguments.userName));
          }
          return emailActivationBloc;
        }),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<EmailActivationBloc, EmailActivationState>(
            listener: (context, state) {
              CustomLoadingOverlay.of(context).show(state.response.state);
              if (state.deeplinkStatus == DeeplinkStatus.success) {
                context
                    .read<AppBloc>()
                    .add(const SaveUserJourney(UserJourney.investmentStyle));
                IsqOnBoardingScreen.openAndRemoveAllRoute(context);
              }
              switch (state.response.state) {
                case ResponseState.error:
                  CustomInAppNotification.show(
                      context, state.response.validationCode.getText(context));
                case ResponseState.success:
                  CustomInAppNotification.show(
                      context, state.response.validationCode.getText(context));
                  break;
                default:
                  break;
              }
            },
          ),
          BlocListener<LoraAskNameBloc, LoraAskNameState>(
              listenWhen: (previous, current) =>
                  previous.response.state != current.response.state,
              listener: (context, state) {
                CustomLoadingOverlay.of(context).show(state.response.state);
                if (ResponseState.success == state.response.state) {
                  context.read<UserResponseBloc>().add(const ReSendResponse());
                }
              }),
          BlocListener<UserResponseBloc, UserResponseState>(
              listener: (context, state) {
            CustomLoadingOverlay.of(context).show(state.responseState);
            if (state.responseState == ResponseState.success) {
              Navigator.pop(context);
            }
          }),
        ],
        child: BlocBuilder<EmailActivationBloc, EmailActivationState>(
          builder: (context, state) {
            final headerWidget = state.deeplinkStatus == DeeplinkStatus.failed
                ? LoraAnimationHeader(
                    text: S.of(context).emailActivationFailedTitle,
                    loraAnimationType: LoraAnimationType.magenta,
                  )
                : LoraAnimationHeader(
                    text: S
                        .of(context)
                        .emailActivationSuccessTitle(arguments.userName),
                  );

            return WillPopScope(
                onWillPop: () {
                  return Future.value(false);
                },
                child: CustomScaffold(
                  enableBackNavigation: false,
                  body: CustomStretchedLayout(
                    contentPadding: EdgeInsets.zero,
                    content: headerWidget,
                    bottomButton: ButtonPair(
                        primaryButtonOnClick: () => context
                            .read<EmailActivationBloc>()
                            .add(ResendEmailActivationLink(arguments.userName)),
                        secondaryButtonOnClick: () =>
                            arguments.isFromLoginScreen
                                ? Navigator.pop(context)
                                : context
                                    .read<LoraAskNameBloc>()
                                    .add(const ReSubmitUserName()),
                        primaryButtonLabel:
                            S.of(context).buttonResendActivationLink,
                        secondaryButtonLabel: arguments.isFromLoginScreen
                            ? S.of(context).buttonBack
                            : S.of(context).buttonSignUpAgain),
                  ),
                ));
          },
        ),
      ),
    );
  }

  static void open(
      BuildContext context, EmailActivationScreenArguments arguments) {
    Navigator.of(context).pushNamed(route, arguments: arguments);
  }
}

class EmailActivationScreenArguments {
  final String userName;
  final bool isFromLoginScreen;

  const EmailActivationScreenArguments(
      {required this.userName, this.isFromLoginScreen = false});
}
