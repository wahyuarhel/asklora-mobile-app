import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/custom_expanded_row.dart';
import '../../../../core/presentation/custom_text.dart';
import '../../../../core/presentation/custom_text_button.dart';
import '../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../core/presentation/navigation/custom_navigation_widget.dart';
import '../../../tabs/presentation/tab_screen.dart';
import '../../bloc/order_bloc.dart';
import '../../domain/symbol_detail.dart';

class OrderSubmittedScreen extends StatelessWidget {
  final TransactionType transactionType;
  final OrderType orderType;
  final SymbolDetail symbolDetail;

  const OrderSubmittedScreen({
    Key? key,
    required this.transactionType,
    required this.orderType,
    required this.symbolDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomNavigationWidget<OrderPageStep>(
      header: const SizedBox(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: ListView(
                physics: const ScrollPhysics(),
                children: [
                  const CustomText(
                    'Order Success!',
                    type: FontType.h2,
                    textAlign: TextAlign.center,
                    padding: EdgeInsets.only(top: 10),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Icon(
                      Icons.check_circle,
                      size: 100,
                      color: Colors.green,
                    ),
                  ),
                  CustomText(
                    'Your order of ${symbolDetail.name}\nbeen processed',
                    textAlign: TextAlign.center,
                    padding: const EdgeInsets.only(bottom: 20),
                  ),
                  _orderDetailCard,
                ],
              ),
            ),
            _backToDashboardButton(context),
            _viewOrderDetailButton(context),
          ],
        ),
      ),
    );
  }

  Widget get _orderDetailCard {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade300,
      ),
      child: Column(
        children: [
          CustomExpandedRow(
            'Direction',
            key: const Key('direction_value_expanded_row'),
            text: transactionType.name,
            padding: const EdgeInsets.only(bottom: 15),
          ),
          CustomExpandedRow(
            'Order Type',
            key: const Key('order_type_value_expanded_row'),
            text: orderType.name,
            padding: const EdgeInsets.only(bottom: 15),
          ),
          const CustomExpandedRow(
            'Quantity',
            key: Key('quantity_value_expanded_row'),
            text: '0.80',
            padding: EdgeInsets.only(bottom: 15),
          ),
          const CustomExpandedRow('Amount',
              key: Key('amount_value_expanded_row'), text: r'$80.00'),
        ],
      ),
    );
  }

  Widget _viewOrderDetailButton(BuildContext context) {
    return CustomTextButton(
        key: const Key('view_order_detail_submitted_button'),
        borderRadius: 5,
        buttonText: 'View my order',
        onClick: () => context
            .read<NavigationBloc<OrderPageStep>>()
            .add(const PageChanged(OrderPageStep.orderDetails)));
  }

  Widget _backToDashboardButton(BuildContext context) {
    return CustomTextButton(
        key: const Key('back_to_dashboard_button'),
        padding: const EdgeInsets.only(bottom: 15),
        borderRadius: 5,
        buttonText: 'Back to Dashboard',
        onClick: () => TabScreen.openAndRemoveAllRoute(context));
  }
}
