import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../../core/presentation/custom_text_new.dart';
import '../../../../../../../core/styles/asklora_colors.dart';
import '../../../../../../../core/styles/asklora_text_styles.dart';

part 'pads/custom_key_pad_button.dart';

part 'pads/custom_delete_key_pad.dart';

class CustomKeyPad extends StatefulWidget {
  final Function(String) onChange;

  const CustomKeyPad({required this.onChange, Key? key}) : super(key: key);

  @override
  State<CustomKeyPad> createState() => _CustomKeyPadState();
}

class _CustomKeyPadState extends State<CustomKeyPad> {
  final TextEditingController controller = TextEditingController();
  final double _spacing = 5;
  final double _runSpacing = 7;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      widget.onChange(controller.text);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double padWidth = (constraints.maxWidth - _spacing * 2) / 3;
      final double padHeight = (constraints.maxHeight - _runSpacing * 3) / 4;
      return Wrap(
        spacing: _spacing,
        runSpacing: _runSpacing,
        children: [
          CustomKeyPadButton(
              height: padHeight,
              onTap: onNumKeyTap,
              value: '1',
              width: padWidth),
          CustomKeyPadButton(
              height: padHeight,
              onTap: onNumKeyTap,
              value: '2',
              width: padWidth),
          CustomKeyPadButton(
              height: padHeight,
              onTap: onNumKeyTap,
              value: '3',
              width: padWidth),
          CustomKeyPadButton(
              height: padHeight,
              onTap: onNumKeyTap,
              value: '4',
              width: padWidth),
          CustomKeyPadButton(
              height: padHeight,
              onTap: onNumKeyTap,
              value: '5',
              width: padWidth),
          CustomKeyPadButton(
              height: padHeight,
              onTap: onNumKeyTap,
              value: '6',
              width: padWidth),
          CustomKeyPadButton(
              height: padHeight,
              onTap: onNumKeyTap,
              value: '7',
              width: padWidth),
          CustomKeyPadButton(
              height: padHeight,
              onTap: onNumKeyTap,
              value: '8',
              width: padWidth),
          CustomKeyPadButton(
              height: padHeight,
              onTap: onNumKeyTap,
              value: '9',
              width: padWidth),
          CustomKeyPadButton(
              height: padHeight,
              onTap: onNumKeyTap,
              value: '.',
              width: padWidth),
          CustomKeyPadButton(
              height: padHeight,
              onTap: onNumKeyTap,
              value: '0',
              width: padWidth),
          CustomDeleteKeyPad(
              height: padHeight, onTap: onDeleteKeyTap, width: padWidth)
        ],
      );
    });
  }

  NumberFormat formatter = NumberFormat.decimalPatternDigits(
    locale: 'en_us',
    decimalDigits: 0,
  );

  void onNumKeyTap(String value) {
    String inputtedAmount = '${controller.text.replaceAll(',', '')}$value';
    int firstDotIndex = inputtedAmount.indexOf('.');
    int lastDotIndex = inputtedAmount.lastIndexOf('.');

    if (firstDotIndex == -1) {
      controller.text = formatter.format(double.parse(inputtedAmount));
    } else {
      String digitString =
          inputtedAmount.substring(firstDotIndex, inputtedAmount.length).trim();
      if (firstDotIndex == 0) {
        controller.text = '';
      } else {
        if (digitString.length > 3 || firstDotIndex != lastDotIndex) {
          controller.text = controller.text;
        } else {
          String digitString = inputtedAmount
              .substring(firstDotIndex, inputtedAmount.length)
              .trim();

          String amountString = formatter.format(double.parse(
              inputtedAmount.substring(0, firstDotIndex).replaceAll(',', '')));

          controller.text = '$amountString$digitString';
        }
      }
    }
  }

  void onDeleteKeyTap() {
    int firstDotIndex = controller.text.indexOf('.');
    int textLength = controller.text.length;

    if (firstDotIndex == -1) {
      controller.text = textLength > 1
          ? formatter.format(double.parse(
              controller.text.substring(0, textLength - 1).replaceAll(',', '')))
          : '';
    } else {
      String digitString = controller.text
          .substring(firstDotIndex, controller.text.length)
          .trim();

      String amountString = formatter.format(double.parse(
          controller.text.substring(0, firstDotIndex).replaceAll(',', '')));

      String formattedInputtedAmount = '$amountString$digitString';

      controller.text = formattedInputtedAmount.length > 1
          ? formattedInputtedAmount.substring(
              0, formattedInputtedAmount.length - 1)
          : '';
    }
  }
}
