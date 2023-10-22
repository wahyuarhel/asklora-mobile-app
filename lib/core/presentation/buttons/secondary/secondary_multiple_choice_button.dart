import 'package:flutter/material.dart';
import '../../../domain/pair.dart';
import '../../../styles/asklora_colors.dart';
import '../../../styles/asklora_text_styles.dart';
import '../../custom_text_new.dart';
import '../utils/button_utils.dart';

class SecondaryMultipleChoiceButton extends StatelessWidget {
  final String label;
  final ButtonSecondarySize buttonSecondarySize;
  final FontStyle fontStyle;
  final VoidCallback onTap;
  final bool active;
  final bool disabled;
  final Alignment labelAlignment;

  SecondaryMultipleChoiceButton(
      {this.label = '',
      required this.onTap,
      this.disabled = false,
      this.fontStyle = FontStyle.normal,
      this.buttonSecondarySize = ButtonSecondarySize.big,
      this.active = false,
      this.labelAlignment = Alignment.centerLeft,
      Key? key})
      : super(key: key);

  final ButtonStyle _defaultButtonStyle = ElevatedButton.styleFrom(
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _getSizedBoxSize.left,
      child: IgnorePointer(
        ignoring: disabled,
        child: ElevatedButton(
            style: _defaultButtonStyle.copyWith(
                minimumSize: _getButtonMinimumSize,
                backgroundColor: _getColor(
                    disabled
                        ? AskLoraColors.gray
                        : active
                            ? AskLoraColors.primaryGreen.withOpacity(0.1)
                            : Colors.transparent,
                    AskLoraColors.primaryGreen.withOpacity(0.2)),
                foregroundColor: _getColor(AskLoraColors.charcoal,
                    AskLoraColors.charcoal.withOpacity(0.9)),
                shape: _getBorder(
                    color: active
                        ? AskLoraColors.primaryGreen
                        : AskLoraColors.gray,
                    colorPressed: AskLoraColors.gray.withOpacity(0.9),
                    borderWidth: active ? 3 : 1.4)),
            onPressed: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Align(
                alignment: labelAlignment,
                child: CustomTextNew(label, style: AskLoraTextStyles.subtitle2),
              ),
            )),
      ),
    );
  }

  MaterialStateProperty<Color> _getColor(Color color, Color colorPressed) {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return colorPressed;
      } else {
        return color;
      }
    });
  }

  MaterialStateProperty<OutlinedBorder> _getBorder(
      {required Color color,
      required Color colorPressed,
      required double borderWidth}) {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
              width: borderWidth,
              color: states.contains(MaterialState.pressed)
                  ? colorPressed
                  : color));
    });
  }

  MaterialStateProperty<Size?> get _getButtonMinimumSize {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      switch (buttonSecondarySize) {
        case ButtonSecondarySize.small:
          return const Size(200, 40);
        case ButtonSecondarySize.big:
          return const Size(double.infinity, 55);
      }
    });
  }

  Pair<double, double> get _getSizedBoxSize {
    switch (buttonSecondarySize) {
      case ButtonSecondarySize.small:
        return const Pair(200, 40);
      case ButtonSecondarySize.big:
        return const Pair(double.infinity, 50);
    }
  }
}
