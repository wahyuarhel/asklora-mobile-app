import 'package:flutter/material.dart';

enum FontType {
  highlight,
  h1,
  h2,
  h3,
  h3W800,
  h4,
  h4Normal,
  h4SemiBold,
  h5,
  bodyText,
  bodyTextBold,
  smallText,
  smallTextBold,
  button,
  note,
  smallNote,
  smallNoteBold,
  formTitle,
  formInfield,
  mobileMenu,
  delay
}

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontType type;
  final bool ellipsis;
  final TextAlign textAlign;
  final TextDecoration decoration;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final int? maxLines;
  final FontStyle? fontStyle;
  final double? height;
  final FontWeight fontWeight;

  const CustomText(this.text,
      {Key? key,
      this.color,
      this.type = FontType.bodyText,
      this.ellipsis = false,
      this.textAlign = TextAlign.start,
      this.decoration = TextDecoration.none,
      this.padding = EdgeInsets.zero,
      this.margin = EdgeInsets.zero,
      this.fontWeight = FontWeight.normal,
      this.maxLines,
      this.height,
      this.fontStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double? fontType;
    FontWeight fontWeight = this.fontWeight;

    switch (type) {
      case FontType.h1:
        fontType = 40;
        break;
      case FontType.highlight:
        fontType = 32;
        break;
      case FontType.h2:
        fontType = 30;
        break;
      case FontType.h3:
        fontType = 22;
        break;
      case FontType.h3W800:
        fontType = 22;
        break;
      case FontType.h4Normal:
      case FontType.h4SemiBold:
      case FontType.h4:
        fontType = 20;
        break;
      case FontType.h5:
        fontType = 18;
        break;
      case FontType.bodyText:
      case FontType.bodyTextBold:
      case FontType.formInfield:
        fontType = 16;
        break;
      case FontType.smallTextBold:
      case FontType.smallText:
      case FontType.button:
      case FontType.formTitle:
        fontType = 14;
        break;
      case FontType.note:
        fontType = 13;
        break;
      case FontType.smallNote:
      case FontType.smallNoteBold:
        fontType = 12;
        break;
      case FontType.mobileMenu:
      case FontType.delay:
        fontType = 11;
        break;
      default:
        fontType = 16;
    }

    switch (type) {
      case FontType.highlight:
        fontWeight = FontWeight.w300;
        break;
      case FontType.h3W800:
        fontWeight = FontWeight.w800;
        break;
      case FontType.h1:
      case FontType.h2:
      case FontType.h3:
      case FontType.h4:
      case FontType.h5:
        fontWeight = FontWeight.w900;
        break;
      case FontType.bodyTextBold:
      case FontType.smallTextBold:
      case FontType.smallNoteBold:
        fontWeight = FontWeight.bold;
        break;
      case FontType.h4SemiBold:
        fontWeight = FontWeight.w500;
        break;
      default:
        fontWeight = this.fontWeight;
    }
    return Container(
      padding: padding,
      margin: margin,
      child: Text(
        text,
        style: TextStyle(
            color: color,
            fontSize: fontType,
            fontWeight: fontWeight,
            decoration: decoration,
            height: height,
            fontStyle: fontStyle),
        overflow: ellipsis ? TextOverflow.ellipsis : null,
        textAlign: textAlign,
        maxLines: maxLines,
      ),
    );
  }
}
