part of '../bot_order_transaction_history_detail_screen.dart';

class BotOrderTransactionHistoryDetailContent extends StatelessWidget {
  final String botOrderId;
  final String botStatus;
  final String title;
  late final BotStatus botStatusType;

  BotOrderTransactionHistoryDetailContent(
      {required this.title,
      required this.botStatus,
      required this.botOrderId,
      Key? key})
      : super(key: key) {
    botStatusType = BotStatus.findByOmsStatus(botStatus);
  }

  @override
  Widget build(BuildContext context) {
    return TransactionHistoryTabScreen(
      header: _header(context),
      tabs: getTabs(context),
      tabViews: getTabViews(context),
    );
  }

  List<String> getTabs(BuildContext context) {
    List<String> tabs = [
      S.of(context).summary,
      S.of(context).activities,
    ];
    if (botStatusType == BotStatus.expired) {
      tabs.add(S.of(context).performance);
    }
    return tabs;
  }

  List<Widget> getTabViews(BuildContext context) {
    List<Widget> tabViews = [
      BotOrderTransactionHistorySummaryScreen(botStatusType: botStatusType),
      BotOrderTransactionHistoryActivitiesScreen(botStatusType: botStatusType),
    ];
    if (botStatusType == BotStatus.expired) {
      tabViews.add(
          BotOrderTransactionHistoryPerformanceScreen(botOrderId: botOrderId));
    }
    return tabViews;
  }

  Widget _header(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 24,
                      )),
                )),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              flex: 5,
              child: Center(
                child: AutoSizedTextWidget(
                  title,
                  style: AskLoraTextStyles.h5,
                  maxLines: 1,
                ),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Flexible(
                flex: 3,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: _statusWidget(context)))
          ],
        ),
      );

  Widget _statusWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 5, 16, 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1.4, color: botStatusType.color),
      ),
      child: AutoSizedTextWidget(
        BotStatus.findByString(botStatusType.name).text(context),
        maxLines: 1,
        style: AskLoraTextStyles.subtitle3.copyWith(color: botStatusType.color),
        textAlign: TextAlign.center,
      ),
    );
  }
}
