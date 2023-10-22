import 'package:flutter/material.dart';

import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../core/utils/app_icons.dart';

class ColumnTextWithTooltip extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color? subTitleColor;
  final String? tooltipText;
  final CrossAxisAlignment? crossAxisAlignment;

  const ColumnTextWithTooltip(
      {required this.title,
      required this.subTitle,
      this.tooltipText,
      this.crossAxisAlignment,
      this.subTitleColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
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
            if (tooltipText != null)
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Tooltip(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 0.6,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        color: AskLoraColors.white,
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: AskLoraColors.primaryMagenta)),
                    triggerMode: TooltipTriggerMode.tap,
                    showDuration: const Duration(seconds: 10),
                    richMessage: WidgetSpan(
                        alignment: PlaceholderAlignment.baseline,
                        baseline: TextBaseline.alphabetic,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 2 / 3),
                          child: CustomTextNew(tooltipText!,
                              style: AskLoraTextStyles.body3
                                  .copyWith(color: AskLoraColors.charcoal)),
                        )),
                    padding: const EdgeInsets.all(10),
                    child: getSvgIcon('icon_info')),
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
