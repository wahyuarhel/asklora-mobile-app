import 'package:flutter/material.dart';
import '../custom_text.dart';
import 'amount_text_field.dart';
import 'custom_dropdown.dart';
import 'master_text_field.dart';
import 'message_text_field.dart';
import 'otp_text_field.dart';
import 'password_text_field.dart';

class TextFieldExample extends StatelessWidget {
  const TextFieldExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          color: Colors.black,
        ),
        const CustomText(
          'TEXT FIELDS EXAMPLE',
          type: FontType.h5,
        ),
        const Divider(
          color: Colors.black,
        ),
        _textField(
            'Master',
            MasterTextField(
              labelText: 'Label',
              hintText: 'Hint Text',
              onChanged: (value) => debugPrint('value $value'),
            )),
        _textField(
            'Master Error',
            MasterTextField(
              labelText: 'Label',
              errorText: 'Please fill the label',
              hintText: 'Hint Text',
              onChanged: (value) => debugPrint('value $value'),
            )),
        _textField(
            'Password',
            PasswordTextField(
              label: 'Label',
              hintText: 'Hint Text',
              validPassword: (value) => debugPrint('valid $value'),
              onChanged: (value) => debugPrint('value $value'),
            )),
        _textField(
            'One Time Password',
            OtpTextField(
              onSendOtpTap: () {},
              onChanged: (value) => debugPrint('value $value'),
            )),
        _textField(
            'Amount',
            AmountTextField(
              initialValue: '20000',
              label: 'Label',
              hintText: 'HKD 10000',
              onChanged: (value) => debugPrint('value $value'),
            )),
        _textField(
            'Dropdown',
            CustomDropdown(
              hintText: 'Select Dropdown',
              itemsList: const ['This', 'That'],
              onChanged: (value) => debugPrint('value $value'),
            )),
        _textField(
            'Dropdown',
            MessageTextField(
              hintText: 'Hint Text',
              onChanged: (value) => debugPrint('value $value'),
            )),
      ],
    );
  }

  Widget _textField(String label, Widget textField) => Padding(
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
