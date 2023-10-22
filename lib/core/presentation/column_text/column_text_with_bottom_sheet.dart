import 'package:flutter/material.dart';

import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../generated/l10n.dart';
import '../lora_bottom_sheet.dart';

class ColumnTextWithBottomSheet extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color? subTitleColor;
  final String bottomSheetText;
  final CrossAxisAlignment crossAxisAlignment;
  final String? bottomSheetButtonLabel;

  const ColumnTextWithBottomSheet(
      {required this.title,
      required this.subTitle,
      required this.bottomSheetText,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.subTitleColor,
      this.bottomSheetButtonLabel,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: CustomTextNew(
                title,
                style: AskLoraTextStyles.body4
                    .copyWith(color: AskLoraColors.charcoal),
              ),
            ),
            GestureDetector(
              onTap: () => LoraBottomSheet.show(
                context: context,
                title: title,
                titleStyle: AskLoraTextStyles.h5
                    .copyWith(color: AskLoraColors.charcoal),
                subTitle: bottomSheetText,
                subTitleStyle: AskLoraTextStyles.body3
                    .copyWith(color: AskLoraColors.charcoal),
                primaryButtonLabel:
                    bottomSheetButtonLabel ?? S.of(context).buttonBack,
                onPrimaryButtonTap: () => Navigator.pop(context),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: getSvgIcon('icon_info'),
              ),
            )
          ],
        ),
        CustomTextNew(subTitle,
            style: AskLoraTextStyles.subtitle2
                .copyWith(color: subTitleColor ?? AskLoraColors.charcoal)),
        const SizedBox(
          height: 1,
        ),
      ],
    );
  }
}
