import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/base_response.dart';
import '../../../../core/presentation/custom_expanded_row.dart';
import '../../../../core/presentation/custom_text.dart';
import '../../../../core/presentation/custom_text_input.dart';
import '../../bloc/market/market_bloc.dart';
import '../../bloc/order_bloc.dart';
import '../../domain/order_request.dart';
import '../../domain/symbol_detail.dart';
import 'order_screen.dart';
import 'widgets/shares_stock_widget.dart';

class MarketOrderWidget extends StatelessWidget {
  final SymbolDetail symbolDetail;
  final OrderState orderState;

  const MarketOrderWidget(
      {required this.orderState, required this.symbolDetail, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              _amountAndSharesStockButton,
              _spaceHeight,
              _inputMarket,
              _spaceHeight,
              MarketPriceWidget(symbolDetail: symbolDetail),
              BlocBuilder<MarketBloc, MarketState>(
                  buildWhen: (previous, current) =>
                      previous.sharesAmount != current.sharesAmount,
                  builder: (context, state) => CustomExpandedRow(
                      'Number of shares',
                      text: state.sharesAmount.toString(),
                      fontType: FontType.smallText)),
              BlocBuilder<MarketBloc, MarketState>(
                  buildWhen: (previous, current) =>
                      previous.estimateTotal != current.estimateTotal,
                  builder: (context, state) => EstimatedTotalWidget(
                      value: state.estimateTotal.toString(),
                      fontType: FontType.smallText)),
              _spaceHeight,
              _spaceHeight,
              if (orderState.transactionType == TransactionType.buy) ...[
                BlocBuilder<MarketBloc, MarketState>(
                    buildWhen: (previous, current) =>
                        previous.availableBuyingPower !=
                        current.availableBuyingPower,
                    builder: (context, state) => AvailableBuyingPowerWidget(
                        value: state.availableBuyingPower.toString())),
                BlocBuilder<MarketBloc, MarketState>(
                    buildWhen: (previous, current) =>
                        previous.numberOfBuyableShares !=
                        current.numberOfBuyableShares,
                    builder: (context, state) => NumberOfBuyableSharesWidget(
                        value: state.numberOfBuyableShares.toString())),
              ] else if (orderState.transactionType ==
                  TransactionType.sell) ...[
                BlocBuilder<MarketBloc, MarketState>(
                    buildWhen: (previous, current) =>
                        previous.availableAmountToSell !=
                        current.availableAmountToSell,
                    builder: (context, state) => AvailableAmountToSellWidget(
                        value: state.availableAmountToSell.toString())),
                BlocBuilder<MarketBloc, MarketState>(
                    buildWhen: (previous, current) =>
                        previous.numberOfSellableShares !=
                        current.numberOfSellableShares,
                    builder: (context, state) => NumberOfSellableSharesWidget(
                        value: state.numberOfSellableShares.toString()))
              ],
            ],
          ),
        ),
        BlocBuilder<MarketBloc, MarketState>(
            buildWhen: (previous, current) =>
                orderState.transactionType == TransactionType.buy &&
                    previous.buyErrorText != current.buyErrorText ||
                orderState.transactionType == TransactionType.sell &&
                    previous.sellErrorText != current.sellErrorText ||
                previous.response.state != current.response.state ||
                previous.amount != current.amount,
            builder: (context, state) => OrderConfirmationButton<MarketState>(
                dynamicState: state,
                errorText: orderState.transactionType == TransactionType.buy
                    ? state.buyErrorText
                    : state.sellErrorText,
                isLoading: state.response.state == ResponseState.loading,
                disable: state.buyErrorText.isNotEmpty || state.amount == 0
                    ? true
                    : false,
                orderState: orderState,
                symbolDetail: symbolDetail,
                onConfirmedTap: () => context.read<MarketBloc>().add(
                      OrderSubmitted(_orderRequest(state)),
                    )))
      ],
    );
  }

  OrderRequest _orderRequest(MarketState marketState) {
    switch (orderState.marketType) {
      case MarketType.amount:
        return OrderRequest.marketAmount(
            symbolType: symbolDetail.symbolType.name,
            symbol: symbolDetail.name,
            side: orderState.transactionType.name,
            amount: marketState.amount.toString());
      case MarketType.shares:
        return OrderRequest.marketShares(
            symbolType: symbolDetail.symbolType.name,
            symbol: symbolDetail.name,
            side: orderState.transactionType.name,
            qty: marketState.sharesAmount.toString());
    }
  }

  Widget get _amountAndSharesStockButton {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: BlocBuilder<OrderBloc, OrderState>(
              buildWhen: (previous, current) =>
                  previous.marketType != current.marketType,
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    context
                        .read<OrderBloc>()
                        .add(const MarketTypeChanged(MarketType.amount));
                    context.read<MarketBloc>().add(const ResetMarketValue());
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: state.marketType == MarketType.amount
                          ? Colors.blue
                          : Colors.white,
                      foregroundColor: state.marketType == MarketType.amount
                          ? Colors.white
                          : Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      minimumSize: const Size.fromHeight(40)),
                  child: const Text('Amount'),
                );
              },
            )),
        const SizedBox(width: 20),
        Expanded(
            flex: 1,
            child: BlocBuilder<OrderBloc, OrderState>(
              buildWhen: (previous, current) =>
                  previous.marketType != current.marketType,
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    context
                        .read<OrderBloc>()
                        .add(const MarketTypeChanged(MarketType.shares));
                    context.read<MarketBloc>().add(const ResetMarketValue());
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: state.marketType == MarketType.shares
                          ? Colors.blue
                          : Colors.white,
                      foregroundColor: state.marketType == MarketType.shares
                          ? Colors.white
                          : Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      minimumSize: const Size.fromHeight(40)),
                  child: const Text('Shares'),
                );
              },
            ))
      ],
    );
  }

  Widget get _inputMarket {
    return BlocBuilder<OrderBloc, OrderState>(
      key: const Key('input_market'),
      buildWhen: (previous, current) =>
          previous.marketType != current.marketType,
      builder: (context, state) {
        return state.marketType == MarketType.amount
            ? _amountForm(context)
            : const SharesStockWidget();
      },
    );
  }

  Widget _amountForm(BuildContext context) => CustomTextInput(
      textInputType: TextInputType.number,
      textInputFormatterList: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      labelText: 'Amount',
      onChanged: (value) => context
          .read<MarketBloc>()
          .add(AmountChanged(value.isNotEmpty ? double.parse(value) : 0)));

  Widget get _spaceHeight => const SizedBox(height: 15);
}
