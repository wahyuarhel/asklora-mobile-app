import 'package:flutter/material.dart';

class TriangleChatBubblePainter extends CustomPainter {
  final Color backgroundColor;

  TriangleChatBubblePainter(this.backgroundColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = backgroundColor;

    var path = Path();
    path.lineTo(-5, 0);
    path.lineTo(0, 10);
    // path.lineTo(5, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
