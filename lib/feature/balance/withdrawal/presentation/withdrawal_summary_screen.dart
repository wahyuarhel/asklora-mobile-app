import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/base_response.dart';
import '../../../../core/presentation/buttons/primary_button.dart';
import '../../../../core/presentation/custom_layout_with_blur_pop_up.dart';
import '../../../../core/presentation/custom_scaffold.dart';
import '../../../../core/presentation/custom_text_new.dart';
import '../../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../../core/presentation/lora_popup_message/model/lora_pop_up_message_model.dart';
import '../../../../core/presentation/suspended_account_screen.dart';
import '../../../../core/repository/transaction_repository.dart';
import '../../../../core/styles/asklora_colors.dart';
import '../../../../core/styles/asklora_text_styles.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../generated/l10n.dart';
import '../utils/withdrawal_utils.dart';
import '../../../settings/domain/bank_account.dart';
import '../../widgets/balance_base_form.dart';
import '../bloc/withdrawal_bloc.dart';
import 'withdrawal_result_screen.dart';

class WithdrawalSummaryScreen extends StatelessWidget {
  static const String route = '/withdrawal_summary_screen';
  static const int transactionFee = 10;

  final ({double withdrawalAmount, BankAccount bankAccount}) args;

  const WithdrawalSummaryScreen({required this.args, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WithdrawalBloc(
        transactionRepository: TransactionRepository(),
      ),
      child: BlocConsumer<WithdrawalBloc, WithdrawalState>(
        buildWhen: (previous, current) =>
            previous.response.state != current.response.state,
        listenWhen: (previous, current) =>
            previous.response.state != current.response.state,
        listener: (context, state) {
          CustomLoadingOverlay.of(context).show(state.response.state);
          if (state.response.state == ResponseState.success) {
            WithdrawalResultScreen.open(context);
          } else if (state.response.state == ResponseState.suspended) {
            SuspendedAccountScreen.open(context);
          }
        },
        builder: (context, state) => CustomScaffold(
            enableBackNavigation: false,
            body: CustomLayoutWithBlurPopUp(
              showPopUp: state.response.state == ResponseState.error,
              content: BalanceBaseForm(
                title: S.of(context).withdraw,
                content: Column(
                  children: [
                    getPngImage('money'),
                    const SizedBox(
                      height: 65,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 0.5,
                            color: AskLoraColors.gray,
                          ),
                          bottom: BorderSide(
                            width: 0.5,
                            color: AskLoraColors.gray,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: _textInfo(
                          title: S.of(context).to,
                          subTitle:
                              '${args.bankAccount.name} (${maskAccountNumber(args.bankAccount.accountNumber, end: args.bankAccount.accountNumber.length - 3)})'),
                    ),
                    const SizedBox(
                      height: 21,
                    ),
                    _textInfo(
                        title: S.of(context).withdrawalAmount,
                        subTitle: 'HKD $_withdrawalAmount'),
                    const SizedBox(
                      height: 24,
                    ),
                    _textInfo(
                        title: S.of(context).transactionFee,
                        subTitle: 'HKD -$transactionFee'),
                    const Divider(
                      thickness: 2,
                      color: AskLoraColors.charcoal,
                      height: 38,
                    ),
                    _textInfo(
                        title: S.of(context).totalAmount,
                        subTitle: 'HKD $_totalAmount'),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
                bottomButton: _bottomButton(context),
              ),
              loraPopUpMessageModel: LoraPopUpMessageModel(
                  title: S.of(context).unableToProcessWithdrawalTitle,
                  subTitle: S.of(context).unableToProcessWithdrawalSubTitle,
                  onPrimaryButtonTap: () => context
                      .read<WithdrawalBloc>()
                      .add(ResetWithdrawalResponse()),
                  primaryButtonLabel: S.of(context).buttonBack),
            )),
      ),
    );
  }

  String get _totalAmount =>
      (args.withdrawalAmount - transactionFee).convertToCurrencyDecimal();

  String get _withdrawalAmount =>
      args.withdrawalAmount.convertToCurrencyDecimal();

  Widget _bottomButton(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            CustomTextNew(
              S.of(context).withdrawalWorkingDays,
              style: AskLoraTextStyles.subtitle3
                  .copyWith(color: AskLoraColors.charcoal),
            ),
            const SizedBox(
              height: 30,
            ),
            BlocBuilder<WithdrawalBloc, WithdrawalState>(
                builder: (context, state) {
              return PrimaryButton(
                  disabled: state.response.state == ResponseState.loading,
                  label: S.of(context).buttonConfirm,
                  onTap: () => context
                      .read<WithdrawalBloc>()
                      .add(SubmitWithdrawal(args.withdrawalAmount.toString())));
            })
          ],
        ),
      );

  Widget _textInfo({required String title, required String subTitle}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextNew(
            title,
            style: AskLoraTextStyles.subtitleAllCap1
                .copyWith(color: AskLoraColors.charcoal),
          ),
          Flexible(
            child: CustomTextNew(
              subTitle,
              style: AskLoraTextStyles.body1
                  .copyWith(color: AskLoraColors.charcoal),
            ),
          ),
        ],
      );

  static void open(BuildContext context,
          {required ({
            double withdrawalAmount,
            BankAccount bankAccount
          }) args}) =>
      Navigator.pushNamed(context, route, arguments: args);
}
