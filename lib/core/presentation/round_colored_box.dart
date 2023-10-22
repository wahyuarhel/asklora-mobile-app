import 'package:flutter/material.dart';
import 'custom_text_new.dart';
import '../styles/asklora_colors.dart';
import '../styles/asklora_text_styles.dart';

class RoundColoredBox extends StatelessWidget {
  final String? title;
  final Widget content;
  final EdgeInsets padding;
  final Color backgroundColor;
  final double radius;
  final BoxShadow? boxShadow;

  const RoundColoredBox(
      {this.backgroundColor = AskLoraColors.whiteSmoke,
      this.title,
      required this.content,
      this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      this.radius = 20,
      this.boxShadow,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [boxShadow ?? const BoxShadow()]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: CustomTextNew(
                title!,
                style: AskLoraTextStyles.h5,
              ),
            ),
          content
        ],
      ),
    );
  }
}
