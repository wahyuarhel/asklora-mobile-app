import 'package:flutter/material.dart';
import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';

class KycSubTitle extends StatelessWidget {
  final String subTitle;

  const KycSubTitle({required this.subTitle, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextNew(
      subTitle,
      style: AskLoraTextStyles.h4.copyWith(color: AskLoraColors.charcoal),
    );
  }
}
