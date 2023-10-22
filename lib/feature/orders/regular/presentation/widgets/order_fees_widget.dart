part of '../order_screen.dart';

class OrderFeesWidget extends StatelessWidget {
  final String value;

  const OrderFeesWidget(
      {this.value = '', Key key = const Key('order_fees_widget')})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomExpandedRow(
      'Fees',
      text: '\$$value',
    );
  }
}
