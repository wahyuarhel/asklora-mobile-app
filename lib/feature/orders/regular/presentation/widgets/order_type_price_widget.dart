part of '../order_screen.dart';

class OrderTypePriceWidget extends StatelessWidget {
  final String prefixTitle;
  final String? value;
  final bool showOnlyInformation;
  final Function(String)? onChanged;

  const OrderTypePriceWidget(
      {this.showOnlyInformation = false,
      this.onChanged,
      this.prefixTitle = '',
      this.value = '',
      Key? key})
      : super(key: key);

  static OrderTypePriceWidget input(
      {required String prefixTitle, required Function(String) onChanged}) {
    return OrderTypePriceWidget(
      prefixTitle: prefixTitle,
      onChanged: onChanged,
      showOnlyInformation: false,
    );
  }

  static OrderTypePriceWidget info(
      {required String prefixTitle, required String value}) {
    return OrderTypePriceWidget(
        prefixTitle: prefixTitle, value: value, showOnlyInformation: true);
  }

  @override
  Widget build(BuildContext context) {
    return CustomExpandedRow(
      '$prefixTitle Price',
      text: '\$$value',
      child: showOnlyInformation
          ? null
          : CustomTextInput(
              textInputType: TextInputType.number,
              textInputFormatterList: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              labelText: prefixTitle,
              onChanged: onChanged ?? (_) {},
            ),
    );
  }
}
