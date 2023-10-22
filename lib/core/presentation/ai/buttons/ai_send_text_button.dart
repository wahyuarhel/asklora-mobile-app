import 'package:flutter/material.dart';

import '../../../styles/asklora_colors.dart';
import '../../../utils/app_icons.dart';
import '../utils/ai_utils.dart';

class AiSendTextButton extends StatelessWidget {
  final bool isDisabled;
  final VoidCallback onTap;
  final AiThemeType aiThemeType;

  const AiSendTextButton(
      {this.isDisabled = false,
      required this.onTap,
      required this.aiThemeType,
      super.key});

  @override
  Widget build(BuildContext context) => AbsorbPointer(
        absorbing: isDisabled,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            onTap();
          },
          child: Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 1.5,
                color: aiThemeType == AiThemeType.light
                    ? Colors.transparent
                    : AskLoraColors.white,
              ),
              color: aiThemeType == AiThemeType.light
                  ? (isDisabled
                      ? aiThemeType.sendChatButtonDisableColor
                      : aiThemeType.sendChatButtonEnableColor)
                  : Colors.transparent,
              boxShadow: [
                if (aiThemeType == AiThemeType.dark)
                  BoxShadow(
                    color: isDisabled
                        ? aiThemeType.sendChatButtonDisableColor
                        : aiThemeType.sendChatButtonEnableColor,
                    blurRadius: 6,
                  ),
              ],
            ),
            child: getSvgIcon('icon_sent_text',
                color: isDisabled
                    ? aiThemeType.sendChatButtonIconDisableColor
                    : aiThemeType.sendChatButtonIconEnableColor),
          ),
        ),
      );
}
