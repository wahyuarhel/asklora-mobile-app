part of '../presentation/transaction_history_screen.dart';

class TransferTransactionHistoryList extends StatelessWidget {
  const TransferTransactionHistoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: () async => context
            .read<TransactionHistoryBloc>()
            .add(FetchTransferTransaction()),
        child: BlocConsumer<TransactionHistoryBloc, TransactionHistoryState>(
          listenWhen: (previous, current) =>
              previous.transferTransactionsResponse.state !=
              current.transferTransactionsResponse.state,
          listener: (context, state) {
            CustomLoadingOverlay.of(context)
                .show(state.transferTransactionsResponse.state);
          },
          buildWhen: (previous, current) =>
              previous.transferTransactionsResponse !=
              current.transferTransactionsResponse,
          builder: (context, state) {
            if (state.transferTransactionsResponse.data != null &&
                state.transferTransactionsResponse.data!.isNotEmpty) {
              return ListView(
                children: state.transferTransactionsResponse.data!
                    .map((e) => TransactionHistoryGroupWidget(
                        title: e.groupType == GroupType.today
                            ? S.of(context).transactionHistoryToday
                            : e.formattedTransactionHistoryGroupTitle,
                        data: e.data,
                        showBottomBorder: state
                                .transferTransactionsResponse.data!
                                .indexOf(e) ==
                            state.transferTransactionsResponse.data!.length -
                                1))
                    .toList(),
              );
            } else if (state.transferTransactionsResponse.state ==
                ResponseState.loading) {
              return const SizedBox.shrink();
            } else {
              return const EmptyTransactionPlaceholder();
            }
          },
        ),
      );
}
