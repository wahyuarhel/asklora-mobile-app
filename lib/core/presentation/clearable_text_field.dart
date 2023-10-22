import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles/asklora_colors.dart';
import '../styles/asklora_text_styles.dart';
import 'custom_text_new.dart';
import 'text_fields/style/text_field_style.dart';

class ClearableTextFormField extends FormField<String> {
  final TextEditingController? controller;
  final String labelText;
  final String hintText;
  final String errorText;
  final int? maxLength;
  final bool obscureText;
  final TextInputType textInputType;
  final Function(String) onChanged;
  final Function? onClear;
  final List<TextInputFormatter>? textInputFormatterList;
  final String initialValue;
  final Color? fillColor;
  final InputBorder inputBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final InputBorder? focusedBorder;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final Icon resetIcon;
  final Widget? prefix;

  ClearableTextFormField(
      {required this.labelText,
      required this.onChanged,
      required this.hintText,
      this.textInputType = TextInputType.text,
      this.obscureText = false,
      this.errorText = '',
      this.maxLength,
      this.onClear,
      this.textInputFormatterList,
      this.initialValue = '',
      this.fillColor,
      this.inputBorder = const OutlineInputBorder(),
      this.floatingLabelBehavior,
      this.enabledBorder,
      this.disabledBorder,
      this.focusedBorder,
      this.controller,
      this.resetIcon = const Icon(
        Icons.cancel,
        size: 20,
      ),
      this.prefix,
      Key? key})
      : super(
          key: key,
          initialValue: controller != null ? controller.text : initialValue,
          builder: (FormFieldState<String> field) {
            final _ClearableTextFormFieldState state =
                field as _ClearableTextFormFieldState;

            return Focus(
              onFocusChange: (hasFocus) => state.setHasFocus(hasFocus),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: state._effectiveController,
                    onChanged: (value) {
                      field.didChange(value);
                      onChanged(value);
                    },
                    obscureText: obscureText,
                    inputFormatters: textInputFormatterList,
                    maxLength: maxLength,
                    style: AskLoraTextStyles.body1,
                    decoration: TextFieldStyle.inputDecoration.copyWith(
                      floatingLabelBehavior: floatingLabelBehavior,
                      labelText: labelText,
                      counterText: '',
                      hintText: hintText,
                      prefixIcon: prefix,
                      suffixIcon:
                          ((field.value?.length ?? -1) > 0 && state.hasFocus)
                              ? IconButton(
                                  icon: resetIcon,
                                  onPressed: () {
                                    state.clear();
                                    onChanged('');
                                    if (onClear != null) {
                                      onClear();
                                    }
                                  },
                                  color: Theme.of(state.context).hintColor,
                                )
                              : null,
                    ),
                    keyboardType: textInputType,
                  ),
                  if (errorText.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 2, top: 5),
                      child: CustomTextNew(
                        errorText,
                        style: AskLoraTextStyles.body3
                            .copyWith(color: AskLoraColors.primaryMagenta),
                      ),
                    )
                ],
              ),
            );
          },
        );

  @override
  FormFieldState<String> createState() => _ClearableTextFormFieldState();
}

class _ClearableTextFormFieldState extends FormFieldState<String> {
  TextEditingController? _controller;
  bool hasFocus = false;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller!;

  @override
  ClearableTextFormField get widget => super.widget as ClearableTextFormField;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(ClearableTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller =
            TextEditingController.fromValue(oldWidget.controller!.value);
      }
      if (widget.controller != null) {
        setValue(widget.controller!.text);
        if (oldWidget.controller == null) _controller = null;
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);
    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void reset() {
    _effectiveController.text = widget.initialValue;
    super.reset();
  }

  void setHasFocus(bool b) => setState(() => hasFocus = b);

  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }

  void clear() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _effectiveController.clear();
      didChange(null);
    });
  }
}
