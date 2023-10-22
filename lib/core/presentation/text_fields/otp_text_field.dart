import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../styles/asklora_colors.dart';
import '../../styles/asklora_text_styles.dart';
import 'style/text_field_style.dart';

class OtpTextField extends StatefulWidget {
  final String initialValue;
  final String errorText;
  final VoidCallback onSendOtpTap;
  final Function(String)? onChanged;

  const OtpTextField({
    Key? key,
    this.onChanged,
    this.initialValue = '',
    required this.onSendOtpTap,
    this.errorText = '',
  }) : super(key: key);

  @override
  State<OtpTextField> createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  final TextEditingController controller = TextEditingController();

  FloatingLabelBehavior floatingLabelBehavior = FloatingLabelBehavior.never;
  String? label;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue.isNotEmpty) {
      label = 'One-time-password';
      floatingLabelBehavior = FloatingLabelBehavior.always;
      controller.text = widget.initialValue;
    }
    controller.addListener(() {
      _setFloatingLabelBehavior();
    });
  }

  void _setFloatingLabelBehavior() {
    setState(() {
      if (controller.text.isEmpty) {
        label = null;
        floatingLabelBehavior = FloatingLabelBehavior.never;
      } else {
        label = 'One-time-password';
        floatingLabelBehavior = FloatingLabelBehavior.always;
      }
    });
  }

  @override
  Widget build(BuildContext context) => Theme(
        data: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: AskLoraColors.primaryGreen,
              ),
        ),
        child: TextFormField(
          controller: controller,
          onChanged: widget.onChanged,
          style: TextFieldStyle.valueTextStyle,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(4),
          ],
          keyboardType: TextInputType.number,
          decoration: TextFieldStyle.inputDecoration.copyWith(
              floatingLabelBehavior: floatingLabelBehavior,
              labelText: label,
              hintText: 'One-time-password (4 digit)',
              errorText: widget.errorText.isEmpty ? null : widget.errorText,
              suffixIcon: ResendOtpButton(onSendOtpTap: widget.onSendOtpTap)),
        ),
      );
}

class ResendOtpButton extends StatefulWidget {
  final VoidCallback onSendOtpTap;

  const ResendOtpButton({required this.onSendOtpTap, Key? key})
      : super(key: key);

  @override
  State<ResendOtpButton> createState() => _ResendOtpButtonState();
}

class _ResendOtpButtonState extends State<ResendOtpButton> {
  bool firstTime = true;
  bool disable = false;
  int time = 60;
  Timer? timer;

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 17.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              firstTime = false;
              if (!disable) {
                widget.onSendOtpTap();
                setState(() {
                  disable = true;
                });
                timer = Timer.periodic(
                  const Duration(seconds: 1),
                  (Timer timer) {
                    if (time == 0) {
                      setState(() {
                        disable = false;
                        time = 60;
                        timer.cancel();
                      });
                    } else {
                      setState(() {
                        time--;
                      });
                    }
                  },
                );
              }
            },
            child: Center(
              child: Text(
                  disable
                      ? 'RE-SEND IN $time'
                      : firstTime
                          ? 'SEND OTP'
                          : 'RE-SEND OTP',
                  style: AskLoraTextStyles.subtitleAllCap1.copyWith(
                      color: disable
                          ? AskLoraColors.gray
                          : AskLoraColors.charcoal)),
            ),
          )
        ],
      ),
    );
  }
}
