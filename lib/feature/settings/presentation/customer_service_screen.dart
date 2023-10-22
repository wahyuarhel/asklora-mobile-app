import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/presentation/custom_header.dart';
import '../../../core/presentation/custom_scaffold.dart';
import '../../../core/presentation/custom_stretched_layout.dart';
import '../../../core/presentation/custom_text_new.dart';
import '../../../core/styles/asklora_text_styles.dart';
import '../../../core/utils/utils.dart';
import '../../../generated/l10n.dart';

class CustomerServiceScreen extends StatelessWidget {
  static const String route = '/customer_service_screen';

  const CustomerServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: CustomStretchedLayout(
            header: CustomHeader(title: S.of(context).customerService),
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () => openUrl('mailto:loracares@asklora.ai',
                          mode: LaunchMode.externalApplication),
                      child: _text(
                          title: S.of(context).email,
                          value: 'loracares@asklora.ai')),
                  const SizedBox(height: 22),
                  _text(
                      title: S.of(context).officeHoursLabel,
                      value: S.of(context).officeHours),
                ],
              ),
            )));
  }

  Widget _text({required String title, required String value}) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextNew(title, style: AskLoraTextStyles.body1),
          CustomTextNew(value, style: AskLoraTextStyles.body1),
        ],
      ),
    );
  }

  static void open(BuildContext context) => Navigator.pushNamed(context, route);
}
