import 'package:flutter/material.dart';

class ScalableMediaQuery {
  ScalableMediaQuery._internal();

  static final ScalableMediaQuery _singleton = ScalableMediaQuery._internal();

  factory ScalableMediaQuery() => _singleton;

  static ScalableMediaQuery get instance => _singleton;

  static double screenHeight = 0;
  static double screenWidth = 0;

  double get getScreenHeight {
    return screenHeight;
  }

  set setScreenHeight(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
  }

  double get getScreenWidth {
    return screenWidth;
  }

  set setScreenWidth(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
  }

  double scaledHeight(double sizes) {
    return screenHeight * (sizes / 100);
  }

  double scaledWidth(double sizes) {
    return screenWidth * (sizes / 100);
  }
}
