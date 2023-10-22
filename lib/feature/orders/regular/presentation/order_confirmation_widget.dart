part of 'order_screen.dart';

class OrderConfirmationWidget<T> extends StatelessWidget {
  final SymbolDetail symbolDetail;
  final OrderState orderState;
  final Function onConfirmedTap;
  final T? dynamicState;

  const OrderConfirmationWidget(
      {this.dynamicState,
      required this.onConfirmedTap,
      required this.orderState,
      required this.symbolDetail,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrderBottomSheetWidget(
        key: const Key('confirmation_bottom_sheet'),
        title: "Let's Review Your Order",
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        titleFontType: FontType.bodyText,
        children: [
          SymbolTitleWidget(symbolDetail: symbolDetail),
          _spaceHeight,
          CustomExpandedRow(
            'Direction',
            text: orderState.transactionType.name,
          ),
          OrderTypeWidget(orderState: orderState),
          ..._additionalWidget,
          _spaceHeight,
          CustomTextButton(
            key: const Key('order_confirmation_button'),
            borderRadius: 5,
            padding: const EdgeInsets.all(10),
            buttonText: 'Confirm',
            onClick: () {
              onConfirmedTap();
              Navigator.pop(context);
            },
          )
        ]);
  }

  Widget get _spaceHeight => const SizedBox(
        height: 20,
      );

  List<Widget> get _additionalWidget {
    switch (orderState.orderType) {
      case OrderType.limit:
        LimitOrderState limitState = dynamicState as LimitOrderState;
        return [
          OrderTypePriceWidget.info(
              prefixTitle: orderState.orderType.name,
              value: limitState.limit.toString()),
          SharesQuantityWidget.info(value: limitState.quantity.toString()),
          if (orderState.transactionType == TransactionType.buy)
            const OrderFeesWidget(value: '1'),
          EstimatedTotalWidget(
            value: limitState.estimateTotal.toString(),
            fontType: FontType.bodyText,
          ),
          _timeInForce,
          _tradingHours,
        ];
      case OrderType.stop:
        return [
          OrderTypePriceWidget.info(
              prefixTitle: orderState.orderType.name, value: '110'),
          SharesQuantityWidget.info(value: '4'),
          if (orderState.transactionType == TransactionType.buy)
            const OrderFeesWidget(value: '1'),
          const EstimatedTotalWidget(
            value: '440',
            fontType: FontType.bodyText,
          ),
          _timeInForce,
        ];
      case OrderType.stopLimit:
        return [
          OrderTypePriceWidget.info(prefixTitle: 'Stop', value: '20'),
          OrderTypePriceWidget.info(prefixTitle: 'Limit', value: '20'),
          SharesQuantityWidget.info(value: '10'),
          if (orderState.transactionType == TransactionType.buy)
            const OrderFeesWidget(value: '1'),
          const EstimatedTotalWidget(
            value: '440',
            fontType: FontType.bodyText,
          ),
          _timeInForce,
        ];
      case OrderType.trailingStop:
        return [
          _trailType,
          SharesQuantityWidget.info(value: '4'),
          if (orderState.transactionType == TransactionType.buy)
            const OrderFeesWidget(value: '1'),
          const EstimatedTotalWidget(
            value: '440',
            fontType: FontType.bodyText,
          ),
          _timeInForce,
        ];
      case OrderType.market:
        return [
          const CustomExpandedRow(
            'Amount',
            text: '\$80',
          ),
          const CustomExpandedRow(
            'Equivalent Quantity',
            text: '0.8',
          ),
          if (orderState.transactionType == TransactionType.buy)
            const OrderFeesWidget(value: '1'),
          const EstimatedTotalWidget(
            value: '440',
            fontType: FontType.bodyText,
          ),
        ];
      default:
        return [];
    }
  }

  Widget get _timeInForce => CustomExpandedRow(
        'Time in Force',
        key: const Key('time_in_force_widget'),
        text: orderState.timeInForce.name,
      );

  Widget get _tradingHours => CustomExpandedRow(
        'Trading Hours',
        key: const Key('trading_hours_widget'),
        text: orderState.tradingHours.name,
      );
  Widget get _trailType => CustomExpandedRow(
        'Trail Type',
        key: const Key('trail_type_widget'),
        text: orderState.trailType.name,
      );
}
