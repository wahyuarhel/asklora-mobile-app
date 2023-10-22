part of 'order_screen.dart';

class StopLimitOrderWidget extends StatelessWidget {
  final OrderState orderState;
  final SymbolDetail symbolDetail;

  const StopLimitOrderWidget(
      {required this.orderState, required this.symbolDetail, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              _stopPriceInput(context),
              _limitPriceInput(context),
              _quantityInput(context),
              const TimeInForceWidget(),
              const SizedBox(
                height: 40,
              ),
              MarketPriceWidget(symbolDetail: symbolDetail),
              _estimatedTotal,
              _availablePower
            ],
          ),
        ),
        _submitButton
      ],
    );
  }

  Widget _stopPriceInput(BuildContext context) => OrderTypePriceWidget.input(
        prefixTitle: 'Stop',
        onChanged: (value) => context.read<StopLimitOrderBloc>().add(
            StopPriceOfStopLimitOrderChanged(
                value.isNotEmpty ? double.parse(value) : 0)),
      );

  Widget _limitPriceInput(BuildContext context) => OrderTypePriceWidget.input(
        prefixTitle: 'Limit',
        onChanged: (value) => context.read<StopLimitOrderBloc>().add(
            LimitPriceOfStopLimitOrderChanged(
                value.isNotEmpty ? double.parse(value) : 0)),
      );

  Widget _quantityInput(BuildContext context) => SharesQuantityWidget.input(
        onChanged: (value) => context.read<StopLimitOrderBloc>().add(
            QuantityOfStopLimitOrderChanged(
                value.isNotEmpty ? double.parse(value) : 0)),
      );

  Widget get _estimatedTotal {
    return BlocBuilder<StopLimitOrderBloc, StopLimitOrderState>(
      buildWhen: (previous, current) =>
          previous.estimateTotal != current.estimateTotal,
      builder: (context, state) =>
          EstimatedTotalWidget(value: state.estimateTotal.toString()),
    );
  }

  Widget get _availablePower {
    if (orderState.transactionType == TransactionType.buy) {
      return BlocBuilder<StopLimitOrderBloc, StopLimitOrderState>(
          buildWhen: (previous, current) =>
              previous.availableBuyingPower != current.availableBuyingPower,
          builder: (context, state) => AvailableBuyingPowerWidget(
              value: state.availableBuyingPower.toString()));
    } else if (orderState.transactionType == TransactionType.sell) {
      return Column(children: [
        BlocBuilder<StopLimitOrderBloc, StopLimitOrderState>(
          buildWhen: (previous, current) =>
              previous.availableAmountToSell != current.availableAmountToSell,
          builder: (context, state) => AvailableAmountToSellWidget(
              value: state.availableAmountToSell.toString()),
        ),
        BlocBuilder<StopLimitOrderBloc, StopLimitOrderState>(
          buildWhen: (previous, current) =>
              previous.numberOfSellableShares != current.numberOfSellableShares,
          builder: (context, state) {
            return NumberOfSellableSharesWidget(
                value: state.numberOfSellableShares.toString());
          },
        )
      ]);
    } else {
      return const SizedBox();
    }
  }

  Widget get _submitButton {
    return BlocBuilder<StopLimitOrderBloc, StopLimitOrderState>(
      buildWhen: (previous, current) =>
          orderState.transactionType == TransactionType.buy &&
              previous.buyErrorText != current.buyErrorText ||
          orderState.transactionType == TransactionType.sell &&
              previous.sellErrorText != current.sellErrorText ||
          previous.response.state != current.response.state ||
          previous.stopPrice != current.stopPrice ||
          previous.limitPrice != current.limitPrice ||
          previous.quantity != current.quantity,
      builder: (context, state) => OrderConfirmationButton<StopLimitOrderState>(
        dynamicState: state,
        errorText: orderState.transactionType == TransactionType.buy
            ? state.buyErrorText
            : state.sellErrorText,
        isLoading: state.response.state == ResponseState.loading,
        disable: state.disabledConfirmButton(orderState.transactionType),
        orderState: context.read<OrderBloc>().state,
        symbolDetail: symbolDetail,
        onConfirmedTap: () => context.read<StopLimitOrderBloc>().add(
              StopLimitOrderSubmitted(
                OrderRequest.stop(
                  symbolType: symbolDetail.symbolType.name,
                  symbol: symbolDetail.name,
                  side: orderState.transactionType.name,
                  stopPrice: state.stopPrice.toString(),
                  quantity: state.quantity.toString(),
                ),
              ),
            ),
      ),
    );
  }
}
