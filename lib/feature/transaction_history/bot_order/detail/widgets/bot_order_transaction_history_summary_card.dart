part of '../bot_order_transaction_history_detail_screen.dart';

class BotOrderTransactionHistorySummaryCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String? additionalText;
  final bool showBottomBorder;

  const BotOrderTransactionHistorySummaryCard(
      {required this.title,
      required this.subTitle,
      required this.showBottomBorder,
      this.additionalText,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(17, 21, 17, 26),
      decoration: BoxDecoration(
          border: Border(
              bottom: showBottomBorder
                  ? const BorderSide(color: AskLoraColors.gray, width: 0.5)
                  : BorderSide.none)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomTextNew(
                  title,
                  style: AskLoraTextStyles.subtitle2,
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 1.6,
                ),
                child: AutoSizedTextWidget(
                  subTitle,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          if (additionalText != null)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: CustomTextNew(
                  additionalText!,
                  style: AskLoraTextStyles.body3
                      .copyWith(color: AskLoraColors.darkGray),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
