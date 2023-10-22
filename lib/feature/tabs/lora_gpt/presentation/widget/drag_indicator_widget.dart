import 'package:flutter/material.dart';

import '../../../../../core/styles/asklora_colors.dart';

class DragIndicatorWidget extends StatelessWidget {
  const DragIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(top: 20, bottom: 6),
        width: 80,
        height: 10,
        decoration: BoxDecoration(
          color: AskLoraColors.lightGray,
          borderRadius: BorderRadius.circular(20),
        ),
      );
}
