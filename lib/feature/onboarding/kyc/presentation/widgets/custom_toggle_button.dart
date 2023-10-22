import 'package:flutter/material.dart';

import '../../../../../core/domain/pair.dart';
import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../core/utils/utils.dart';

class CustomToggleButton extends StatelessWidget {
  final String? title;
  final EdgeInsets padding;
  final Pair<String, String> choices;
  final String? initialValue;
  final Function(String) onSelected;

  const CustomToggleButton(
      {this.title,
      required this.choices,
      required this.onSelected,
      this.initialValue,
      this.padding = EdgeInsets.zero,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: CustomTextNew(
                title!,
                style: AskLoraTextStyles.subtitle1,
              ),
            ),
          Row(
            children: [
              _choicesWidget(
                  choice: choices.left,
                  selected: initialValue == choices.left,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8))),
              _choicesWidget(
                  choice: choices.right,
                  selected: initialValue == choices.right,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)))
            ],
          )
        ],
      );
    });
  }

  Widget _choicesWidget(
      {required String choice,
      required bool selected,
      required BorderRadius borderRadius}) {
    return Expanded(
      child: GestureDetector(
        key: Key('$title-$choice'),
        onTap: () {
          closeKeyboard();
          onSelected(choice);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AskLoraColors.darkGray, width: 1),
            borderRadius: borderRadius,
            color: selected ? AskLoraColors.charcoal : Colors.white,
          ),
          constraints: const BoxConstraints(minHeight: 50),
          child: Center(
              child: CustomTextNew(
            choice,
            style: AskLoraTextStyles.subtitle2.copyWith(
              color: selected
                  ? AskLoraColors.primaryGreen
                  : AskLoraColors.darkGray,
            ),
          )),
        ),
      ),
    );
  }
}
