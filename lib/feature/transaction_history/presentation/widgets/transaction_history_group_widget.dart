part of '../transaction_history_screen.dart';

class TransactionHistoryGroupWidget extends StatelessWidget {
  final String title;
  final List<TransactionHistoryModel> data;
  final bool showBottomBorder;

  const TransactionHistoryGroupWidget(
      {required this.title,
      required this.data,
      required this.showBottomBorder,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: showBottomBorder
                  ? const BorderSide(color: AskLoraColors.gray, width: 0.5)
                  : BorderSide.none)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TransactionHistoryGroupTitle(
            title: title,
          ),
          ...data
              .map(
                (e) => e.transactionHistoryType == TransactionHistoryType.bot
                    ? BotOrderTransactionHistoryCard(
                        transactionHistoryModel: e,
                        showBottomBorder: data.indexOf(e) != data.length - 1,
                      )
                    : TransferTransactionHistoryCard(
                        transactionHistoryModel: e,
                        showBottomBorder: data.indexOf(e) != data.length - 1,
                      ),
              )
              .toList()
        ],
      ),
    );
  }
}
