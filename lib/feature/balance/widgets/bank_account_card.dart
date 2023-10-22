import 'package:flutter/material.dart';

import '../../../core/presentation/custom_text_new.dart';
import '../../../core/presentation/round_colored_box.dart';
import '../../../core/styles/asklora_text_styles.dart';
import '../../settings/domain/bank_account.dart';

class BankAccountCard extends StatelessWidget {
  final BankAccount? bankAccount;

  const BankAccountCard({required this.bankAccount, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (bankAccount != null) {
      return SizedBox(
        width: double.infinity,
        child: RoundColoredBox(
          content:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomTextNew(bankAccount!.name, style: AskLoraTextStyles.h6),
            const SizedBox(height: 5),
            CustomTextNew(bankAccount!.accountNumber,
                style: AskLoraTextStyles.body1),
            const SizedBox(height: 20),
            CustomTextNew(bankAccount!.accountName,
                style: AskLoraTextStyles.body1),
          ]),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
