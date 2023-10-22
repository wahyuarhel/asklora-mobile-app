import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppIcons {
  static String barChart = 'assets/icons/bar_chart.png';
  static String stop = 'assets/icons/stop.png';
  static String saveMoney = 'assets/icons/save_money.png';
  static String route = 'assets/icons/route.png';
  static String financial = 'assets/icons/financial.png';
  static String appleLogo = 'assets/icons/apple_logo.png';
}

Widget getSvgIcon(String iconName,
        {Color? color,
        double? height,
        double? width,
        BoxFit fit = BoxFit.contain}) =>
    SvgPicture.asset(
      'assets/icons/$iconName.svg',
      color: color,
      height: height,
      width: width,
      fit: fit,
    );

Image getPngIcon(String iconName,
        {double? height, double? width, BoxFit? fit, Color? color}) =>
    Image.asset(
      color: color,
      'assets/icons/$iconName.png',
      height: height,
      width: width,
      fit: fit,
    );

Image getPngImage(String imageName,
        {double? height, double? width, Color? color}) =>
    Image.asset('assets/images/$imageName.png',
        height: height, width: width, color: color);

Image getAPngImage(String imageName,
        {double? height,
        double? width,
        Color? color,
        BoxFit fit = BoxFit.contain}) =>
    Image.asset(
      'assets/apng/$imageName.png',
      height: height,
      width: width,
      color: color,
      fit: fit,
      filterQuality: FilterQuality.high,
    );

Widget getSvgImage(String assetName,
        {Color? color, double? height, double? width}) =>
    SvgPicture.asset('assets/images/$assetName.svg',
        color: color, height: height, width: width);

void precachePngIcon(String iconName, BuildContext context) {
  precacheImage(getPngIcon(iconName).image, context);
}

void precachePngImage(String imageName, BuildContext context) {
  precacheImage(getPngImage(imageName).image, context);
}
