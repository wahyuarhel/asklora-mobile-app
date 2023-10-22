import 'package:flutter/material.dart';
import '../../../../../core/presentation/buttons/button_pair.dart';
import '../../../../../core/presentation/custom_scaffold.dart';
import '../../../../../generated/l10n.dart';
import '../../../../tabs/presentation/tab_screen.dart';
import '../../../../tabs/utils/tab_util.dart';
import '../../../kyc/presentation/kyc_screen.dart';
import '../ppi_result_screen.dart';

class InvestmentStyleResultScreen extends StatelessWidget {
  static const String route = 'investment_style_result_screen';

  const InvestmentStyleResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: CustomScaffold(
          enableBackNavigation: false,
          body: PpiResultScreen(
            ppiResult: PpiResult.success,
            title: S.of(context).investmentResultScreenTitle,
            additionalMessage: S.of(context).investmentResultScreenDescription,
            bottomPadding: 0,
            bottomButton: ButtonPair(
              primaryButtonOnClick: () => KycScreen.open(context),
              secondaryButtonOnClick: () => TabScreen.openAndRemoveAllRoute(
                  context,
                  initialTabPage: TabPage.forYou),
              primaryButtonLabel: S.of(context).openInvestmentAccount,
              secondaryButtonLabel: S.of(context).buttonMaybeLater,
            ),
          ),
        ),
      );

  static void open(BuildContext context) =>
      Navigator.of(context, rootNavigator: true).pushNamed(route);
}
