import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../styles/asklora_colors.dart';
import '../../styles/asklora_text_styles.dart';
import '../custom_text_new.dart';
import 'style/text_field_style.dart';

class MasterTextField extends StatefulWidget {
  final TextCapitalization textCapitalization;
  final String initialValue;
  final List<TextInputFormatter>? textInputFormatterList;
  final int? maxLine;
  final String labelText;
  final String hintText;
  final String errorText;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final FloatingLabelBehavior floatingLabelBehavior;

  const MasterTextField(
      {Key? key,
      this.onChanged,
      this.onFieldSubmitted,
      this.textCapitalization = TextCapitalization.none,
      this.floatingLabelBehavior = FloatingLabelBehavior.never,
      this.initialValue = '',
      this.textInputFormatterList,
      this.labelText = '',
      this.hintText = '',
      this.errorText = '',
      this.textInputAction,
      this.textInputType,
      this.maxLine})
      : super(key: key);

  @override
  State<MasterTextField> createState() => _MasterTextFieldState();
}

class _MasterTextFieldState extends State<MasterTextField> {
  final TextEditingController controller = TextEditingController();
  late FloatingLabelBehavior floatingLabelBehavior;
  String? label;

  @override
  void initState() {
    super.initState();
    controller.text = widget.initialValue;
    if (widget.floatingLabelBehavior == FloatingLabelBehavior.always) {
      label = widget.labelText;
      floatingLabelBehavior = widget.floatingLabelBehavior;
    } else {
      floatingLabelBehavior = FloatingLabelBehavior.never;
      if (widget.initialValue.isNotEmpty) {
        label = widget.labelText;
        floatingLabelBehavior = FloatingLabelBehavior.always;
      }
      controller.addListener(() {
        _setFloatingLabelBehavior();
      });
    }
  }

  void _setFloatingLabelBehavior() {
    setState(() {
      if (controller.text.isEmpty) {
        label = null;
        floatingLabelBehavior = FloatingLabelBehavior.never;
      } else {
        label = widget.labelText;
        floatingLabelBehavior = FloatingLabelBehavior.always;
      }
    });
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
              onFieldSubmitted: widget.onFieldSubmitted,
              controller: controller,
              onChanged: widget.onChanged,
              keyboardType: widget.textInputType,
              textCapitalization: widget.textCapitalization,
              inputFormatters: widget.textInputFormatterList,
              maxLines: widget.maxLine,
              textInputAction: widget.textInputAction,
              style: TextFieldStyle.valueTextStyle,
              decoration: TextFieldStyle.inputDecoration.copyWith(
                floatingLabelBehavior: floatingLabelBehavior,
                labelText: label,
                hintText: widget.hintText,
              )),
          if (widget.errorText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 2, top: 5),
              child: CustomTextNew(
                widget.errorText,
                style: AskLoraTextStyles.body3
                    .copyWith(color: AskLoraColors.primaryMagenta),
              ),
            )
        ],
      );
}
