import 'package:flutter/material.dart';

import '../styles/asklora_colors.dart';
import '../styles/asklora_text_styles.dart';
import '../utils/app_icons.dart';
import 'custom_text_new.dart';

enum StatusType {
  success('memoji_background_green', 'success'),
  failed('memoji_background_magenta', 'failed');

  final String backgroundImage;
  final String image;

  const StatusType(this.backgroundImage, this.image);
}

class CustomStatusWidget extends StatelessWidget {
  final String title;
  final Color titleColor;
  final String? subTitle;
  final Color subTitleColor;
  final StatusType statusType;

  const CustomStatusWidget(
      {required this.title,
      this.subTitle,
      this.subTitleColor = AskLoraColors.charcoal,
      this.statusType = StatusType.success,
      Key? key = const Key('status_widget'),
      this.titleColor = AskLoraColors.charcoal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Stack(alignment: Alignment.center, children: [
        getSvgImage(statusType.backgroundImage),
        getPngImage(statusType.image),
      ]),
      CustomTextNew(
        title,
        style: AskLoraTextStyles.h4.copyWith(color: titleColor),
        textAlign: TextAlign.center,
      ),
      if (subTitle != null)
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: CustomTextNew(
            subTitle!,
            style: AskLoraTextStyles.body1.copyWith(color: titleColor),
            textAlign: TextAlign.center,
          ),
        ),
    ]);
  }
}
