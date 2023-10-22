import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../../../core/presentation/custom_text_new.dart';
import '../../../../../../core/presentation/dotted_border/dotted_border.dart';
import '../../../../../../core/presentation/we_create/custom_text_button.dart';
import '../../../../../../core/styles/asklora_colors.dart';
import '../../../../../../core/styles/asklora_text_styles.dart';

class SignatureDrawer extends StatelessWidget {
  final VoidCallback onSubmit;
  final VoidCallback onReset;
  final String initialValue;

  const SignatureDrawer({
    Key? key,
    required this.onSubmit,
    required this.onReset,
    this.initialValue = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      padding: EdgeInsets.zero,
      radius: const Radius.circular(20),
      borderType: BorderType.rRect,
      color: AskLoraColors.gray,
      dashPattern: const [4, 4],
      child: Stack(
        children: [
          ...initialValue.isEmpty ? _signatureDrawer : _signatureImage,
          Positioned(
            left: 19,
            top: 20,
            child: CustomTextNew(
              'SIGN HERE',
              style: AskLoraTextStyles.subtitleAllCap1,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> get _signatureImage => [
        Center(
          child: Image.memory(base64Decode(initialValue),
              key: const Key('customer_signature_png'), height: 300),
        ),
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: CustomTextButton(
            key: const Key('clear_signature_button'),
            onTap: onReset,
            label: 'Reset Signature',
          ),
        )
      ];

  List<Widget> get _signatureDrawer => [
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: CustomTextButton(
                      key: const Key('accept_signature_button'),
                      label: 'Accept',
                      onTap: onSubmit),
                ),
              ),
              Expanded(
                child: Center(
                  child: CustomTextButton(
                    key: const Key('reset_signature_button'),
                    label: 'Reset',
                    onTap: onReset,
                  ),
                ),
              ),
            ],
          ),
        )
      ];
}
