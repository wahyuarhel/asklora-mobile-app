import 'package:flutter/material.dart';

import '../../../core/presentation/custom_text_new.dart';
import '../../../core/styles/asklora_colors.dart';
import '../../../core/styles/asklora_text_styles.dart';

class MenuButtonWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool showBottomBorder;

  const MenuButtonWidget({
    Key? key,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.showBottomBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 23.5),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border(
                bottom: showBottomBorder
                    ? const BorderSide(color: AskLoraColors.gray, width: 0.5)
                    : BorderSide.none)),
        child: Row(
          children: [
            Expanded(
                child: CustomTextNew(
              title,
              style: AskLoraTextStyles.subtitle2
                  .copyWith(color: AskLoraColors.charcoal),
            )),
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: CustomTextNew(
                  subtitle!,
                  style: AskLoraTextStyles.body2
                      .copyWith(color: AskLoraColors.darkGray),
                ),
              ),
            const SizedBox(
              width: 12,
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AskLoraColors.gray,
              size: 14,
            )
          ],
        ),
      ),
    );
  }
}
