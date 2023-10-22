import 'package:flutter/material.dart';

import '../styles/asklora_colors.dart';
import 'custom_text.dart';

class QuestionWidget extends StatelessWidget {
  final EdgeInsets padding;
  final String questionText;
  final List<String> options;
  final void Function(String) onSelected;
  final String? selectedAnswer;
  final String errorText;
  final String keyOption;

  const QuestionWidget({
    Key? key,
    this.padding = EdgeInsets.zero,
    this.questionText = '',
    required this.options,
    required this.onSelected,
    this.selectedAnswer,
    this.errorText = '',
    this.keyOption = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (questionText.isNotEmpty)
            CustomText(
              questionText,
              type: FontType.bodyTextBold,
            ),
          Column(
            children: options.map(
              (choice) {
                bool? selectedOption = choice == selectedAnswer;
                return _buildOptions(selectedOption, choice);
              },
            ).toList(),
          ),
          if (errorText.isNotEmpty)
            CustomText(
              errorText,
              padding: const EdgeInsets.only(top: 5),
              type: FontType.smallText,
              color: AskLoraColors.down,
            ),
        ],
      ),
    );
  }

  Widget _buildOptions(bool isSelected, String choice) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Material(
        color: _backgroundColor(isSelected),
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: _borderColor(isSelected),
            ),
            borderRadius: BorderRadius.circular(5)),
        child: InkWell(
          key: Key('$keyOption $choice'),
          onTap: () {
            onSelected(choice);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: CustomText(
                    choice,
                    color: _textColor(isSelected),
                    type: _textTypeStyle(isSelected),
                  ),
                ),
                _iconCheck(isSelected),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _borderColor(isSelected) {
    if (isSelected) {
      return AskLoraColors.primaryGreen;
    } else {
      return Colors.black38;
    }
  }

  Color _backgroundColor(isSelected) {
    return isSelected
        ? AskLoraColors.primaryGreen.withAlpha(30)
        : Colors.transparent;
  }

  Color _textColor(isSelected) {
    return isSelected ? AskLoraColors.primaryGreen : AskLoraColors.text;
  }

  FontType _textTypeStyle(isSelected) {
    return isSelected ? FontType.smallTextBold : FontType.smallText;
  }

  Widget _iconCheck(isSelected) {
    if (isSelected) {
      return const Icon(
        Icons.check,
        size: 20,
        color: AskLoraColors.primaryGreen,
      );
    } else {
      return const SizedBox(
        height: 20,
      );
    }
  }
}
