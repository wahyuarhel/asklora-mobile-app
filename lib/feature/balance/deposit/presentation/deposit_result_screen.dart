import 'package:flutter/material.dart';

import '../../../../core/domain/pair.dart';
import '../../../../core/presentation/buttons/button_pair.dart';
import '../../../../core/presentation/buttons/primary_button.dart';
import '../../../../core/presentation/custom_status_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../tabs/presentation/tab_screen.dart';
import '../../../tabs/utils/tab_util.dart';
import '../../../transaction_history/presentation/transaction_history_screen.dart';
import '../../widgets/balance_base_form.dart';
import '../utils/deposit_utils.dart';

class DepositResultScreen extends StatelessWidget {
  static const String route = '/deposit_result_screen';
  final StatusType statusType;
  final DepositType depositType;

  const DepositResultScreen(
      {required this.statusType, required this.depositType, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BalanceBaseForm(
          enableBackNavigation: false,
          title: S.of(context).deposit,
          useHeader: false,
          content: CustomStatusWidget(
            title: S.of(context).depositRequestSubmittedTitle,
            statusType: statusType,
            subTitle: _getResultProps(context).left,
          ),
          bottomButton: _getResultProps(context).right),
    );
  }

  Pair<String, Widget> _getResultProps(BuildContext context) {
    switch (depositType) {
      case DepositType.firstTime:
        return Pair(
            S.of(context).depositRequestSubmittedSubTitleFirstTime,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: PrimaryButton(
                label: S.of(context).buttonDone,
                onTap: () => TabScreen.openAndRemoveAllRoute(
                  context,
                  initialTabPage: TabPage.portfolio,
                ),
              ),
            ));
      default:
        return Pair(
            S.of(context).depositRequestSubmittedSubTitleReturn,
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ButtonPair(
                primaryButtonLabel: S.of(context).buttonDone,
                primaryButtonOnClick: () => TabScreen.openAndRemoveAllRoute(
                    context,
                    initialTabPage: TabPage.portfolio),
                secondaryButtonLabel:
                    S.of(context).buttonViewTransactionHistory,
                secondaryButtonOnClick: () =>
                    TransactionHistoryScreen.open(context),
              ),
            ));
    }
  }

  static void open(
          {required BuildContext context,
          required Pair<DepositType, StatusType> arguments}) =>
      Navigator.pushNamedAndRemoveUntil(
        context,
        route,
        arguments: arguments,
        (route) => false,
      );
}
