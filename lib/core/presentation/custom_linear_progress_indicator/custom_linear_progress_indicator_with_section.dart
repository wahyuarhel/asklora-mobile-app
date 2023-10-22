import 'package:flutter/material.dart';

import 'custom_linear_progress_indicator.dart';

class CustomLinearProgressIndicatorWithSection extends StatelessWidget {
  final double progress;
  final int sectionCount;

  const CustomLinearProgressIndicatorWithSection(
      {required this.progress, required this.sectionCount, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomLinearProgressIndicator(
          progress: progress,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _getIntersectContainer),
      ],
    );
  }

  List<Widget> get _getIntersectContainer {
    List<Widget> children = [];
    for (int i = 1; i < sectionCount; i++) {
      children.add(
        Container(
          height: 2,
          width: 4,
          color: Colors.white,
        ),
      );
    }
    return children;
  }
}
