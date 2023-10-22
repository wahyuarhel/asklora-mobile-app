import 'package:flutter/material.dart';

import '../../../core/presentation/buttons/button_pair.dart';
import '../../../core/presentation/buttons/primary_button.dart';
import '../../../core/presentation/custom_scaffold.dart';
import '../../../core/presentation/custom_status_widget.dart';
import '../../../core/presentation/custom_stretched_layout.dart';
import '../../../generated/l10n.dart';
import '../../tabs/presentation/tab_screen.dart';
import '../../tabs/utils/tab_util.dart';
import '../bloc/bot_stock_bloc.dart';

class BotStockResultScreen extends StatelessWidget {
  static const String route = '/bot_stock_result_screen';
  final BotStockResultArgument arguments;

  const BotStockResultScreen({required this.arguments, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: CustomScaffold(
          enableBackNavigation: false,
          body: CustomStretchedLayout(
            content: CustomStatusWidget(
              title: arguments.title,
              statusType: StatusType.success,
              subTitle: arguments.desc,
            ),
            bottomButton: arguments.botOrderType == BotOrderType.cancel
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: PrimaryButton(
                        label: S.of(context).buttonBackToPortfolio,
                        onTap: () => TabScreen.openAndRemoveAllRoute(context,
                            initialTabPage: TabPage.portfolio)),
                  )
                : ButtonPair(
                    primaryButtonOnClick: () => TabScreen.openAndRemoveAllRoute(
                        context,
                        initialTabPage: TabPage.portfolio),
                    primaryButtonLabel: S.of(context).goToPortfolio,
                    secondaryButtonLabel: S.of(context).startAnotherInvestments,
                    secondaryButtonOnClick: () =>
                        TabScreen.openAndRemoveAllRoute(context,
                            initialTabPage: TabPage.forYou),
                  ),
          )),
    );
  }

  static void open({
    required BuildContext context,
    required BotStockResultArgument arguments,
  }) =>
      Navigator.pushNamed(context, route, arguments: arguments);

  static void openReplace(
          {required BuildContext context,
          required BotStockResultArgument arguments}) =>
      Navigator.pushReplacementNamed(context, route, arguments: arguments);

  static void openWithBackCallBack({
    required BuildContext context,
    required BotStockResultArgument arguments,
    required VoidCallback backCallBack,
  }) =>
      Navigator.of(context, rootNavigator: true)
          .pushNamed(route, arguments: arguments)
          .then((value) => backCallBack());
}

class BotStockResultArgument {
  final String title;
  final String desc;
  final BotOrderType botOrderType;

  const BotStockResultArgument({
    required this.title,
    required this.desc,
    this.botOrderType = BotOrderType.buy,
  });
}
