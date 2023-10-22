part of '../order_screen.dart';

class SymbolTitleWidget extends StatelessWidget {
  final SymbolDetail symbolDetail;

  const SymbolTitleWidget(
      {required this.symbolDetail, Key? key = const Key('symbol_title_widget')})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          symbolDetail.name,
          type: FontType.h3,
        ),
        const SizedBox(
          width: 10,
        ),
        Image.asset(
          symbolDetail.assetImage,
          height: 60,
        )
      ],
    );
  }
}
