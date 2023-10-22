import 'package:flutter/material.dart';

enum DashedType { longDash, shortDash }

class DashedLineHorizontalPainter extends CustomPainter {
  late final Paint _paint;
  final Color color;
  final double width;
  final DashedType dashedType;
  DashedLineHorizontalPainter(
      {required this.width,
      required this.color,
      this.dashedType = DashedType.shortDash}) {
    _paint = Paint();
    _paint.color = color;
    _paint.strokeWidth = 1;
    _paint.strokeCap = StrokeCap.square;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (double i = 3;
        i < width;
        i = i + (dashedType == DashedType.shortDash ? 6 : 12)) {
      if (i % 3 == 0) {
        canvas.drawLine(
            Offset(i, 0.0),
            Offset(i + (dashedType == DashedType.shortDash ? 2 : 6), 0.0),
            _paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
