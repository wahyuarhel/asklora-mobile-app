part of '../home_screen_form.dart';

class HomeScreenPopUpMessageWidget extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final String subTitle;
  final String buttonLabel;
  final String? secondaryButtonLabel;
  final VoidCallback onPrimaryButtonTap;
  final VoidCallback? onSecondaryButtonTap;
  final String? pngImage;
  final double boxTopMargin;

  const HomeScreenPopUpMessageWidget(
      {required this.title,
      required this.subTitle,
      required this.backgroundColor,
      required this.buttonLabel,
      this.secondaryButtonLabel,
      required this.onPrimaryButtonTap,
      this.onSecondaryButtonTap,
      this.pngImage,
      this.boxTopMargin = 70,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScreenHorizontalPaddingWidget(
      child: LoraPopUpMessage(
        backgroundColor: backgroundColor,
        title: title,
        subTitle: subTitle,
        primaryButtonLabel: buttonLabel,
        secondaryButtonLabel: secondaryButtonLabel,
        onPrimaryButtonTap: onPrimaryButtonTap,
        onSecondaryButtonTap: onSecondaryButtonTap,
        pngImage: pngImage,
        boxTopMargin: boxTopMargin,
      ),
    );
  }
}
