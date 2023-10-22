import 'package:flutter/material.dart';

import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';

class SessionResetWidget extends StatelessWidget {
  const SessionResetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Divider(thickness: 1, color: AskLoraColors.gray, endIndent: 5),
        ),
        CustomTextNew('Context is cleared for current session',
            style: AskLoraTextStyles.body3),
        const Expanded(
          child: Divider(thickness: 1, color: AskLoraColors.gray, indent: 5),
        ),
      ],
    );
  }
}
