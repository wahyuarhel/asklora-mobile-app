import 'package:flutter/material.dart';

import 'column_text_with_auto_sized_text.dart';

class PairColumnTextWithAutoSizedText extends StatelessWidget {
  final String leftTitle;
  final String leftSubTitle;
  final String rightTitle;
  final String rightSubTitle;
  final double? spaceWidth;
  final int? maxLines;

  const PairColumnTextWithAutoSizedText(
      {required this.leftTitle,
      required this.rightTitle,
      required this.leftSubTitle,
      required this.rightSubTitle,
      this.spaceWidth = 10,
      this.maxLines,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ColumnTextWithAutoSizedText(
            title: leftTitle,
            subTitle: leftSubTitle,
            maxLines: maxLines,
          ),
        ),
        if (spaceWidth != null)
          SizedBox(
            width: spaceWidth,
          ),
        Expanded(
          child: ColumnTextWithAutoSizedText(
            title: rightTitle,
            subTitle: rightSubTitle,
            maxLines: maxLines,
          ),
        ),
      ],
    );
  }
}
