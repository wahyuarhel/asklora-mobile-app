part of 'bot_order_transaction_history_detail_screen.dart';

class BotOrderTransactionHistorySummaryScreen extends StatelessWidget {
  final BotStatus botStatusType;

  const BotOrderTransactionHistorySummaryScreen(
      {required this.botStatusType, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<
          BotTransactionHistoryDetailBloc, BotTransactionHistoryDetailState>(
        buildWhen: (previous, current) =>
            previous.response.state != current.response.state,
        builder: (context, state) {
          List<BotSummaryTransactionHistoryModel> botSummaries =
              state.response.data?.summary ?? [];
          return ListView(
            children: botSummaries
                .map((botSummaryTransactionHistoryModel) => _getCard(
                      context: context,
                      botSummaryTransactionHistoryModel:
                          botSummaryTransactionHistoryModel,
                      botDuration: state.response.data?.botDuration ?? 'NA',
                      showLastBottomBorder: botSummaries
                              .indexOf(botSummaryTransactionHistoryModel) ==
                          0,
                    ))
                .toList(),
          );
        },
      );

  Widget _getCard(
      {required BuildContext context,
      required BotSummaryTransactionHistoryModel
          botSummaryTransactionHistoryModel,
      required String botDuration,
      required bool showLastBottomBorder}) {
    final BotSummaryType botSummaryType =
        botSummaryTransactionHistoryModel.botSummaryType;
    if (botSummaryType == BotSummaryType.setActive ||
        botSummaryType == BotSummaryType.makeLive ||
        botSummaryType == BotSummaryType.makeCancel ||
        botSummaryType == BotSummaryType.rejectedOms) {
      return _completeSummaryCard(
          context,
          botSummaryTransactionHistoryModel,
          getNameByBotSummaryType(context, botSummaryType),
          showLastBottomBorder,
          botDuration);
    } else {
      return _expiredCard(context, botSummaryTransactionHistoryModel);
    }
  }

  Widget _completeSummaryCard(
      BuildContext context,
      BotSummaryTransactionHistoryModel botSummaryTransactionHistoryModel,
      String additionalTitleInfo,
      bool showLastBottomBorder,
      String botDuration) {
    return Column(
      children: [
        TransactionHistoryGroupTitle(
          title:
              '${botSummaryTransactionHistoryModel.createdFormattedString} ($additionalTitleInfo)',
        ),
        BotOrderTransactionHistorySummaryCard(
          title: S.of(context).botStockId,
          subTitle: botSummaryTransactionHistoryModel.uid,
          showBottomBorder: true,
        ),
        BotOrderTransactionHistorySummaryCard(
          title: S.of(context).investmentAmount,
          subTitle: botSummaryTransactionHistoryModel.investmentAmountString,
          showBottomBorder: true,
        ),
        BotOrderTransactionHistorySummaryCard(
          title: S.of(context).botDuration,
          subTitle: botDuration,
          showBottomBorder: true,
        ),
        BotOrderTransactionHistorySummaryCard(
          title: S.of(context).botManagementFee,
          subTitle: botSummaryTransactionHistoryModel.feeString,
          showBottomBorder: showLastBottomBorder,
        ),
      ],
    );
  }

  Widget _expiredCard(BuildContext context,
      BotSummaryTransactionHistoryModel botSummaryTransactionHistoryModel) {
    return Column(
      children: [
        TransactionHistoryGroupTitle(
          title:
              '${botSummaryTransactionHistoryModel.createdFormattedString} (${S.of(context).orderExpired})',
        ),
        BotOrderTransactionHistorySummaryCard(
          title: S.of(context).endedAmount,
          subTitle: botSummaryTransactionHistoryModel.investmentAmountString,
          additionalText:
              '${S.of(context).totalPnlIs} ${botSummaryTransactionHistoryModel.totalPnLString}',
          showBottomBorder: true,
        ),
      ],
    );
  }
}
