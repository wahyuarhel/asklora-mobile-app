import 'package:flutter/material.dart';
import '../../../../../../core/presentation/custom_text_new.dart';
import '../../../../../../core/styles/asklora_colors.dart';
import '../../../../../../core/styles/asklora_text_styles.dart';

class DotText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontHeight;
  final TextStyle? style;

  const DotText(this.text,
      {this.color = AskLoraColors.charcoal,
      this.fontHeight = 1,
      this.style,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 14),
            child: Icon(
              Icons.circle,
              size: 6,
              color: color,
            ),
          ),
          Expanded(
            child: CustomTextNew(
              text,
              style: style ?? AskLoraTextStyles.body1.copyWith(color: color),
            ),
          ),
        ],
      );
}
