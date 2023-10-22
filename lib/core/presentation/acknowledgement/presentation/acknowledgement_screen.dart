import 'package:flutter/material.dart';

import '../../../../../core/presentation/buttons/primary_button.dart';
import '../../../../../core/presentation/custom_scaffold.dart';
import '../../../../../core/presentation/custom_status_widget.dart';
import '../../../../../core/presentation/custom_stretched_layout.dart';
import '../domain/acknowledgement_model.dart';

class AcknowledgementScreen extends StatelessWidget {
  static const String route = '/acknowledgement_screen';

  final AcknowledgementModel acknowledgementModel;

  const AcknowledgementScreen({required this.acknowledgementModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: CustomScaffold(
          enableBackNavigation: false,
          body: CustomStretchedLayout(
            content: CustomStatusWidget(
              title: acknowledgementModel.title,
              statusType: acknowledgementModel.statusType,
              subTitle: acknowledgementModel.subTitle,
            ),
            bottomButton: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: PrimaryButton(
                label: acknowledgementModel.buttonTitle,
                onTap: acknowledgementModel.onButtonTap,
              ),
            ),
          )),
    );
  }

  static void open(
          {required BuildContext context,
          required AcknowledgementModel arguments}) =>
      Navigator.pushNamed(context, route, arguments: arguments);
}
