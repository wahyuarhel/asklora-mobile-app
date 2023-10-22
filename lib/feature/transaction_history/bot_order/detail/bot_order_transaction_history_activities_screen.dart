part of 'bot_order_transaction_history_detail_screen.dart';

class BotOrderTransactionHistoryActivitiesScreen extends StatelessWidget {
  final BotStatus botStatusType;
  const BotOrderTransactionHistoryActivitiesScreen(
      {required this.botStatusType, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<
          BotTransactionHistoryDetailBloc, BotTransactionHistoryDetailState>(
        buildWhen: (previous, current) =>
            previous.activities != current.activities,
        builder: (context, state) {
          if (botStatusType == BotStatus.pending ||
              botStatusType == BotStatus.cancelled ||
              botStatusType == BotStatus.rejected) {
            return const EmptyActivityPlaceholder();
          } else {
            return state.activities.isNotEmpty
                ? ListView(
                    children: state.activities
                        .map((e) =>
                            BotOrderTransactionHistoryActivitiesGroupWidget(
                                title:
                                    e.groupType == GroupType.today
                                        ? S.of(context).transactionHistoryToday
                                        : e.formattedActivitiesGroupTitle,
                                data: e.data,
                                showBottomBorder: state.activities.indexOf(e) ==
                                    state.activities.length - 1))
                        .toList(),
                  )
                : const EmptyActivityPlaceholder();
          }
        },
      );
}
