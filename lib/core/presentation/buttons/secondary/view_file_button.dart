import 'package:flutter/material.dart';

import '../../../styles/asklora_colors.dart';
import '../../../styles/asklora_text_styles.dart';
import '../../../utils/app_icons.dart';
import '../../custom_text_new.dart';

class ViewFileButton extends StatelessWidget {
  final String label;
  final FontStyle fontStyle;
  final VoidCallback onTap;
  final Alignment labelAlignment;

  ViewFileButton(
      {this.label = '',
      required this.onTap,
      this.fontStyle = FontStyle.normal,
      this.labelAlignment = Alignment.centerLeft,
      Key? key})
      : super(key: key);

  final ButtonStyle _defaultButtonStyle = ElevatedButton.styleFrom(
      elevation: 0,
      shadowColor: Colors.transparent,
      minimumSize: const Size(double.infinity, 55),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: _defaultButtonStyle.copyWith(
              backgroundColor: _getColor(Colors.transparent,
                  AskLoraColors.primaryGreen.withOpacity(0.2)),
              foregroundColor: _getColor(AskLoraColors.charcoal,
                  AskLoraColors.charcoal.withOpacity(0.9)),
              shape: _getBorder(
                  color: AskLoraColors.gray,
                  colorPressed: AskLoraColors.gray.withOpacity(0.9),
                  borderWidth: 1.4)),
          onPressed: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Row(
              children: [
                getSvgIcon('pdf'),
                const SizedBox(
                  width: 18,
                ),
                Expanded(
                    child: CustomTextNew(label,
                        style: AskLoraTextStyles.subtitle2)),
              ],
            ),
          )),
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
}
