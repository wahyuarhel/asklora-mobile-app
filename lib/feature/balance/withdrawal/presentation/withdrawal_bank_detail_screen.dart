import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/base_response.dart';
import '../../../../core/presentation/buttons/primary_button.dart';
import '../../../../core/presentation/custom_layout_with_blur_pop_up.dart';
import '../../../../core/presentation/custom_scaffold.dart';
import '../../../../core/presentation/custom_text_new.dart';
import '../../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../../core/presentation/lora_popup_message/model/lora_pop_up_message_model.dart';
import '../../../../core/styles/asklora_colors.dart';
import '../../../../core/styles/asklora_text_styles.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../generated/l10n.dart';
import '../../../onboarding/kyc/repository/account_repository.dart';
import '../../../settings/bloc/account_information/account_information_bloc.dart';
import '../../../settings/domain/bank_account.dart';
import '../../widgets/balance_base_form.dart';
import '../../widgets/change_bank_account_button.dart';
import 'widgets/withdrawal_steps.dart';
import 'withdrawal_amount/withdrawal_amount_screen.dart';

class WithdrawalBankDetailScreen extends StatelessWidget {
  static const String route = '/withdrawal_bank_detail_screen';
  final double withdrawableBalance;

  const WithdrawalBankDetailScreen(
      {required this.withdrawableBalance, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          AccountInformationBloc(accountRepository: AccountRepository())
            ..add(GetAccountInformation()),
      child: BlocConsumer<AccountInformationBloc, AccountInformationState>(
        listener: (context, state) {
          CustomLoadingOverlay.of(context).show(state.response.state);
        },
        builder: (context, state) {
          final bankAccount = state.response.data?.bankAccount;
          return CustomScaffold(
            enableBackNavigation: false,
            body: CustomLayoutWithBlurPopUp(
              showPopUp: state.response.state == ResponseState.error ||
                  (state.response.state != ResponseState.loading &&
                      bankAccount == null),
              loraPopUpMessageModel: LoraPopUpMessageModel(
                  primaryButtonLabel: S.of(context).buttonBackToPortfolio,
                  onPrimaryButtonTap: () => Navigator.pop(context),
                  title: S.of(context).errorWithdrawalUnavailableTitle,
                  subTitle: S.of(context).errorWithdrawalUnavailableSubTitle),
              content: BalanceBaseForm(
                content: bankAccount != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sourceTransfer,
                          _transferToIcon(context),
                          WithdrawalSteps(
                            bankAccount: bankAccount,
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                          const ChangeBankAccountButton()
                        ],
                      )
                    : const SizedBox.shrink(),
                bottomButton: state.response.state == ResponseState.success &&
                        bankAccount != null
                    ? _bottomButton(context, bankAccount)
                    : const SizedBox.shrink(),
                title: S.of(context).withdraw,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget get _sourceTransfer => Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: AskLoraColors.darkGray),
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: CustomTextNew(
          'Asklora',
          style: AskLoraTextStyles.subtitle2,
        ),
      );

  Widget _transferToIcon(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _greenVerticalLine,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                getSvgIcon('icon_arrow_down_withdrawal'),
                const SizedBox(
                  width: 13,
                ),
                CustomTextNew(
                  S.of(context).transferTo,
                  style: AskLoraTextStyles.subtitle3,
                )
              ],
            ),
            _greenVerticalLine,
          ],
        ),
      );

  Widget get _greenVerticalLine => Container(
        margin: const EdgeInsets.only(left: 16),
        height: 15,
        width: 2,
        color: AskLoraColors.primaryGreen,
      );

  Widget _bottomButton(BuildContext context, BankAccount bankAccount) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      child: PrimaryButton(
        label: S.of(context).buttonWithdraw,
        onTap: () => WithdrawalAmountScreen.open(context, (
          withdrawableBalance: withdrawableBalance,
          bankAccount: bankAccount
        )),
      ),
    );
  }

  static void open(BuildContext context, double withdrawableBalance) =>
      Navigator.of(context, rootNavigator: true)
          .pushNamed(route, arguments: withdrawableBalance);
}
