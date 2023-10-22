import 'package:flutter/material.dart';

import '../../../styles/asklora_colors.dart';
import '../../../styles/asklora_text_styles.dart';

class TextFieldStyle {
  static OutlineInputBorder nonFocusedBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: AskLoraColors.darkGray, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(8)));

  static OutlineInputBorder focusedBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: AskLoraColors.primaryGreen, width: 2));

  static TextStyle errorTextStyle = AskLoraTextStyles.body3
      .copyWith(color: AskLoraColors.primaryMagenta, height: 1);

  static TextStyle labelTextStyle = AskLoraTextStyles.body2
      .copyWith(color: AskLoraColors.charcoal, height: 1.2);

  static TextStyle hintTextStyle =
      AskLoraTextStyles.body1.copyWith(color: AskLoraColors.gray, height: 1.3);

  static TextStyle valueTextStyle = AskLoraTextStyles.body1
      .copyWith(color: AskLoraColors.charcoal, height: 1.3);

  static EdgeInsets contentPadding =
      const EdgeInsets.symmetric(horizontal: 17, vertical: 18);

  static InputDecoration inputDecoration = InputDecoration(
      contentPadding: contentPadding,
      border: nonFocusedBorder,
      enabledBorder: nonFocusedBorder,
      focusedBorder: focusedBorder,
      errorBorder: nonFocusedBorder,
      focusedErrorBorder: focusedBorder,
      errorStyle: errorTextStyle,
      labelStyle: labelTextStyle,
      hintStyle: hintTextStyle);
}
