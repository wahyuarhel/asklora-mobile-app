import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/domain/base_response.dart';
import '../../../core/domain/token/repository/token_repository.dart';
import '../../../core/presentation/buttons/primary_button.dart';
import '../../../core/presentation/custom_header.dart';
import '../../../core/presentation/custom_in_app_notification.dart';
import '../../../core/presentation/custom_scaffold.dart';
import '../../../core/presentation/custom_stretched_layout.dart';
import '../../../core/presentation/custom_text_new.dart';
import '../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../core/presentation/lora_bottom_sheet.dart';
import '../../../core/styles/asklora_colors.dart';
import '../../../core/styles/asklora_text_styles.dart';
import '../../../core/utils/feature_flags.dart';
import '../../../core/utils/storage/profile_data.dart';
import '../../../core/utils/storage/secure_storage.dart';
import '../../../core/utils/storage/shared_preference.dart';
import '../../../generated/l10n.dart';
import '../../auth/repository/auth_repository.dart';
import '../../auth/sign_out/bloc/sign_out_bloc.dart';
import '../../backdoor/domain/backdoor_repository.dart';
import '../../onboarding/welcome/welcome_screen.dart';
import '../../transaction_history/presentation/transaction_history_screen.dart';
import 'account_setting_screen.dart';
import 'about_asklora_screen.dart';

class SettingsScreen extends StatelessWidget {
  static const String route = '/settings_screen';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      onTapBack: () => Navigator.pop(context),
      body: BlocProvider(
        create: (_) => SignOutBloc(
            tokenRepository: TokenRepository(),
            authRepository: AuthRepository(
              TokenRepository(),
              BackdoorRepository(),
            ),
            secureStorage: SecureStorage(),
            sharedPreference: SharedPreference()),
        child: CustomStretchedLayout(
          header: CustomHeader(
            title: S.of(context).generalSettings,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<ProfileDataModel>(
                future: ProfileData().getProfileData(),
                builder: (BuildContext context,
                    AsyncSnapshot<ProfileDataModel> snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: AskLoraColors.gray,
                              shape: BoxShape.circle),
                          padding: const EdgeInsets.fromLTRB(20, 18, 18, 20),
                          child: CustomTextNew(
                            snapshot.data?.name[0].toUpperCase() ?? '',
                            style: AskLoraTextStyles.h2,
                          ),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextNew(
                              snapshot.data?.name ?? '',
                              style: AskLoraTextStyles.h5
                                  .copyWith(color: AskLoraColors.charcoal),
                            ),
                            CustomTextNew(
                              snapshot.data?.email ?? '',
                              style: AskLoraTextStyles.body1
                                  .copyWith(color: AskLoraColors.charcoal),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const SizedBox(
                height: 40,
              ),
              if (!FeatureFlags.isMockApp)
                _settingsMenu(
                    title: S.of(context).subscription,
                    subTitle:
                        '${S.of(context).corePlan} - ${S.of(context).freeTrial}',
                    onTap: () {}),
              _settingsMenu(
                  title: S.of(context).accountSettings,
                  onTap: () => AccountSettingScreen.open(context)),
              _settingsMenu(
                  title: S.of(context).transactionHistory,
                  onTap: () => TransactionHistoryScreen.open(context)),
              _settingsMenu(
                  title: S.of(context).aboutAsklora,
                  onTap: () => AboutAskloraScreen.open(context)),
              if (!FeatureFlags.isMockApp)
                Column(
                  children: [_signOutButton(context), _getAppVersion()],
                ),
            ],
          ),
          bottomButton: _signOutButtonGhostCharcoal,
        ),
      ),
    );
  }

  Widget _settingsMenu(
          {required String title,
          String? subTitle,
          required VoidCallback onTap}) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 23.5),
          width: double.infinity,
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: AskLoraColors.gray, width: 0.5))),
          child: Row(
            children: [
              Expanded(
                  child: CustomTextNew(
                title,
                style: AskLoraTextStyles.subtitle2
                    .copyWith(color: AskLoraColors.charcoal),
              )),
              if (subTitle != null)
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: CustomTextNew(
                    subTitle,
                    style: AskLoraTextStyles.body3
                        .copyWith(color: AskLoraColors.darkGray),
                  ),
                ),
              const SizedBox(
                width: 12,
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AskLoraColors.black,
                size: 14,
              )
            ],
          ),
        ),
      );

  Widget get _signOutButtonGhostCharcoal => Builder(builder: (context) {
        return BlocListener<SignOutBloc, SignOutState>(
          listener: (context, state) {
            CustomLoadingOverlay.of(context).show(state.response.state);
            if (state.response.state == ResponseState.error) {
              CustomInAppNotification.show(context, state.response.message);
            } else if (state.response.state == ResponseState.success) {
              WelcomeScreen.openAndRemoveAllRoute(context);
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: PrimaryButton(
                buttonPrimaryType: ButtonPrimaryType.ghostCharcoal,
                label: S.of(context).buttonSignOut,
                onTap: () => LoraBottomSheet.show(
                      context: context,
                      title: S.of(context).signOutConfirmation,
                      primaryButtonLabel: S.of(context).buttonSignOut,
                      secondaryButtonLabel: S.of(context).buttonCancel,
                      onPrimaryButtonTap: () {
                        Navigator.pop(context);
                        context
                            .read<SignOutBloc>()
                            .add(const SignOutSubmitted());
                      },
                      onSecondaryButtonTap: () => Navigator.pop(context),
                    )),
          ),
        );
      });

  Widget _signOutButton(BuildContext context) => Builder(
        builder: (context) => BlocListener<SignOutBloc, SignOutState>(
          listener: (context, state) async {
            CustomLoadingOverlay.of(context).show(state.response.state);
            if (state.response.state == ResponseState.error) {
              CustomInAppNotification.show(context, state.response.message);
            } else if (state.response.state == ResponseState.success) {
              WelcomeScreen.openAndRemoveAllRoute(context);
            }
          },
          child: GestureDetector(
            onTap: () => LoraBottomSheet.show(
              context: context,
              title: S.of(context).signOutConfirmation,
              primaryButtonLabel: S.of(context).buttonSignOut,
              secondaryButtonLabel: S.of(context).buttonCancel,
              onPrimaryButtonTap: () {
                Navigator.pop(context);
                context.read<SignOutBloc>().add(const SignOutSubmitted());
              },
              onSecondaryButtonTap: () => Navigator.pop(context),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 39),
              decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(color: AskLoraColors.gray, width: 0.5))),
              child: UnconstrainedBox(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 3),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: AskLoraColors.charcoal, width: 0.5))),
                  child: CustomTextNew(
                    S.of(context).buttonSignOut,
                    style: AskLoraTextStyles.subtitle2
                        .copyWith(color: AskLoraColors.charcoal),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget _getAppVersion() => FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 23.5),
                  child: CustomTextNew(
                    '${S.of(context).version}: ${snapshot.data!.version} ${snapshot.data!.buildNumber}',
                    style: AskLoraTextStyles.body1,
                  ),
                ),
              );
            default:
              return const SizedBox();
          }
        },
      );

  static void open(BuildContext context) =>
      Navigator.of(context, rootNavigator: true).pushNamed(route);
}
