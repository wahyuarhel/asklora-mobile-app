import 'package:flutter/material.dart';

import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../core/utils/app_icons.dart';

class LoraAiButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool active;
  final VoidCallback? onClosed;
  final Color? activeFillColor;
  final Color? pressedFillColor;
  final Color? fillColor;
  final Color? activeBorderColor;
  final Color? borderColor;
  final Color? postfixIconColor;
  final TextStyle? textStyle;
  final Color? textColor;
  final Color? activeTextColor;
  final double horizontalPadding;
  final double verticalPadding;

  const LoraAiButton(
      {this.label = '',
      required this.onTap,
      this.active = false,
      this.activeFillColor,
      this.pressedFillColor,
      this.fillColor,
      this.borderColor,
      this.activeBorderColor,
      this.onClosed,
      this.textStyle,
      this.textColor,
      this.activeTextColor,
      this.horizontalPadding = 16,
      this.verticalPadding = 10,
      this.postfixIconColor = AskLoraColors.white,
      Key? key})
      : super(key: key);

  @override
  State<LoraAiButton> createState() => _LoraAiButtonState();
}

class _LoraAiButtonState extends State<LoraAiButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTap: widget.onTap,
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: widget.active
                ? widget.horizontalPadding
                : widget.horizontalPadding + 1.5,
            vertical: widget.active
                ? widget.verticalPadding
                : widget.verticalPadding + 1.5),
        margin: const EdgeInsets.only(right: 40),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
                width: widget.active ? 3 : 1.4,
                color: _isPressed
                    ? AskLoraColors.gray
                    : widget.active
                        ? widget.activeBorderColor ?? AskLoraColors.primaryGreen
                        : widget.borderColor ?? AskLoraColors.gray),
            color: widget.active
                ? widget.activeFillColor ??
                    AskLoraColors.primaryGreen.withOpacity(0.1)
                : _isPressed
                    ? widget.pressedFillColor ??
                        AskLoraColors.primaryGreen.withOpacity(0.2)
                    : widget.fillColor ?? Colors.transparent),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: CustomTextNew(
                widget.label,
                style: (widget.textStyle ?? AskLoraTextStyles.button3).copyWith(
                    color: widget.active
                        ? widget.activeTextColor ?? AskLoraColors.charcoal
                        : widget.textColor ?? AskLoraColors.gray),
                maxLines: 5,
                ellipsis: true,
              ),
            ),
            const SizedBox(width: 5),
            getSvgIcon('icon_sent_text',
                color: widget.postfixIconColor, height: 20, width: 20)
          ],
        ),
      ),
    );
  }
}
