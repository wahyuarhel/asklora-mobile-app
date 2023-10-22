import 'package:flutter/material.dart';

import 'custom_animated_opacity.dart';

class AnimatedLinePointer extends StatelessWidget {
  final Color color;
  final double height;

  const AnimatedLinePointer(
      {required this.height, required this.color, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedOpacity(
        animationDuration: const Duration(milliseconds: 300),
        delayDuration: const Duration(milliseconds: 500),
        child: Column(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            Container(
              width: 1.6,
              color: color,
              height: height,
            ),
          ],
        ));
  }
}
