import 'package:flutter/material.dart';

import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/styles/asklora_text_styles.dart';

class QuestionTitle extends StatelessWidget {
  final double paddingBottom;
  final String question;

  const QuestionTitle(
      {required this.question, this.paddingBottom = 45, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(bottom: paddingBottom),
        child: CustomTextNew(
          question,
          style: AskLoraTextStyles.h3,
        ),
      );
}
