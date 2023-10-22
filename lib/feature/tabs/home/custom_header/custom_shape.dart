import 'package:flutter/material.dart';

class CustomShape extends ShapeBorder {
  final double shrinkOffset;

  const CustomShape(this.shrinkOffset);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    double scrollOffset = 0.0;
    if (shrinkOffset <= 50) {
      scrollOffset = 50.00 - shrinkOffset;
    }

    Offset controlPoint1 = Offset(0, rect.size.height - scrollOffset);
    Offset endPoint1 = Offset(scrollOffset, rect.size.height - scrollOffset);
    Offset controlPoint2 =
        Offset(rect.size.width, rect.size.height - scrollOffset);
    Offset endPoint2 = Offset(rect.size.width, rect.size.height);

    return Path()
      ..lineTo(0, rect.size.height)
      ..quadraticBezierTo(
          controlPoint1.dx, controlPoint1.dy, endPoint1.dx, endPoint1.dy)
      ..lineTo(rect.size.width - scrollOffset, rect.size.height - scrollOffset)
      ..quadraticBezierTo(
          controlPoint2.dx, controlPoint2.dy, endPoint2.dx, endPoint2.dy)
      ..lineTo(rect.size.width, 0);
  }

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.only(bottom: 0);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }
}
