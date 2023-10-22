import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../generated/l10n.dart';
import '../../styles/asklora_colors.dart';
import '../../styles/asklora_text_styles.dart';
import '../../utils/app_icons.dart';
import '../../utils/extensions.dart';
import '../custom_text_new.dart';
import 'style/text_field_style.dart';

class PasswordTextField extends StatefulWidget {
  final TextCapitalization textCapitalization;
  final String initialValue;
  final List<TextInputFormatter>? textInputFormatterList;
  final String label;
  final String hintText;
  final String errorText;
  final Function(bool) validPassword;
  final Function(String)? onChanged;
  final bool isShowingPasswordValidation;

  const PasswordTextField({
    Key? key,
    this.onChanged,
    this.textCapitalization = TextCapitalization.none,
    this.initialValue = '',
    this.textInputFormatterList,
    this.label = '',
    this.hintText = '',
    this.errorText = '',
    required this.validPassword,
    this.isShowingPasswordValidation = true,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  final TextEditingController controller = TextEditingController();

  FloatingLabelBehavior floatingLabelBehavior = FloatingLabelBehavior.never;
  bool obscureText = true;
  bool minEightCharacters = false;
  bool containsLowerCase = false;
  bool containsUpperCase = false;
  bool containsNumber = false;
  bool shouldShowErrorsTexts = false;
  String? label;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue.isNotEmpty) {
      label = widget.label;
      floatingLabelBehavior = FloatingLabelBehavior.always;
      controller.text = widget.initialValue;
    }
    controller.addListener(() {
      _setFloatingLabelBehavior();
      _textValidation();
    });
  }

  void _setFloatingLabelBehavior() {
    setState(() {
      if (controller.text.isEmpty) {
        label = null;
        floatingLabelBehavior = FloatingLabelBehavior.never;
      } else {
        label = widget.label;
        floatingLabelBehavior = FloatingLabelBehavior.always;
      }
    });
  }

  void _textValidation() {
    setState(() {
      minEightCharacters = controller.text.length >= 8;
      containsLowerCase = controller.text.containsLowercase;
      containsUpperCase = controller.text.containsUppercase;
      containsNumber = controller.text.containsNumber;
    });
    widget.validPassword(minEightCharacters &&
            containsLowerCase &&
            containsUpperCase &&
            containsNumber
        ? true
        : false);
  }

  @override
  Widget build(BuildContext context) => Theme(
        data: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: AskLoraColors.primaryGreen,
              ),
        ),
        child: Column(
          children: [
            Focus(
                child: TextFormField(
                  controller: controller,
                  onChanged: widget.onChanged,
                  textCapitalization: widget.textCapitalization,
                  inputFormatters: widget.textInputFormatterList ??
                      [
                        LengthLimitingTextInputFormatter(16),
                        FilteringTextInputFormatter.deny(RegExp(r'\s'))
                      ],
                  obscureText: obscureText,
                  obscuringCharacter: '●',
                  style: TextFieldStyle.valueTextStyle,
                  decoration: TextFieldStyle.inputDecoration.copyWith(
                    floatingLabelBehavior: floatingLabelBehavior,
                    labelText: label,
                    hintText: widget.hintText,
                    errorText:
                        widget.errorText.isEmpty ? null : widget.errorText,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      child: UnconstrainedBox(
                        child: Padding(
                          padding: EdgeInsets.only(top: obscureText ? 2 : 0),
                          child: getSvgIcon(obscureText
                              ? 'icon_obscure_text_disable'
                              : 'icon_obscure_text_enable'),
                        ),
                      ),
                    ),
                  ),
                ),
                onFocusChange: (hasFocus) {
                  shouldShowErrorsTexts = hasFocus;
                }),
            if ((shouldShowErrorsTexts || controller.text.isNotEmpty) &&
                widget.isShowingPasswordValidation)
              ..._errorCheckWidgets,
          ],
        ),
      );

  List<Widget> get _errorCheckWidgets => [
        const SizedBox(
          height: 5,
        ),
        _errorWidget(
            label: S.of(context).min8Character,
            checkPassed: minEightCharacters),
        _errorWidget(
            label: S.of(context).atLeast1Lowercase,
            checkPassed: containsLowerCase),
        _errorWidget(
            label: S.of(context).atLeast1Uppercase,
            checkPassed: containsUpperCase),
        _errorWidget(
            label: S.of(context).atLeast1Number, checkPassed: containsNumber),
      ];

  Widget _errorWidget({required String label, bool checkPassed = false}) =>
      Padding(
        padding: const EdgeInsets.only(top: 3.0),
        child: Row(
          children: [
            Icon(
              checkPassed ? Icons.check : Icons.close,
              color: checkPassed
                  ? AskLoraColors.primaryGreen
                  : AskLoraColors.primaryMagenta,
              size: 12,
            ),
            const SizedBox(
              width: 4,
            ),
            CustomTextNew(
              label,
              style: AskLoraTextStyles.body3
                  .copyWith(color: AskLoraColors.darkGray),
            )
          ],
        ),
      );
}
