import 'package:flutter/material.dart';

import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../core/utils/currency_enum.dart';

class CurrencyToggleButton extends StatefulWidget {
  final Function(CurrencyType) onChanged;

  const CurrencyToggleButton({required this.onChanged, super.key});

  @override
  State<CurrencyToggleButton> createState() => _CurrencyToggleButtonState();
}

class _CurrencyToggleButtonState extends State<CurrencyToggleButton>
    with SingleTickerProviderStateMixin {
  final Duration animationDuration = const Duration(milliseconds: 300);
  CurrencyType currencyType = CurrencyType.hkd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (currencyType == CurrencyType.hkd) {
            currencyType = CurrencyType.usd;
          } else {
            currencyType = CurrencyType.hkd;
          }
          widget.onChanged(currencyType);
        });
      },
      child: Container(
        transform: Matrix4.translationValues(0, -8, 0),
        width: 55,
        height: 26,
        decoration: BoxDecoration(
            color: AskLoraColors.white,
            border: Border.all(color: AskLoraColors.gray),
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(2),
        child: Stack(
          children: [
            AnimatedPositioned(
              left: currencyType == CurrencyType.hkd ? 25 : 5,
              duration: animationDuration,
              child: Padding(
                padding: const EdgeInsets.only(top: 2.5),
                child: CustomTextNew(
                  currencyType.name,
                  style: AskLoraTextStyles.subtitleAllCap1,
                ),
              ),
            ),
            AnimatedPositioned(
              left: currencyType == CurrencyType.hkd ? 0 : 30,
              duration: animationDuration,
              child: Container(
                decoration: const BoxDecoration(
                    color: AskLoraColors.lightGray, shape: BoxShape.circle),
                padding:
                    const EdgeInsets.only(top: 2, bottom: 3, left: 6, right: 6),
                child: CustomTextNew(
                  '\$',
                  style: AskLoraTextStyles.subtitle4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
