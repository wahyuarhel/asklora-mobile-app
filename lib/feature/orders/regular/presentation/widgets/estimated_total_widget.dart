part of '../order_screen.dart';

class EstimatedTotalWidget extends StatelessWidget {
  final FontType fontType;
  final String value;

  const EstimatedTotalWidget(
      {this.value = '',
      this.fontType = FontType.smallText,
      Key key = const Key('estimated_total_widget')})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomExpandedRow(
      'Estimated Total',
      text: '\$$value',
      fontType: fontType,
    );
  }
}
