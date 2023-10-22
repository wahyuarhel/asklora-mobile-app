import 'package:flutter/material.dart';

import '../../../../../../core/presentation/buttons/secondary/secondary_multiple_choice_button.dart';
import '../../../../../../core/presentation/we_create/custom_text_button.dart';
import '../../../../../../generated/l10n.dart';

class ChoicesButton extends StatelessWidget {
  final String initialValue;
  final Function() onAnswerYes;
  final Function() onAnswerNo;
  final Function() onSaveForLater;

  const ChoicesButton(
      {this.initialValue = '',
      required this.onAnswerYes,
      required this.onAnswerNo,
      required this.onSaveForLater,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 35),
      child: Column(
        children: [
          SecondaryMultipleChoiceButton(
            active: initialValue == 'yes',
            key: const Key('yes_button'),
            fontStyle: FontStyle.normal,
            label: S.of(context).yes,
            onTap: onAnswerYes,
            labelAlignment: Alignment.center,
          ),
          const SizedBox(
            height: 20,
          ),
          SecondaryMultipleChoiceButton(
            active: initialValue == 'no',
            key: const Key('no_button'),
            fontStyle: FontStyle.normal,
            label: S.of(context).no,
            onTap: onAnswerNo,
            labelAlignment: Alignment.center,
          ),
          CustomTextButton(
            key: const Key('save_for_later_button'),
            margin: const EdgeInsets.only(top: 24),
            label: S.of(context).saveForLater,
            onTap: onSaveForLater,
          )
        ],
      ),
    );
  }
}
