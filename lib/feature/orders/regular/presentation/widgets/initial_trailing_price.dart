import 'package:flutter/material.dart';

import '../../../../../core/presentation/custom_expanded_row.dart';
import '../../../../../core/presentation/custom_text.dart';

class InitialTrailingPrice extends StatelessWidget {
  final FontType fontType;
  final String value;

  const InitialTrailingPrice(
      {this.value = '',
      this.fontType = FontType.smallText,
      Key key = const Key('initial_trailing_price_widget')})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomExpandedRow(
      'Initial trailing price',
      text: '\$$value',
      fontType: fontType,
    );
  }
}
