import 'package:flutter/material.dart';

import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../feature/tabs/lora_gpt/presentation/widget/scrambled_text.dart';
import '../../../styles/asklora_colors.dart';
import '../../custom_text_new.dart';
import '../utils/ai_utils.dart';

class OutChatBubbleWidget extends StatefulWidget {
  const OutChatBubbleWidget(this.message,
      {super.key,
      this.animateText = false,
      this.onFinishedAnimation,
      this.onStartAnimation,
      this.aiThemeType = AiThemeType.dark});

  final String message;
  final bool animateText;
  final VoidCallback? onFinishedAnimation;
  final VoidCallback? onStartAnimation;
  final AiThemeType aiThemeType;

  @override
  State<OutChatBubbleWidget> createState() => _OutChatBubbleWidgetState();
}

class _OutChatBubbleWidgetState extends State<OutChatBubbleWidget> {
  bool isCollapse = false;
  bool animationFinish = false;
  static const fixedLen = 200;

  @override
  void initState() {
    isCollapse = widget.message.length > fixedLen;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(bottom: 5, right: 40),
          decoration: BoxDecoration(
            color: widget.aiThemeType.outChatBubbleWidgetColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: isCollapse || widget.animateText
              ? Column(
                  children: [
                    ScrambledText(
                        scrambledStyle: AskLoraTextStyles.body1.copyWith(
                            color: widget.aiThemeType.scrambledTextColor),
                        text: isCollapse
                            ? '${widget.message.substring(0, fixedLen)}...'
                            : widget.message,
                        style: AskLoraTextStyles.body1.copyWith(
                            color: widget.aiThemeType.primaryFontColor),
                        duration: const Duration(milliseconds: 17),
                        onStart: () async {
                          widget.onStartAnimation?.call();
                        },
                        onFinished: () async {
                          Future.delayed(Duration.zero, () async {
                            setState(() {
                              animationFinish = true;
                            });
                          });

                          if (widget.onFinishedAnimation != null) {
                            widget.onFinishedAnimation!();
                          }
                        }),
                    if (animationFinish) ...[
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Future.delayed(Duration.zero, () async {
                            setState(() {
                              isCollapse = false;
                            });
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: CustomTextNew(
                                'Show more',
                                style: AskLoraTextStyles.body1
                                    .copyWith(color: AskLoraColors.gray),
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down_rounded,
                                color: AskLoraColors.gray)
                          ],
                        ),
                      ),
                    ]
                  ],
                )
              : SelectableText(widget.message,
                  style: AskLoraTextStyles.body1
                      .copyWith(color: widget.aiThemeType.primaryFontColor))),
    );
  }
}

class OutChatExpandedBubbleWidget extends StatelessWidget {
  const OutChatExpandedBubbleWidget(this.message,
      {super.key,
      this.animateText = false,
      this.onFinishedAnimation,
      this.onStartAnimation,
      this.aiThemeType = AiThemeType.dark});

  final String message;
  final bool animateText;
  final VoidCallback? onFinishedAnimation;
  final VoidCallback? onStartAnimation;
  final AiThemeType aiThemeType;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.topLeft,
        child: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(bottom: 5, right: 40),
            decoration: BoxDecoration(
              color: aiThemeType.outChatBubbleWidgetColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: animateText
                ? ScrambledText(
                    scrambledStyle: AskLoraTextStyles.body1
                        .copyWith(color: aiThemeType.scrambledTextColor),
                    text: message,
                    style: AskLoraTextStyles.body1
                        .copyWith(color: aiThemeType.primaryFontColor),
                    duration: const Duration(milliseconds: 17),
                    onStart: () {
                      onStartAnimation?.call();
                    },
                    onFinished: () {
                      if (onFinishedAnimation != null) {
                        onFinishedAnimation!();
                      }
                    })
                : SelectableText(message,
                    style: AskLoraTextStyles.body1
                        .copyWith(color: aiThemeType.primaryFontColor))),
      );
}
