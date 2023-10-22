import 'package:flutter/material.dart';

import '../../../core/presentation/custom_text_new.dart';
import '../../../core/styles/asklora_text_styles.dart';
import '../../../generated/l10n.dart';
import '../deposit/presentation/welcome/deposit_welcome_screen.dart';
import '../deposit/utils/deposit_utils.dart';

class ChangeBankAccountButton extends StatelessWidget {
  const ChangeBankAccountButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => DepositWelcomeScreen.open(
          context: context,
          depositType: DepositType.changeBankAccount,
        ),
        child: UnconstrainedBox(
          child: Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(width: .5))),
            child: CustomTextNew(S.of(context).changeBankAccount,
                style: AskLoraTextStyles.h6),
          ),
        ),
      );
}
