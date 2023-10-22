import 'package:flutter/material.dart';

import '../../../../../../core/presentation/custom_text_new.dart';
import '../../../../../../core/styles/asklora_colors.dart';
import '../../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../../core/utils/app_icons.dart';

part 'custom_step.dart';

class CustomStepper extends StatelessWidget {
  final int currentStep;
  final List<String> steps;

  const CustomStepper({this.currentStep = 0, required this.steps, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: steps
            .asMap()
            .entries
            .map((element) => CustomStep(
                  svgAssetName: _getSvgAssetName(element.key, currentStep),
                  label: element.value,
                  drawLine: element.key != steps.length - 1,
                ))
            .toList(),
      );

  String _getSvgAssetName(int index, int currentStep) {
    if (index + 1 < currentStep) {
      return 'passed_step_icon';
    } else if (index + 1 == currentStep) {
      return 'active_step_icon';
    } else {
      return 'inactive_step_icon';
    }
  }
}
