part of 'order_screen.dart';

class LimitOrderWidget extends StatelessWidget {
  final OrderState orderState;
  final SymbolDetail symbolDetail;

  const LimitOrderWidget(
      {required this.orderState, required this.symbolDetail, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              OrderTypePriceWidget.input(
                prefixTitle: orderState.orderType.name,
                onChanged: (value) => context.read<LimitOrderBloc>().add(
                    LimitChanged(value.isNotEmpty ? double.parse(value) : 0)),
              ),
              SharesQuantityWidget.input(
                  onChanged: (value) => context.read<LimitOrderBloc>().add(
                      QuantityChanged(
                          value.isNotEmpty ? double.parse(value) : 0))),
              const TimeInForceWidget(),
              const TradingHoursWidget(),
              const SizedBox(
                height: 40,
              ),
              MarketPriceWidget(symbolDetail: symbolDetail),
              BlocBuilder<LimitOrderBloc, LimitOrderState>(
                  buildWhen: (previous, current) =>
                      previous.estimateTotal != current.estimateTotal,
                  builder: (context, state) => EstimatedTotalWidget(
                      value: state.estimateTotal.toString())),
              if (orderState.transactionType == TransactionType.buy) ...[
                BlocBuilder<LimitOrderBloc, LimitOrderState>(
                  buildWhen: (previous, current) =>
                      previous.availableBuyingPower !=
                      current.availableBuyingPower,
                  builder: (context, state) => AvailableBuyingPowerWidget(
                      value: state.availableBuyingPower.toString()),
                )
              ] else if (orderState.transactionType ==
                  TransactionType.sell) ...[
                BlocBuilder<LimitOrderBloc, LimitOrderState>(
                  buildWhen: (previous, current) =>
                      previous.availableAmountToSell !=
                      current.availableAmountToSell,
                  builder: (context, state) => AvailableAmountToSellWidget(
                      value: state.availableAmountToSell.toString()),
                ),
                BlocBuilder<LimitOrderBloc, LimitOrderState>(
                  buildWhen: (previous, current) =>
                      previous.numberOfSellableShares !=
                      current.numberOfSellableShares,
                  builder: (context, state) => NumberOfSellableSharesWidget(
                      value: state.numberOfSellableShares.toString()),
                )
              ],
            ],
          ),
        ),
        BlocBuilder<LimitOrderBloc, LimitOrderState>(
            buildWhen: (previous, current) =>
                orderState.transactionType == TransactionType.buy &&
                    previous.buyErrorText != current.buyErrorText ||
                orderState.transactionType == TransactionType.sell &&
                    previous.sellErrorText != current.sellErrorText ||
                previous.response.state != current.response.state ||
                previous.limit != current.limit ||
                previous.quantity != current.quantity,
            builder: (context, state) =>
                OrderConfirmationButton<LimitOrderState>(
                    dynamicState: state,
                    errorText: orderState.transactionType == TransactionType.buy
                        ? state.buyErrorText
                        : state.sellErrorText,
                    isLoading: state.response.state == ResponseState.loading,
                    disable:
                        state.disabledConfirmButton(orderState.transactionType),
                    orderState: context.read<OrderBloc>().state,
                    symbolDetail: symbolDetail,
                    onConfirmedTap: () => context.read<LimitOrderBloc>().add(
                          OrderSubmitted(OrderRequest.limit(
                              symbolType: symbolDetail.symbolType.name,
                              symbol: symbolDetail.name,
                              side: orderState.transactionType.name,
                              quantity: state.quantity.toString(),
                              limitPrice: state.limit.toString())),
                        )))
      ],
    );
  }
}
