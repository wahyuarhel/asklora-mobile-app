import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/domain/endpoints.dart';
import '../../../core/presentation/buttons/primary_button.dart';
import '../../../core/presentation/custom_expanded_row.dart';
import '../../../core/presentation/custom_header.dart';
import '../../../core/presentation/custom_scaffold.dart';
import '../../../core/presentation/custom_stretched_layout.dart';
import '../../../core/presentation/custom_text_new.dart';
import '../../../core/styles/asklora_colors.dart';
import '../../../core/styles/asklora_text_styles.dart';
import '../../../core/utils/app_icons.dart';
import '../../../core/utils/feature_flags.dart';
import '../../../core/utils/utils.dart';
import '../../../generated/l10n.dart';
import '../widget/menu_button.dart';
import 'customer_service_screen.dart';

class AboutAskloraScreen extends StatelessWidget {
  static const route = '/about_asklora_screen';

  const AboutAskloraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: CustomStretchedLayout(
        contentPadding: const EdgeInsets.only(top: 0, bottom: 43),
        header: CustomHeader(title: S.of(context).aboutAsklora),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
                child: getPngImage('splash_screen', width: 210, height: 100)),
            _getAppVersion(),
            const SizedBox(height: 48),
            GestureDetector(
                onTap: () =>
                    openUrl(askloraSite, mode: LaunchMode.externalApplication),
                child: CustomExpandedRow(S.of(context).website,
                    leftTextStyle: AskLoraTextStyles.subtitle2,
                    flex2: 2,
                    text: askloraSite,
                    textValueAlign: TextAlign.left,
                    rightTextStyle: AskLoraTextStyles.body1.copyWith(
                      color: AskLoraColors.primaryMagenta,
                    ))),
            _spaceHeight(),
            GestureDetector(
                onTap: () => openUrl(mailToHelpAsklora,
                    mode: LaunchMode.externalApplication),
                child: CustomExpandedRow(S.of(context).email,
                    leftTextStyle: AskLoraTextStyles.subtitle2,
                    flex2: 2,
                    text: helpAskloraEmail,
                    textValueAlign: TextAlign.left,
                    rightTextStyle: AskLoraTextStyles.body1.copyWith(
                      color: AskLoraColors.primaryMagenta,
                    ))),
            if (FeatureFlags.isMockApp)
              Column(
                children: [
                  _spaceHeight(),
                  CustomExpandedRow(S.of(context).officeHoursLabel,
                      leftTextStyle: AskLoraTextStyles.subtitle2,
                      flex2: 2,
                      text: S.of(context).officeHours,
                      textValueAlign: TextAlign.left,
                      rightTextStyle: AskLoraTextStyles.body1.copyWith(
                        color: AskLoraColors.black,
                      )),
                ],
              ),
            const SizedBox(height: 12),
            const Divider(thickness: 1, height: 0),
            MenuButtonWidget(
                onTap: () => openUrl(askloraPrivacyPolicy,
                    mode: LaunchMode.externalApplication),
                title: S.of(context).privacyPolicy,
                showBottomBorder: true),
            MenuButtonWidget(
                onTap: () => openUrl(askloraTermAndConditions,
                    mode: LaunchMode.externalApplication),
                title: S.of(context).termsAndConditions,
                showBottomBorder: true),
          ],
        ),
      ),
    );
  }

  Widget _getAppVersion() => FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: CustomTextNew(
                  'Asklora Version ${snapshot.data!.version} (${snapshot.data!.buildNumber})',
                  style: AskLoraTextStyles.body1,
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );

  Widget get _contactUsButton => Builder(builder: (context) {
        return PrimaryButton(
            label: S.of(context).contactUs.toUpperCase(),
            onTap: () => CustomerServiceScreen.open(context));
      });

  Widget _spaceHeight() => const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Divider(thickness: 1, height: 0));

  static void open(BuildContext context) => Navigator.pushNamed(context, route);
}
