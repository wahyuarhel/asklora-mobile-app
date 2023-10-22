import 'package:flutter/material.dart';

import '../../../../core/presentation/custom_text_new.dart';
import '../../../../core/styles/asklora_colors.dart';
import '../../../../core/styles/asklora_text_styles.dart';
import '../../../../core/utils/currency_enum.dart';

class CurrencyDropdown extends StatelessWidget {
  final void Function(CurrencyType?) onChanged;
  final CurrencyType initialValue;

  const CurrencyDropdown({
    Key? key,
    required this.onChanged,
    required this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      child: DropdownButtonFormField(
          value: initialValue,
          elevation: 2,
          isExpanded: true,
          icon: UnconstrainedBox(
            constrainedAxis: Axis.vertical,
            child: Container(
              height: 25,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  border: Border.all(color: AskLoraColors.gray),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: AskLoraColors.lightGray, shape: BoxShape.circle),
                    padding: const EdgeInsets.only(
                        top: 2, bottom: 3, left: 6, right: 6),
                    child: CustomTextNew(
                      '\$',
                      style: AskLoraTextStyles.subtitle4,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  CustomTextNew(
                    initialValue.name,
                    style: AskLoraTextStyles.subtitleAllCap1,
                  )
                ],
              ),
            ),
          ),
          decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero),
          items: CurrencyType.values
              .map((item) => DropdownMenuItem<CurrencyType>(
                    value: item,
                    child: CustomTextNew(
                      item.name,
                      style: AskLoraTextStyles.body4,
                    ),
                  ))
              .toList(),
          onChanged: (CurrencyType? newValue) {
            onChanged(newValue);
          }),
    );
  }
}
