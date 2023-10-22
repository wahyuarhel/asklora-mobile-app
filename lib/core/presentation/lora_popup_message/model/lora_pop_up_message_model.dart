import 'dart:ui';

class LoraPopUpMessageModel {
  final String title;
  final String subTitle;
  final String? primaryButtonLabel;
  final String? secondaryButtonLabel;
  final VoidCallback? onPrimaryButtonTap;
  final VoidCallback? onSecondaryButtonTap;

  LoraPopUpMessageModel(
      {required this.title,
      required this.subTitle,
      this.primaryButtonLabel,
      this.secondaryButtonLabel,
      this.onPrimaryButtonTap,
      this.onSecondaryButtonTap});
}
