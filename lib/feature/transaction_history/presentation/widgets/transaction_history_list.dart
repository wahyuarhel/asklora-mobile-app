part of '../transaction_history_screen.dart';

class TransactionHistoryList extends StatelessWidget {
  const TransactionHistoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: () async =>
            context.read<TransactionHistoryBloc>().add(FetchAllTransaction()),
        child: BlocConsumer<TransactionHistoryBloc, TransactionHistoryState>(
          listenWhen: (previous, current) =>
              previous.allTransactionsResponse.state !=
              current.allTransactionsResponse.state,
          listener: (context, state) {
            CustomLoadingOverlay.of(context)
                .show(state.allTransactionsResponse.state);
          },
          buildWhen: (previous, current) =>
              previous.allTransactionsResponse !=
              current.allTransactionsResponse,
          builder: (context, state) {
            if (state.allTransactionsResponse.data != null &&
                state.allTransactionsResponse.data!.isNotEmpty) {
              return ListView(
                children: state.allTransactionsResponse.data!
                    .map((e) => TransactionHistoryGroupWidget(
                        title: e.groupType == GroupType.today
                            ? S.of(context).transactionHistoryToday
                            : e.formattedTransactionHistoryGroupTitle,
                        data: e.data,
                        showBottomBorder:
                            state.allTransactionsResponse.data!.indexOf(e) ==
                                state.allTransactionsResponse.data!.length - 1))
                    .toList(),
              );
            } else if (state.allTransactionsResponse.state ==
                ResponseState.loading) {
              return const SizedBox.shrink();
            } else {
              return const EmptyTransactionPlaceholder();
            }
          },
        ),
      );
}
