import 'package:flutter/material.dart';

import '../../../../../core/presentation/buttons/button_pair.dart';
import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../core/values/app_values.dart';
import '../styles/asklora_colors.dart';
import 'buttons/primary_button.dart';

class LoraBottomSheet {
  final BuildContext context;
  final bool disablePrimaryButton;
  final String title;
  final TextStyle? titleStyle;
  final String? subTitle;
  final TextStyle? subTitleStyle;
  final String primaryButtonLabel;
  final String? secondaryButtonLabel;
  final VoidCallback onPrimaryButtonTap;
  final VoidCallback? onSecondaryButtonTap;

  LoraBottomSheet.show({
    required this.context,
    required this.title,
    this.titleStyle,
    this.disablePrimaryButton = false,
    this.subTitle,
    this.subTitleStyle,
    required this.primaryButtonLabel,
    this.secondaryButtonLabel,
    required this.onPrimaryButtonTap,
    this.onSecondaryButtonTap,
  }) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: (context),
        builder: (_) => LoraBottomSheetContent(
              title: title,
              titleStyle: titleStyle,
              primaryButtonLabel: primaryButtonLabel,
              secondaryButtonLabel: secondaryButtonLabel,
              onPrimaryButtonTap: onPrimaryButtonTap,
              onSecondaryButtonTap: onSecondaryButtonTap,
              subTitle: subTitle,
              subTitleStyle: subTitleStyle,
              disablePrimaryButton: disablePrimaryButton,
            ));
  }
}

class LoraBottomSheetContent extends StatelessWidget {
  final bool disablePrimaryButton;
  final String title;
  final TextStyle? titleStyle;
  final String? subTitle;
  final TextStyle? subTitleStyle;
  final Widget? child;
  final String primaryButtonLabel;
  final String? secondaryButtonLabel;
  final VoidCallback onPrimaryButtonTap;
  final VoidCallback? onSecondaryButtonTap;
  final double buttonPaddingTop;

  const LoraBottomSheetContent(
      {required this.title,
      this.titleStyle,
      this.disablePrimaryButton = false,
      this.subTitle,
      this.subTitleStyle,
      this.child,
      required this.primaryButtonLabel,
      this.secondaryButtonLabel,
      required this.onPrimaryButtonTap,
      this.onSecondaryButtonTap,
      this.buttonPaddingTop = 32,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 0),
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding:
                        AppValues.screenHorizontalPadding.copyWith(top: 20),
                    margin: const EdgeInsets.only(top: 70),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(43),
                          topRight: Radius.circular(43)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 123,
                          height: 11,
                          decoration: BoxDecoration(
                            color: AskLoraColors.gray,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: AppValues.screenHorizontalPadding,
                          child: CustomTextNew(
                            title,
                            style: titleStyle ?? AskLoraTextStyles.h4,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if (subTitle != null)
                          Padding(
                            padding: AppValues.screenHorizontalPadding
                                .copyWith(top: 23),
                            child: CustomTextNew(
                              subTitle!,
                              style: subTitleStyle ?? AskLoraTextStyles.body1,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        if (child != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: child!,
                          ),
                        secondaryButtonLabel != null &&
                                onSecondaryButtonTap != null
                            ? Padding(
                                padding: EdgeInsets.only(top: buttonPaddingTop),
                                child: ButtonPair(
                                    disablePrimaryButton: disablePrimaryButton,
                                    primaryButtonOnClick: onPrimaryButtonTap,
                                    secondaryButtonOnClick:
                                        onSecondaryButtonTap!,
                                    primaryButtonLabel: primaryButtonLabel,
                                    secondaryButtonLabel:
                                        secondaryButtonLabel!),
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                    bottom: 30, top: buttonPaddingTop),
                                child: PrimaryButton(
                                  disabled: disablePrimaryButton,
                                  label: primaryButtonLabel,
                                  onTap: onPrimaryButtonTap,
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
