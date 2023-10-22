part of '../presentation/transaction_history_screen.dart';

class BotOrderTransactionHistoryList extends StatelessWidget {
  const BotOrderTransactionHistoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: () async =>
            context.read<TransactionHistoryBloc>().add(FetchBotTransaction()),
        child: BlocConsumer<TransactionHistoryBloc, TransactionHistoryState>(
          listenWhen: (previous, current) =>
              previous.botTransactionsResponse.state !=
              current.botTransactionsResponse.state,
          listener: (context, state) {
            CustomLoadingOverlay.of(context)
                .show(state.botTransactionsResponse.state);
          },
          buildWhen: (previous, current) =>
              previous.botTransactionsResponse !=
              current.botTransactionsResponse,
          builder: (context, state) {
            if (state.botTransactionsResponse.data != null &&
                state.botTransactionsResponse.data!.isNotEmpty) {
              return ListView(
                children: state.botTransactionsResponse.data!
                    .map((e) => TransactionHistoryGroupWidget(
                        title: e.groupType == GroupType.today
                            ? S.of(context).transactionHistoryToday
                            : e.formattedTransactionHistoryGroupTitle,
                        data: e.data,
                        showBottomBorder:
                            state.botTransactionsResponse.data!.indexOf(e) ==
                                state.botTransactionsResponse.data!.length - 1))
                    .toList(),
              );
            } else if (state.botTransactionsResponse.state ==
                ResponseState.loading) {
              return const SizedBox.shrink();
            } else {
              return const EmptyTransactionPlaceholder();
            }
          },
        ),
      );
}
