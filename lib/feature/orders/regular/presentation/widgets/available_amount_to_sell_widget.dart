part of '../order_screen.dart';

class AvailableAmountToSellWidget extends StatelessWidget {
  final String value;

  const AvailableAmountToSellWidget(
      {this.value = '', Key key = const Key('available_amount_to_sell_widget')})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomExpandedRow('Available amount to sell',
        text: value, fontType: FontType.smallText);
  }
}
