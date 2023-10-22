import 'package:flutter/material.dart';

import '../../feature/settings/presentation/customer_service_screen.dart';
import '../../feature/tabs/presentation/tab_screen.dart';
import '../../generated/l10n.dart';
import 'buttons/button_pair.dart';
import 'custom_scaffold.dart';
import 'custom_status_widget.dart';
import 'custom_stretched_layout.dart';

class SuspendedAccountScreen extends StatelessWidget {
  static const String route = '/suspended_account_screen';

  const SuspendedAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: CustomScaffold(
        enableBackNavigation: false,
        body: CustomStretchedLayout(
          content: CustomStatusWidget(
            title: S.of(context).suspendedScreenTitle,
            subTitle: S.of(context).suspendedScreenSubTitle,
            statusType: StatusType.failed,
          ),
          bottomButton: ButtonPair(
              primaryButtonOnClick: () =>
                  TabScreen.openAndRemoveAllRoute(context),
              secondaryButtonOnClick: () => CustomerServiceScreen.open(context),
              primaryButtonLabel: S.of(context).buttonBackToHome,
              secondaryButtonLabel: S.of(context).buttonContactCustomerService),
        ),
      ),
    );
  }

  static void open(BuildContext context) => Navigator.pushNamed(context, route);
}
