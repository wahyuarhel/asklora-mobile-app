import 'package:flutter/material.dart';

class AskLoraTextStyles {
  static const TextStyle _textStyle =
      TextStyle(fontFamilyFallback: ['Manrope']);

  static TextStyle h1 = _textStyle.copyWith(
      fontSize: 50, height: 1.2, fontWeight: AskLoraFontWeight.extraBold.value);

  static TextStyle h2 = _textStyle.copyWith(
      fontSize: 33,
      height: 1.32,
      fontWeight: AskLoraFontWeight.extraBold.value);

  static TextStyle h3 = _textStyle.copyWith(
      fontSize: 28,
      height: 1.32,
      fontWeight: AskLoraFontWeight.extraBold.value);

  static TextStyle h3Italic = _textStyle.copyWith(
    fontSize: 28,
    height: 1.5,
    fontWeight: AskLoraFontWeight.extraBold.value,
    fontStyle: FontStyle.italic,
  );

  static TextStyle h4 = _textStyle.copyWith(
    fontSize: 23,
    height: 1.32,
    fontWeight: AskLoraFontWeight.extraBold.value,
  );

  static TextStyle h4Italic = _textStyle.copyWith(
    fontSize: 23,
    height: 1.32,
    fontWeight: AskLoraFontWeight.extraBold.value,
    fontStyle: FontStyle.italic,
  );

  static TextStyle h5 = _textStyle.copyWith(
    fontSize: 19,
    height: 1.32,
    fontWeight: AskLoraFontWeight.extraBold.value,
  );

  static TextStyle h5Italic = _textStyle.copyWith(
    fontSize: 19,
    height: 1.32,
    fontWeight: AskLoraFontWeight.extraBold.value,
    fontStyle: FontStyle.italic,
  );

  static TextStyle h6 = _textStyle.copyWith(
    fontSize: 16,
    height: 1.32,
    fontWeight: AskLoraFontWeight.extraBold.value,
  );

  static TextStyle subtitle1 = _textStyle.copyWith(
    fontSize: 17,
    height: 1.5,
    fontWeight: AskLoraFontWeight.bold.value,
  );

  static TextStyle subtitle2 = _textStyle.copyWith(
    fontSize: 15,
    height: 1.5,
    fontWeight: AskLoraFontWeight.bold.value,
  );

  static TextStyle subtitle3 = _textStyle.copyWith(
    fontSize: 13,
    height: 1.5,
    fontWeight: AskLoraFontWeight.bold.value,
  );

  static TextStyle subtitle4 = _textStyle.copyWith(
      fontSize: 11, height: 1.5, fontWeight: AskLoraFontWeight.bold.value);

  static TextStyle subtitle5 = _textStyle.copyWith(
      fontSize: 9, height: 1.5, fontWeight: AskLoraFontWeight.bold.value);

  static TextStyle subtitleLight1 = _textStyle.copyWith(
      fontSize: 24, height: 1.5, fontWeight: AskLoraFontWeight.regular.value);

  static TextStyle subtitleLight2 = _textStyle.copyWith(
      fontSize: 18, height: 1.5, fontWeight: AskLoraFontWeight.regular.value);

  static TextStyle subtitleAllCap1 = _textStyle.copyWith(
      fontSize: 10, height: 1.5, fontWeight: AskLoraFontWeight.bold.value);

  static TextStyle subtitleAllCap2 = _textStyle.copyWith(
      fontSize: 8, height: 1.5, fontWeight: AskLoraFontWeight.bold.value);

  static TextStyle body1 = _textStyle.copyWith(
      fontSize: 15, height: 1.5, fontWeight: AskLoraFontWeight.regular.value);

  static TextStyle body2 = _textStyle.copyWith(
      fontSize: 13, height: 1.5, fontWeight: AskLoraFontWeight.regular.value);

  static TextStyle body3 = _textStyle.copyWith(
      fontSize: 11, height: 1.5, fontWeight: AskLoraFontWeight.regular.value);

  static TextStyle body4 = _textStyle.copyWith(
      fontSize: 9, height: 1.5, fontWeight: AskLoraFontWeight.regular.value);

  static TextStyle button1 = _textStyle.copyWith(
      fontSize: 14, height: 1.5, fontWeight: AskLoraFontWeight.extraBold.value);

  static TextStyle button2 = _textStyle.copyWith(
      fontSize: 11, height: 1.5, fontWeight: AskLoraFontWeight.extraBold.value);

  static TextStyle button3 = _textStyle.copyWith(
      fontSize: 15, height: 1.5, fontWeight: AskLoraFontWeight.semiBold.value);
}

enum AskLoraFontWeight {
  thin(FontWeight.w100),
  extraLight(FontWeight.w200),
  light(FontWeight.w300),
  regular(FontWeight.w400),
  medium(FontWeight.w500),
  semiBold(FontWeight.w600),
  bold(FontWeight.w700),
  extraBold(FontWeight.w800);

  final FontWeight value;

  const AskLoraFontWeight(this.value);
}
