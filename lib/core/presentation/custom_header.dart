import 'package:flutter/material.dart';

import '../styles/asklora_colors.dart';
import '../styles/asklora_text_styles.dart';
import 'custom_text_new.dart';

class CustomHeader extends StatelessWidget {
  final VoidCallback? onTapBack;
  final String title;
  final bool isShowBottomBorder;
  final Widget? body;
  final Color titleColor;

  const CustomHeader(
      {Key? key,
      this.onTapBack,
      required this.title,
      this.isShowBottomBorder = false,
      this.body,
      this.titleColor = AskLoraColors.charcoal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
          border: Border(
              bottom: isShowBottomBorder
                  ? BorderSide(color: AskLoraColors.gray.withOpacity(.5))
                  : BorderSide.none)),
      child: Stack(
        children: [
          if (onTapBack != null)
            Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                    onTap: onTapBack,
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 24,
                    ))),
          Align(
            alignment: Alignment.center,
            child: (body != null)
                ? body
                : CustomTextNew(
                    title,
                    style: AskLoraTextStyles.h5.copyWith(color: titleColor),
                  ),
          )
        ],
      ),
    );
  }
}
