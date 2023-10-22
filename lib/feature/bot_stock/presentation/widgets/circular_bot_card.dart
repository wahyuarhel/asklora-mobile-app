import 'package:flutter/material.dart';

import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../core/presentation/circular_container.dart';

class CircularBotCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color backgroundColor;
  final Color subTitleBackgroundColor;

  const CircularBotCard(
      {Key? key,
      required this.title,
      this.backgroundColor = AskLoraColors.lightGray,
      required this.subTitleBackgroundColor,
      required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularContainer(
      height: 150,
      width: 150,
      backgroundColor: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(11)),
                color: subTitleBackgroundColor),
            child: CustomTextNew(
              subTitle,
              style: AskLoraTextStyles.subtitle2
                  .copyWith(color: AskLoraColors.white),
            ),
          ),
          CustomTextNew(
            title,
            style: AskLoraTextStyles.h5.copyWith(color: AskLoraColors.charcoal),
          )
        ],
      ),
    );
  }
}
