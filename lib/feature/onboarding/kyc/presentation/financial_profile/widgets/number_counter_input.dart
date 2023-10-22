import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/presentation/custom_text_new.dart';
import '../../../../../../core/styles/asklora_colors.dart';
import '../../../../../../core/styles/asklora_text_styles.dart';
import '../../../bloc/source_of_wealth/source_of_wealth_bloc.dart';
import '../../../utils/numerical_range_formatter.dart';
import '../../../utils/source_of_wealth_enum.dart';

class NumberCounterInput extends StatefulWidget {
  final SourceOfWealthType sourceOfWealthType;
  final String initialValue;
  final bool active;
  final VoidCallback onTap;
  final Function(String?) onAmountChanged;

  const NumberCounterInput({
    required this.sourceOfWealthType,
    this.active = false,
    this.initialValue = '',
    required this.onAmountChanged,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<NumberCounterInput> createState() => _NumberCounterInputState();
}

class _NumberCounterInputState extends State<NumberCounterInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void didUpdateWidget(covariant NumberCounterInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _controller.text = widget.initialValue;
      widget.onAmountChanged(_controller.text);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue;
    _controller.addListener(() {
      widget.onAmountChanged(_controller.text.isEmpty ? '0' : _controller.text);
      _controller.selection =
          TextSelection.collapsed(offset: _controller.text.length);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.selection =
        TextSelection.collapsed(offset: _controller.text.length);

    return _cardButton(children: [
      _counterButton(
          label: '-',
          onTap: () => context.read<SourceOfWealthBloc>().add(
              SourceOfWealthDecrementAmountChanged(widget.sourceOfWealthType))),
      _numberInput(),
      _counterButton(
          label: '+',
          onTap: () => context.read<SourceOfWealthBloc>().add(
              SourceOfWealthIncrementAmountChanged(widget.sourceOfWealthType))),
    ]);
  }

  Widget _cardButton({required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Material(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: widget.active ? 3 : 1,
            color:
                widget.active ? AskLoraColors.primaryGreen : AskLoraColors.gray,
          ),
        ),
        color: widget.active ? AskLoraColors.lightGreen : AskLoraColors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          focusColor: AskLoraColors.lightGreen,
          splashColor: AskLoraColors.lightGreen,
          highlightColor: AskLoraColors.lightGreen,
          onTap: widget.onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: 20, vertical: widget.active ? 10 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextNew(
                  widget.sourceOfWealthType.name,
                  style: AskLoraTextStyles.subtitle2,
                ),
                widget.active
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: children,
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _counterButton({required String label, required VoidCallback onTap}) {
    return Material(
      borderRadius: BorderRadius.circular(15),
      color: AskLoraColors.black,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 30,
          width: 30,
          child: CustomTextNew(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 20, color: AskLoraColors.primaryGreen),
          ),
        ),
      ),
    );
  }

  Widget _numberInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: SizedBox(
        width: 82,
        height: 40,
        child: TextField(
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            NumericalRangeFormatter(min: 0, max: 100)
          ],
          maxLengthEnforcement: MaxLengthEnforcement.none,
          controller: _controller,
          style: AskLoraTextStyles.body1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          onChanged: (str) {
            _controller.text = str;
          },
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: '0',
            filled: true,
            fillColor: AskLoraColors.white,
            contentPadding: const EdgeInsets.all(10),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 1, color: AskLoraColors.darkGray)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 1, color: AskLoraColors.darkGray)),
            suffixText: '%',
          ),
        ),
      ),
    );
  }
}
