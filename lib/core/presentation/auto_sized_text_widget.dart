import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AutoSizedTextWidget extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final double minFontSize;
  final TextAlign? textAlign;
  final bool ellipsis;

  const AutoSizedTextWidget(this.text,
      {this.style,
      this.maxLines,
      this.minFontSize = 1,
      this.textAlign,
      this.ellipsis = false,
      super.key});

  @override
  State<AutoSizedTextWidget> createState() => _AutoSizedTextWidgetState();
}

class _AutoSizedTextWidgetState extends State<AutoSizedTextWidget> {
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      widget.text,
      minFontSize: widget.minFontSize,
      style: widget.style,
      maxLines: widget.maxLines,
      textAlign: widget.textAlign,
      overflow: widget.ellipsis ? TextOverflow.ellipsis : null,
    );
  }
}
