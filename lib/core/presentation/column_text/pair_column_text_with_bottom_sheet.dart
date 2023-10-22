import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';
import 'column_text.dart';
import 'column_text_with_bottom_sheet.dart';

class PairColumnTextWithBottomSheet extends StatelessWidget {
  final String leftTitle;
  final String leftSubTitle;
  final Color? leftSubTitleColor;
  final String rightTitle;
  final String rightSubTitle;
  final Color? rightSubTitleColor;
  final String? leftBottomSheetText;
  final String? rightBottomSheetText;
  final double? spaceWidth;
  final CrossAxisAlignment columnTextCrossAxisAlignment;
  final String? buttonLabel;

  const PairColumnTextWithBottomSheet(
      {required this.leftTitle,
      required this.rightTitle,
      required this.leftSubTitle,
      required this.rightSubTitle,
      this.leftSubTitleColor,
      this.rightSubTitleColor,
      this.leftBottomSheetText,
      this.rightBottomSheetText,
      this.spaceWidth,
      this.columnTextCrossAxisAlignment = CrossAxisAlignment.start,
      this.buttonLabel,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: leftBottomSheetText != null
              ? ColumnTextWithBottomSheet(
                  subTitleColor: leftSubTitleColor,
                  crossAxisAlignment: columnTextCrossAxisAlignment,
                  title: leftTitle,
                  subTitle: leftSubTitle,
                  bottomSheetText: leftBottomSheetText!,
                  bottomSheetButtonLabel:
                      buttonLabel ?? S.of(context).buttonBack,
                )
              : ColumnText(
                  subTitleColor: leftSubTitleColor,
                  crossAxisAlignment: columnTextCrossAxisAlignment,
                  title: leftTitle,
                  subTitle: leftSubTitle),
        ),
        if (spaceWidth != null)
          SizedBox(
            width: spaceWidth,
          ),
        Expanded(
          child: rightBottomSheetText != null
              ? ColumnTextWithBottomSheet(
                  subTitleColor: rightSubTitleColor,
                  crossAxisAlignment: columnTextCrossAxisAlignment,
                  title: rightTitle,
                  subTitle: rightSubTitle,
                  bottomSheetText: rightBottomSheetText!)
              : ColumnText(
                  subTitleColor: rightSubTitleColor,
                  crossAxisAlignment: columnTextCrossAxisAlignment,
                  title: rightTitle,
                  subTitle: rightSubTitle),
        ),
      ],
    );
  }
}
