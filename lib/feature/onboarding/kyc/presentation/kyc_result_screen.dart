import 'package:flutter/material.dart';

import '../../../../core/presentation/buttons/button_pair.dart';
import '../../../../core/presentation/custom_scaffold.dart';
import '../../../../core/presentation/custom_status_widget.dart';
import '../../../../core/presentation/custom_stretched_layout.dart';
import '../../../../core/utils/feature_flags.dart';
import '../../../../generated/l10n.dart';
import '../../../balance/deposit/presentation/deposit_screen.dart';
import '../../../balance/deposit/utils/deposit_utils.dart';
import '../../../bot_stock/presentation/gift/bot_stock_welcome_screen.dart';
import '../../../tabs/presentation/tab_screen.dart';

class KycResultScreen extends StatelessWidget {
  const KycResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      enableBackNavigation: false,
      body: CustomStretchedLayout(
        content: CustomStatusWidget(
          key: const Key('custom_status_widget'),
          title: S.of(context).kycResultScreenTitle,
          statusType: StatusType.success,
          subTitle: S.of(context).kycResultScreenDesc,
        ),
        bottomButton: _bottomButton(context),
      ),
    );
  }

  Widget _bottomButton(BuildContext context) => ButtonPair(
        primaryButtonOnClick: () => FeatureFlags.byPassFreeBots
            ? DepositScreen.open(
                context: context, depositType: DepositType.firstTime)
            : BotStockWelcomeScreen.open(context),
        secondaryButtonOnClick: () => TabScreen.openAndRemoveAllRoute(context),
        primaryButtonLabel: FeatureFlags.byPassFreeBots
            ? S.of(context).depositFund
            : 'Get Free HKD500 Gift Botstock',
        secondaryButtonLabel: S.of(context).buttonMaybeLater,
      );
}
