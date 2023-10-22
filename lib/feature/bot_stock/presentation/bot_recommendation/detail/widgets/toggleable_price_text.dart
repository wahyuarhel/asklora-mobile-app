import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/presentation/custom_text_new.dart';
import '../../../../../../core/styles/asklora_colors.dart';
import '../../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../../core/utils/extensions.dart';
import '../../../../../../core/utils/storage/shared_preference.dart';
import '../../../../bloc/toggleable_price_text_bloc.dart';

class ToggleablePriceText extends StatelessWidget {
  final Color fillColor;
  final String percentDifference;
  final String priceDifference;
  final TextStyle toggleableTextStyle =
      AskLoraTextStyles.subtitle3.copyWith(color: AskLoraColors.white);

  ToggleablePriceText({
    Key? key,
    required this.percentDifference,
    required this.priceDifference,
    required this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ToggleablePriceTextBloc>(
      create: (_) =>
          ToggleablePriceTextBloc(sharedPreference: SharedPreference()),
      child: BlocBuilder<ToggleablePriceTextBloc, ToggleState>(
        buildWhen: (previous, current) =>
            previous.showPriceDifference != current.showPriceDifference,
        builder: (context, state) => GestureDetector(
          onTap: () => context
              .read<ToggleablePriceTextBloc>()
              .add(TogglePriceDifferenceEvent()),
          child: Container(
            width: containerWidth,
            padding: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: fillColor,
            ),
            child: CustomTextNew(
              state.showPriceDifference ? priceDifference : percentDifference,
              style: toggleableTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  double get containerWidth =>
      max(
        percentDifference.textWidth(toggleableTextStyle),
        priceDifference.textWidth(toggleableTextStyle),
      ) +
      10;
}
