import 'package:flutter/material.dart';

import '../styles/asklora_colors.dart';

class CircularContainer extends StatelessWidget {
  final Color backgroundColor;
  final double? height;
  final double? width;
  final Widget child;
  final EdgeInsets padding;

  const CircularContainer(
      {super.key,
      this.backgroundColor = AskLoraColors.lightGray,
      this.height,
      this.width,
      this.padding = EdgeInsets.zero,
      required this.child});

  @override
  Widget build(BuildContext context) => Container(
        padding: padding,
        height: height,
        width: width,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: backgroundColor),
        child: Align(alignment: Alignment.center, child: child),
      );
}
