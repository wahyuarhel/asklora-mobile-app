import 'package:flutter/material.dart';
import '../utils/ai_utils.dart';
import '../../text_fields/style/text_field_style.dart';
import '../buttons/ai_send_text_button.dart';

class AiTextField extends StatefulWidget {
  final Function(String) onFieldSubmitted;
  final Function(String) onChanged;
  final VoidCallback onTap;
  final bool isSendButtonDisabled;
  final AiThemeType aiThemeType;
  final String hintText;

  const AiTextField(
      {required this.onFieldSubmitted,
      required this.onChanged,
      required this.onTap,
      required this.aiThemeType,
      this.isSendButtonDisabled = false,
      this.hintText = 'Ask me anything...',
      super.key});

  @override
  State<AiTextField> createState() => _AiTextFieldState();
}

class _AiTextFieldState extends State<AiTextField> {
  late final TextEditingController controller;
  bool focused = false;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: FocusScope(
            onFocusChange: (focus) {
              setState(() {
                focused = focus;
              });
            },
            child: TextFormField(
                cursorColor: widget.aiThemeType.primaryFontColor,
                onFieldSubmitted: widget.onFieldSubmitted,
                controller: controller,
                onChanged: widget.onChanged,
                maxLines: 5,
                minLines: 1,
                style: TextFieldStyle.valueTextStyle
                    .copyWith(color: widget.aiThemeType.primaryFontColor),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 17, vertical: 18),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    )).copyWith(borderSide: BorderSide.none),
                    focusedBorder: TextFieldStyle.focusedBorder.copyWith(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15.0))),
                    hintText: widget.hintText,
                    hintStyle: TextFieldStyle.valueTextStyle
                        .copyWith(color: widget.aiThemeType.primaryFontColor),
                    fillColor: widget.aiThemeType.textFieldFillColor,
                    filled: true)),
          ),
        ),
        const SizedBox(width: 14),
        AiSendTextButton(
          isDisabled: widget.isSendButtonDisabled,
          aiThemeType: widget.aiThemeType,
          onTap: () {
            widget.onTap();
            controller.text = '';
          },
        ),
      ],
    );
  }
}
