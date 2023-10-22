import 'package:flutter/material.dart';
import '../../../../core/presentation/custom_expanded_row.dart';
import '../../../../core/presentation/custom_header.dart';
import '../../../../core/presentation/custom_scaffold.dart';
import '../../../../core/styles/asklora_colors.dart';
import '../../../../core/styles/asklora_text_styles.dart';
import '../../../../core/values/app_values.dart';
import '../../../../generated/l10n.dart';
import '../../domain/transaction_history_model.dart';
import '../../utils/transaction_history_util.dart';

class TransferTransactionHistoryDetailScreen extends StatelessWidget {
  final TransactionHistoryModel transactionHistoryModel;
  static const String route = '/transfer_transaction_history_detail_screen';

  const TransferTransactionHistoryDetailScreen(
      {required this.transactionHistoryModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          CustomHeader(
              title: TransferType.findByTitle(
                      transactionHistoryModel.transferType.title)
                  .titleText(context)),
          const SizedBox(
            height: 30,
          ),
          _withdrawalInformation(
              '${transactionHistoryModel.depositOrWithdrawalAmountTitle(context)} (HKD)',
              '\$${transactionHistoryModel.amountString}'),
          _withdrawalInformation(S.of(context).timeRequested,
              transactionHistoryModel.createdFormatted),
          _withdrawalInformation(S.of(context).bankAccountNumber,
              transactionHistoryModel.bankAccountNumberString),
          _withdrawalInformation(
              S.of(context).status,
              TransferStatus.findByString(
                      transactionHistoryModel.transferStatus.name)
                  .text(context),
              subTitleColor: transactionHistoryModel.transferStatus.color),
          _withdrawalInformation(S.of(context).timeCompleted,
              transactionHistoryModel.timeCompletedFormatted)
        ],
      ),
    );
  }

  Widget _withdrawalInformation(String title, String subTitle,
      {Color subTitleColor = AskLoraColors.charcoal}) {
    return Container(
      constraints: const BoxConstraints(minHeight: 66),
      margin: AppValues.screenHorizontalPadding,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 0.5, color: AskLoraColors.gray))),
      child: CustomExpandedRow(
        title,
        padding: EdgeInsets.zero,
        leftTextStyle:
            AskLoraTextStyles.h6.copyWith(color: AskLoraColors.charcoal),
        rightTextStyle:
            AskLoraTextStyles.subtitle2.copyWith(color: subTitleColor),
        text: subTitle,
        flex2: 2,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }

  static void open(BuildContext context,
          TransactionHistoryModel transactionHistoryModel) =>
      Navigator.pushNamed(context, route, arguments: transactionHistoryModel);
}
