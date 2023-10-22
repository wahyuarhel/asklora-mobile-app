part of 'order_screen.dart';

class StopOrderWidget extends StatelessWidget {
  final OrderState orderState;
  final SymbolDetail symbolDetail;

  const StopOrderWidget(
      {required this.orderState, required this.symbolDetail, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            physics: const ScrollPhysics(),
            children: [
              OrderTypePriceWidget.input(
                prefixTitle: orderState.orderType.name,
                onChanged: (value) => context.read<StopOrderBloc>().add(
                    StopPriceChanged(
                        value.isNotEmpty ? double.parse(value) : 0)),
              ),
              SharesQuantityWidget.input(
                onChanged: (value) => context.read<StopOrderBloc>().add(
                    StopQuantityChanged(
                        value.isNotEmpty ? double.parse(value) : 0)),
              ),
              const TimeInForceWidget(),
              const TradingHoursWidget(),
              const SizedBox(
                height: 40,
              ),
              MarketPriceWidget(symbolDetail: symbolDetail),
              BlocBuilder<StopOrderBloc, StopOrderState>(
                  buildWhen: (previous, current) =>
                      previous.estimateTotal != current.estimateTotal,
                  builder: (context, state) => EstimatedTotalWidget(
                      value: state.estimateTotal.toString())),
              if (orderState.transactionType == TransactionType.buy) ...[
                BlocBuilder<StopOrderBloc, StopOrderState>(
                  buildWhen: (previous, current) =>
                      previous.availableBuyingPower !=
                      current.availableBuyingPower,
                  builder: (context, state) => AvailableBuyingPowerWidget(
                      value: state.availableBuyingPower.toString()),
                ),
              ] else if (orderState.transactionType ==
                  TransactionType.sell) ...[
                BlocBuilder<StopOrderBloc, StopOrderState>(
                  buildWhen: (previous, current) =>
                      previous.availableAmountToSell !=
                      current.availableAmountToSell,
                  builder: (context, state) => AvailableAmountToSellWidget(
                      value: state.availableAmountToSell.toString()),
                ),
                BlocBuilder<StopOrderBloc, StopOrderState>(
                  buildWhen: (previous, current) =>
                      previous.numberOfSellableShares !=
                      current.numberOfSellableShares,
                  builder: (context, state) => NumberOfSellableSharesWidget(
                      value: state.numberOfSellableShares.toString()),
                ),
              ],
            ],
          ),
        ),
        BlocBuilder<StopOrderBloc, StopOrderState>(
          buildWhen: (previous, current) =>
              orderState.transactionType == TransactionType.buy &&
                  previous.buyErrorText != current.buyErrorText ||
              orderState.transactionType == TransactionType.sell &&
                  previous.sellErrorText != current.sellErrorText ||
              previous.response.state != current.response.state ||
              previous.stopPrice != current.stopPrice ||
              previous.quantity != current.quantity,
          builder: (context, state) => OrderConfirmationButton<StopOrderState>(
            dynamicState: state,
            errorText: orderState.transactionType == TransactionType.buy
                ? state.buyErrorText
                : state.sellErrorText,
            isLoading: state.response.state == ResponseState.loading,
            disable: state.disabledConfirmButton(orderState.transactionType),
            orderState: context.read<OrderBloc>().state,
            symbolDetail: symbolDetail,
            onConfirmedTap: () => context.read<StopOrderBloc>().add(
                StopOrderSubmitted(OrderRequest.stop(
                    symbolType: symbolDetail.symbolType.name,
                    symbol: symbolDetail.name,
                    side: orderState.transactionType.name,
                    quantity: state.quantity.toString(),
                    stopPrice: state.stopPrice.toString()))),
          ),
        )
      ],
    );
  }
}
