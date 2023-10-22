import 'package:flutter/material.dart';

import '../../styles/asklora_colors.dart';
import '../../styles/asklora_text_styles.dart';
import '../../utils/app_icons.dart';
import '../buttons/primary_button.dart';
import '../custom_text_new.dart';
import '../we_create/custom_text_button.dart';

class LoraPopUpMessage extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final String? subTitle;
  final String? primaryButtonLabel;
  final String? secondaryButtonLabel;
  final Color? secondaryButtonColor;
  final Color titleColor;
  final Color subTitleColor;
  final ButtonPrimaryType buttonPrimaryType;
  final VoidCallback? onPrimaryButtonTap;
  final VoidCallback? onSecondaryButtonTap;
  final String? pngImage;
  final double boxTopMargin;
  final String? bottomText;
  final Widget? content;
  final TextStyle? titleTextStyle;
  final double spaceAfterTitle;
  final EdgeInsets padding;

  const LoraPopUpMessage(
      {required this.title,
      this.titleTextStyle,
      this.subTitle,
      this.titleColor = AskLoraColors.charcoal,
      this.subTitleColor = AskLoraColors.charcoal,
      this.buttonPrimaryType = ButtonPrimaryType.solidCharcoal,
      this.primaryButtonLabel,
      this.secondaryButtonLabel,
      this.secondaryButtonColor,
      this.backgroundColor = AskLoraColors.white,
      this.onPrimaryButtonTap,
      this.onSecondaryButtonTap,
      this.boxTopMargin = 70,
      this.pngImage,
      this.content,
      this.bottomText,
      this.spaceAfterTitle = 25,
      this.padding =
          const EdgeInsets.only(left: 24, right: 24, top: 64, bottom: 32),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: UnconstrainedBox(
        constrainedAxis: Axis.horizontal,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: padding,
                margin: EdgeInsets.only(top: boxTopMargin),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    CustomTextNew(
                      title,
                      style: titleTextStyle ??
                          AskLoraTextStyles.h4.copyWith(color: titleColor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: spaceAfterTitle,
                    ),
                    if (subTitle != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25.0),
                        child: CustomTextNew(
                          subTitle!,
                          style: AskLoraTextStyles.body2
                              .copyWith(color: subTitleColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (content != null) content!,
                    if (primaryButtonLabel != null)
                      PrimaryButton(
                          buttonPrimaryType: buttonPrimaryType,
                          label: primaryButtonLabel!,
                          onTap: () {
                            if (onPrimaryButtonTap != null) {
                              onPrimaryButtonTap!();
                            }
                          }),
                    if (secondaryButtonLabel != null)
                      CustomTextButton(
                        key: const Key('kyc_secondary_button'),
                        margin: const EdgeInsets.only(top: 24),
                        label: secondaryButtonLabel!,
                        color: secondaryButtonColor,
                        onTap: onSecondaryButtonTap ?? () {},
                      ),
                    if (bottomText != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: CustomTextNew(
                          bottomText!,
                          style: AskLoraTextStyles.body3
                              .copyWith(color: subTitleColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (pngImage != null)
              Align(
                  alignment: Alignment.topCenter,
                  child: getPngImage(pngImage!)),
          ],
        ),
      ),
    );
  }
}
