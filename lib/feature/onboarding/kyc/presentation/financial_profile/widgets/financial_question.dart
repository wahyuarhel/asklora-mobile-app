import 'package:flutter/material.dart';
import '../../../../../../core/presentation/custom_text_new.dart';
import '../../../../../../core/styles/asklora_colors.dart';
import '../../../../../../core/styles/asklora_text_styles.dart';

class FinancialQuestion extends StatelessWidget {
  final String question;

  const FinancialQuestion(this.question,
      {Key? key = const Key('financial_question')})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextNew(question,
        style: AskLoraTextStyles.h5.copyWith(color: AskLoraColors.charcoal));
  }
}
