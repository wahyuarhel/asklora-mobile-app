import 'package:flutter/material.dart';

import '../../../../../core/presentation/custom_text.dart';

class OrderBottomSheetWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final EdgeInsets padding;
  final FontType titleFontType;

  const OrderBottomSheetWidget(
      {required this.title,
      required this.children,
      this.titleFontType = FontType.h5,
      this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      Key key = const Key('order_bottom_sheet_widget')})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: padding,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                          key: const Key('order_bottom_sheet_close_button'),
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.close,
                            size: 32,
                          ))),
                  Align(
                    key: const Key('order_bottom_sheet_title'),
                    alignment: Alignment.center,
                    child: CustomText(
                      title,
                      type: titleFontType,
                      padding: const EdgeInsets.only(bottom: 12, top: 4),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              ...children
            ],
          ),
        ),
      ),
    );
  }
}
