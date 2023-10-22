import 'package:flutter/material.dart';

import '../../styles/asklora_colors.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  final double progress;
  final EdgeInsets padding;

  const CustomLinearProgressIndicator(
      {required this.progress, this.padding = EdgeInsets.zero, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: LinearProgressIndicator(
        backgroundColor: AskLoraColors.magentaOpacity50Percent,
        value: progress,
        minHeight: 2,
        color: AskLoraColors.primaryMagenta,
      ),
    );
  }
}
