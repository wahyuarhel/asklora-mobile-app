import 'package:flutter/material.dart';

import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../core/utils/app_icons.dart';
import '../../generated/l10n.dart';
import 'lora_bottom_sheet.dart';

class CustomTextWithBottomSheet extends StatelessWidget {
  final String title;
  final String bottomSheetText;
  final TextStyle? titleStyle;
  final String? bottomSheetButtonLabel;

  const CustomTextWithBottomSheet(
      {required this.title,
      required this.bottomSheetText,
      this.titleStyle,
      this.bottomSheetButtonLabel,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: CustomTextNew(
            title,
            style: titleStyle ??
                AskLoraTextStyles.body4.copyWith(color: AskLoraColors.charcoal),
          ),
        ),
        GestureDetector(
          onTap: () => LoraBottomSheet.show(
            context: context,
            title: title,
            titleStyle:
                AskLoraTextStyles.h5.copyWith(color: AskLoraColors.charcoal),
            subTitle: bottomSheetText,
            subTitleStyle:
                AskLoraTextStyles.body3.copyWith(color: AskLoraColors.charcoal),
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
    );
  }
}
