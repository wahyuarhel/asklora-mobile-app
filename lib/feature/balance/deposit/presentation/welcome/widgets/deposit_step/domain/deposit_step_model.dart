import 'package:flutter/material.dart';

import '../../../../../../../../core/styles/asklora_colors.dart';

class DepositStepModel {
  final String title;
  final String subTitle;
  final Color subTitleColor;

  DepositStepModel(
      {required this.title,
      this.subTitle = '',
      this.subTitleColor = AskLoraColors.darkGray});
}
