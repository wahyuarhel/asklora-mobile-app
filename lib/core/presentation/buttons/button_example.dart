import 'package:flutter/material.dart';

import '../../styles/asklora_colors.dart';
import '../../styles/asklora_text_styles.dart';
import '../custom_text_new.dart';
import 'primary_button.dart';
import 'secondary/secondary_multiple_choice_button.dart';
import 'utils/button_utils.dart';

class ButtonExample extends StatelessWidget {
  const ButtonExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextNew(
          'Get Your Investment In Shape',
          style: AskLoraTextStyles.h1,
        ),
        const Divider(
          color: Colors.black,
        ),
        _button(
            'Primary solid charcoal',
            PrimaryButton(
              label: 'Button',
              buttonPrimaryType: ButtonPrimaryType.solidCharcoal,
              buttonPrimarySize: ButtonPrimarySize.small,
              onTap: () {},
            )),
        _button(
            'Primary solid charcoal',
            PrimaryButton(
              label: 'Button',
              buttonPrimaryType: ButtonPrimaryType.solidCharcoal,
              buttonPrimarySize: ButtonPrimarySize.mid,
              onTap: () {},
            )),
        _button(
            'Primary solid charcoal',
            PrimaryButton(
              label: 'Button',
              buttonPrimaryType: ButtonPrimaryType.solidCharcoal,
              buttonPrimarySize: ButtonPrimarySize.big,
              onTap: () {},
            )),
        _button(
            'Primary solid green',
            PrimaryButton(
              label: 'Button',
              buttonPrimaryType: ButtonPrimaryType.solidGreen,
              onTap: () {},
            )),
        _button(
            'Primary ghost charcoal',
            PrimaryButton(
              label: 'Button',
              buttonPrimaryType: ButtonPrimaryType.ghostCharcoal,
              onTap: () {},
            )),
        _button(
            'Primary ghost green',
            Container(
              padding: const EdgeInsets.all(24),
              color: AskLoraColors.charcoal,
              child: PrimaryButton(
                label: 'Button',
                buttonPrimaryType: ButtonPrimaryType.ghostGreen,
                onTap: () {},
              ),
            )),
        _button(
          'Secondary default',
          SecondaryMultipleChoiceButton(
              label: 'Multiple choice big safsaff asfasf asfsafas',
              buttonSecondarySize: ButtonSecondarySize.small,
              onTap: () {}),
        ),
        _button(
          'Secondary active',
          SecondaryMultipleChoiceButton(
              label:
                  'Multiple choice big safsaff asfasf asfsafas asfasf asfasf asfsaf asfsafas fasf',
              buttonSecondarySize: ButtonSecondarySize.small,
              active: true,
              onTap: () {}),
        ),
        _button(
          'Secondary active big',
          SecondaryMultipleChoiceButton(
              label: 'Multiple choice big safsaff asfasf asfsafas',
              buttonSecondarySize: ButtonSecondarySize.big,
              active: true,
              onTap: () {}),
        ),
      ],
    );
  }

  Widget _button(String label, Widget textField) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label),
            const SizedBox(
              height: 12,
            ),
            textField
          ],
        ),
      );
}
