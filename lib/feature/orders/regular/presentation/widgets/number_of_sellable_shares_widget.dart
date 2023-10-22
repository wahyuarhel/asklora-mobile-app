part of '../order_screen.dart';

class NumberOfSellableSharesWidget extends StatelessWidget {
  final String value;

  const NumberOfSellableSharesWidget(
      {this.value = '',
      Key key = const Key('number_of_sellable_shares_widget')})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomExpandedRow('Number of shares you can sell',
        text: value, fontType: FontType.smallText);
  }
}
