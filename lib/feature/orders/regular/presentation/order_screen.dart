import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/base_response.dart';
import '../../../../core/presentation/custom_expanded_row.dart';
import '../../../../core/presentation/custom_text.dart';
import '../../../../core/presentation/custom_text_button.dart';
import '../../../../core/presentation/custom_text_input.dart';
import '../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../core/presentation/navigation/custom_navigation_widget.dart';
import '../../bloc/limit/limit_order_bloc.dart';
import '../../bloc/order_bloc.dart';
import '../../bloc/stop/stop_order_bloc.dart';
import '../../bloc/stop_limit/stop_limit_order_bloc.dart';
import '../../bloc/trailing/trailing_order_bloc.dart';
import '../../domain/order_request.dart';
import '../../domain/symbol_detail.dart';
import '../../repository/orders_repository.dart';
import 'market_order_widget.dart';
import 'widgets/custom_bottom_sheet_card_widget.dart';
import 'widgets/initial_trailing_price.dart';
import 'widgets/order_bottom_sheet_widget.dart';

part 'limit_order_widget.dart';
part 'order_confirmation_widget.dart';
part 'stop_limit_order_widget.dart';
part 'stop_order_widget.dart';
part 'trailing_stop_order_widget.dart';
part 'widgets/available_amount_to_sell_widget.dart';
part 'widgets/available_buying_power_widget.dart';
part 'widgets/estimated_total_widget.dart';
part 'widgets/market_price_widget.dart';
part 'widgets/number_of_buyable_shares_widget.dart';
part 'widgets/number_of_sellable_shares_widget.dart';
part 'widgets/order_confirmation_button.dart';
part 'widgets/order_fees_widget.dart';
part 'widgets/order_type_price_widget.dart';
part 'widgets/order_type_widget.dart';
part 'widgets/shares_quantity_widget.dart';
part 'widgets/symbol_title_widget.dart';
part 'widgets/time_in_force_widget.dart';
part 'widgets/trading_hours_widget.dart';
part 'widgets/trail_type_widget.dart';

class OrderScreen extends StatelessWidget {
  final OrderState orderState;
  final SymbolDetail symbolDetail;
  final double availableBuyingPower;

  const OrderScreen({
    required this.orderState,
    required this.symbolDetail,
    Key? key,
    required this.availableBuyingPower,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomNavigationWidget<OrderPageStep>(
      child: Column(
        children: [
          _dropDownOrderType,
          _spaceHeight,
          SymbolTitleWidget(symbolDetail: symbolDetail),
          _spaceHeight,
          _contents,
        ],
      ),
    );
  }

  Widget get _contents {
    return Expanded(
      child: BlocBuilder<OrderBloc, OrderState>(
        buildWhen: (previous, current) =>
            previous.orderType != current.orderType,
        key: const Key('order_contents'),
        builder: (context, state) {
          switch (state.orderType) {
            case OrderType.limit:
              return BlocProvider(
                  create: (_) => LimitOrderBloc(
                      marketPrice: symbolDetail.marketPrice,
                      availableBuyingPower: availableBuyingPower,
                      ordersRepository: OrdersRepository(),
                      numberOfSellableShares: 20),
                  child: LimitOrderWidget(
                      orderState: state, symbolDetail: symbolDetail));
            case OrderType.market:
              return MarketOrderWidget(
                  orderState: orderState, symbolDetail: symbolDetail);
            case OrderType.stop:
              return BlocProvider(
                create: (context) => StopOrderBloc(
                    marketPrice: symbolDetail.marketPrice,
                    availableBuyingPower: availableBuyingPower,
                    ordersRepository: OrdersRepository(),
                    numberOfSellableShares: 20),
                child: StopOrderWidget(
                    orderState: orderState, symbolDetail: symbolDetail),
              );
            case OrderType.stopLimit:
              return BlocProvider(
                create: (context) => StopLimitOrderBloc(
                  marketPrice: symbolDetail.marketPrice,
                  availableBuyingPower: availableBuyingPower,
                  ordersRepository: OrdersRepository(),
                  numberOfSellableShares: 20,
                ),
                child: StopLimitOrderWidget(
                    orderState: orderState, symbolDetail: symbolDetail),
              );
            case OrderType.trailingStop:
              return BlocProvider(
                create: (context) => TrailingOrderBloc(
                  marketPrice: symbolDetail.marketPrice,
                  availableBuyingPower: availableBuyingPower,
                  ordersRepository: OrdersRepository(),
                  numberOfSellableShares: 20,
                ),
                child: TrailingStopOrderWidget(
                    orderState: orderState, symbolDetail: symbolDetail),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget get _spaceHeight => const SizedBox(height: 15);

  Widget get _dropDownOrderType => BlocBuilder<OrderBloc, OrderState>(
      key: const Key('dropdown_order_type'),
      buildWhen: (previous, current) => previous.orderType != current.orderType,
      builder: (context, state) => Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
              label: Text(state.orderType.name),
              icon: const Icon(Icons.arrow_drop_down),
              onPressed: () {
                context
                    .read<NavigationBloc<OrderPageStep>>()
                    .add(const PageChanged(OrderPageStep.orderType));
              })));
}
