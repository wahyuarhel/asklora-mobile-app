import 'package:flutter/material.dart';

import '../../../../core/presentation/custom_text_new.dart';
import '../../../../core/styles/asklora_colors.dart';
import '../../../../core/styles/asklora_text_styles.dart';
import '../../../../core/values/app_values.dart';

class TransactionHistoryGroupTitle extends StatelessWidget {
  final String title;
  const TransactionHistoryGroupTitle({required this.title, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppValues.screenHorizontalPadding.copyWith(top: 8, bottom: 8),
      color: AskLoraColors.whiteSmoke,
      child: CustomTextNew(
        title,
        style: AskLoraTextStyles.subtitle4,
      ),
    );
  }
}
