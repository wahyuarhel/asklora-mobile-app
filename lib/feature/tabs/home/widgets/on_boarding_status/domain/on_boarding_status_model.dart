import 'dart:ui';

class OnBoardingStatusModel {
  final String title;
  final String subTitle;
  final VoidCallback onTap;
  final double progress;

  OnBoardingStatusModel(
      {required this.title,
      required this.subTitle,
      required this.onTap,
      required this.progress});
}
