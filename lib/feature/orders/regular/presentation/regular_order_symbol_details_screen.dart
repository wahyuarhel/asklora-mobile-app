import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/custom_text_button.dart';
import '../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../core/presentation/navigation/custom_navigation_widget.dart';
import '../../bloc/order_bloc.dart';
import '../../widgets/symbol_details_widget.dart';

class RegularOrderSymbolDetailsScreen extends StatelessWidget {
  const RegularOrderSymbolDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomNavigationWidget<OrderPageStep>(
        child: Column(children: [
      const SymbolDetailsWidget(),
      Expanded(
        //TODO: Add others widgets like graph and financials here.
        child: Container(),
      ),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: CustomTextButton(
                    buttonText: 'BUY',
                    onClick: () {
                      context.read<OrderBloc>().add(
                          const TransactionTypeChanged(TransactionType.buy));
                      context
                          .read<NavigationBloc<OrderPageStep>>()
                          .add(const PageChanged(OrderPageStep.order));
                    })),
            const SizedBox(width: 10),
            Expanded(
                flex: 1,
                child: CustomTextButton(
                    buttonText: 'SELL',
                    onClick: () {
                      context.read<OrderBloc>().add(
                          const TransactionTypeChanged(TransactionType.sell));
                      context
                          .read<NavigationBloc<OrderPageStep>>()
                          .add(const PageChanged(OrderPageStep.order));
                    }))
          ]),
    ]));
  }
}
