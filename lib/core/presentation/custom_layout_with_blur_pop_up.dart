import 'dart:ui';

import 'package:flutter/material.dart';

import '../styles/asklora_colors.dart';
import '../values/app_values.dart';
import 'buttons/primary_button.dart';
import 'lora_popup_message/lora_popup_message.dart';
import 'lora_popup_message/model/lora_pop_up_message_model.dart';

class CustomLayoutWithBlurPopUp extends StatelessWidget {
  final LoraPopUpMessageModel loraPopUpMessageModel;
  final Widget content;
  final bool showPopUp;

  const CustomLayoutWithBlurPopUp(
      {required this.loraPopUpMessageModel,
      required this.content,
      this.showPopUp = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        content,
        if (showPopUp) ...[
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: AppValues.screenHorizontalPadding,
              child: LoraPopUpMessage(
                backgroundColor: AskLoraColors.charcoal,
                title: loraPopUpMessageModel.title,
                titleColor: AskLoraColors.white,
                subTitle: loraPopUpMessageModel.subTitle,
                subTitleColor: AskLoraColors.white,
                primaryButtonLabel: loraPopUpMessageModel.primaryButtonLabel,
                buttonPrimaryType: ButtonPrimaryType.solidGreen,
                onPrimaryButtonTap: loraPopUpMessageModel.onPrimaryButtonTap,
                secondaryButtonLabel:
                    loraPopUpMessageModel.secondaryButtonLabel,
                secondaryButtonColor: AskLoraColors.white,
                onSecondaryButtonTap:
                    loraPopUpMessageModel.onSecondaryButtonTap,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
