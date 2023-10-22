import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/buttons/primary_button.dart';
import '../../../../../core/presentation/custom_key_pad/custom_key_pad.dart';
import '../../../../../core/presentation/custom_scaffold.dart';
import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/repository/transaction_repository.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../core/values/app_values.dart';
import '../../../../../generated/l10n.dart';
import '../../../../settings/domain/bank_account.dart';
import '../../bloc/withdrawal_bloc.dart';
import '../withdrawal_summary_screen.dart';

part 'widgets/withdrawal_amount_value.dart';

part 'widgets/withdrawal_key_pad.dart';

class WithdrawalAmountScreen extends StatelessWidget {
  static const String route = '/withdrawal_amount_screen';
  final ({double withdrawableBalance, BankAccount bankAccount}) args;

  const WithdrawalAmountScreen({Key? key, required this.args})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WithdrawalBloc(
        transactionRepository: TransactionRepository(),
      ),
      child: CustomScaffold(
          body: Padding(
        padding: AppValues.screenHorizontalPadding,
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 22.0),
                child: CustomTextNew(
                  S.of(context).withdraw,
                  style: AskLoraTextStyles.h5
                      .copyWith(color: AskLoraColors.charcoal),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: Column(
                children: [
                  WithdrawalAmountValue(
                      withdrawableBalance: args.withdrawableBalance),
                  const WithdrawalKeyPad(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: BlocBuilder<WithdrawalBloc, WithdrawalState>(
                buildWhen: (previous, current) =>
                    previous.withdrawalAmount != current.withdrawalAmount,
                builder: (context, state) => PrimaryButton(
                    disabled: state.disableWithdrawal(args.withdrawableBalance),
                    label: S.of(context).buttonNext,
                    onTap: () => WithdrawalSummaryScreen.open(context, args: (
                          withdrawalAmount: double.parse(
                              state.withdrawalAmount.isEmpty
                                  ? '0'
                                  : state.withdrawalAmount.replaceAll(',', '')),
                          bankAccount: args.bankAccount
                        ))),
              ),
            )
          ],
        ),
      )),
    );
  }

  static void open(BuildContext context,
          ({double withdrawableBalance, BankAccount bankAccount}) args) =>
      Navigator.pushNamed(context, route, arguments: args);
}
