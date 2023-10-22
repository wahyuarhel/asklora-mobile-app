import 'package:flutter/material.dart';

import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/presentation/round_colored_box.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../generated/l10n.dart';
import '../../../../onboarding/kyc/presentation/widgets/custom_stepper/custom_stepper.dart';
import '../../../../settings/domain/bank_account.dart';

class WithdrawalSteps extends StatelessWidget {
  final BankAccount? bankAccount;

  const WithdrawalSteps({required this.bankAccount, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (bankAccount != null) {
      return SizedBox(
        width: double.infinity,
        child: RoundColoredBox(
          content:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _step(
                content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: CustomTextNew(
                    S.of(context).yourBankAccount,
                    style: AskLoraTextStyles.h5
                        .copyWith(color: AskLoraColors.charcoal),
                  ),
                ),
                CustomTextNew(
                  bankAccount!.name,
                  style: AskLoraTextStyles.body2,
                ),
                const SizedBox(
                  height: 4,
                ),
                CustomTextNew(
                  bankAccount!.accountNumber,
                  style: AskLoraTextStyles.body2,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextNew(
                  bankAccount!.accountName,
                  style: AskLoraTextStyles.body2,
                ),
              ],
            )),
            _step(
                drawLine: false,
                content: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: CustomTextNew(
                    S.of(context).withdrawalWorkingDays,
                    style: AskLoraTextStyles.body2,
                  ),
                ))
          ]),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _step({
    bool drawLine = true,
    required Widget content,
  }) =>
      CustomStep(
        spaceVertical: 24,
        drawLine: drawLine,
        widgetIcon: Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: getSvgIcon('inactive_step_icon', height: 18, width: 18),
        ),
        widgetStep: content,
      );
}
