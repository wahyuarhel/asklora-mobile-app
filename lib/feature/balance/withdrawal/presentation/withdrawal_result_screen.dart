import 'package:flutter/material.dart';
import '../../../../core/presentation/buttons/button_pair.dart';
import '../../../../core/presentation/custom_status_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../tabs/presentation/tab_screen.dart';
import '../../../tabs/utils/tab_util.dart';
import '../../../transaction_history/presentation/transaction_history_screen.dart';
import '../../widgets/balance_base_form.dart';

class WithdrawalResultScreen extends StatelessWidget {
  static const String route = '/withdrawal_result_screen';

  const WithdrawalResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BalanceBaseForm(
          enableBackNavigation: false,
          useHeader: false,
          content: CustomStatusWidget(
            title: S.of(context).withdrawalRequestSubmittedTitle,
            statusType: StatusType.success,
            subTitle: S.of(context).withdrawalRequestSubmittedSubTitle,
          ),
          bottomButton: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ButtonPair(
              primaryButtonLabel: S.of(context).buttonDone,
              primaryButtonOnClick: () => TabScreen.openAndRemoveAllRoute(
                  context,
                  initialTabPage: TabPage.portfolio),
              secondaryButtonLabel: S.of(context).buttonViewTransactionHistory,
              secondaryButtonOnClick: () =>
                  TransactionHistoryScreen.open(context),
            ),
          )),
    );
  }

  static void open(BuildContext context) =>
      Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
}
