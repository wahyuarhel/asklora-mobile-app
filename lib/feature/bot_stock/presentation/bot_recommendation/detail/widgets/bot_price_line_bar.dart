import 'package:flutter/material.dart';

import '../../../../../../core/presentation/custom_text_new.dart';
import '../../../../../../core/styles/asklora_colors.dart';
import '../../../../../../core/styles/asklora_text_styles.dart';

class BotPriceLineBar extends StatelessWidget {
  final double stopLossPrice;
  final double takeProfitPrice;
  final double currentPrice;
  final double labelTopPadding = 18;
  final Size dotSize = const Size(10, 10);

  const BotPriceLineBar(
      {required this.stopLossPrice,
      required this.takeProfitPrice,
      required this.currentPrice,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double tPSubtractAbs = (takeProfitPrice - currentPrice).abs();
      double sLSubtractAbs = (stopLossPrice - currentPrice).abs();
      double edgeMaxPrice = tPSubtractAbs > sLSubtractAbs
          ? (currentPrice + tPSubtractAbs + 50)
          : (currentPrice + sLSubtractAbs + 50);

      double edgeMinPrice = tPSubtractAbs > sLSubtractAbs
          ? (currentPrice - tPSubtractAbs - 50)
          : (currentPrice - sLSubtractAbs - 50);
      double totalLengthBeforeTranslation = edgeMaxPrice - edgeMinPrice;
      double widthConstraint = constraints.maxWidth;
      double stopLossLeftMargin = (stopLossPrice - edgeMinPrice) /
          totalLengthBeforeTranslation *
          widthConstraint;

      double currentPriceLeftMargin =
          ((currentPrice - edgeMinPrice) / totalLengthBeforeTranslation) *
              widthConstraint;
      double takeProfitPriceLeftMargin =
          ((takeProfitPrice - edgeMinPrice) / totalLengthBeforeTranslation) *
              widthConstraint;

      double lineLength =
          ((takeProfitPrice - stopLossPrice) / totalLengthBeforeTranslation) *
              widthConstraint;

      double stopLossLeftMarginMinusTextWidth = stopLossLeftMargin -
          _textSize(stopLossPrice.toStringAsFixed(1), AskLoraTextStyles.body4)
                  .width /
              2;

      double takeProfitLeftMarginMinusTextWidth = takeProfitPriceLeftMargin -
          _textSize(takeProfitPrice.toStringAsFixed(1), AskLoraTextStyles.body4)
                  .width /
              2;

      return SizedBox(
          height: 40,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 4),
                height: 1,
                width: double.infinity,
                color: AskLoraColors.lightGray,
              ),
              Positioned(
                  left: stopLossLeftMargin,
                  child: Container(
                    margin: const EdgeInsets.only(top: 3),
                    height: 3,
                    width: lineLength,
                    decoration: BoxDecoration(
                        color: AskLoraColors.primaryMagenta,
                        borderRadius: BorderRadius.circular(100),
                        border:
                            Border.all(color: AskLoraColors.primaryMagenta)),
                  )),
              Positioned(
                  top: labelTopPadding,
                  left: stopLossLeftMarginMinusTextWidth -
                      (stopLossLeftMarginMinusTextWidth >
                              currentPriceLeftMargin -
                                  _textSize(currentPrice.toStringAsFixed(1),
                                          AskLoraTextStyles.body4)
                                      .width
                          ? _textSize(currentPrice.toStringAsFixed(1),
                                      AskLoraTextStyles.body4)
                                  .width -
                              dotSize.width / 2 +
                              dotSize.width / 2 -
                              (stopLossLeftMargin - currentPriceLeftMargin)
                                  .abs()
                          : 0),
                  child: CustomTextNew(
                    stopLossPrice.toStringAsFixed(1),
                    style: AskLoraTextStyles.body4,
                  )),
              Positioned(
                  left: currentPriceLeftMargin,
                  child: Container(
                    height: dotSize.height,
                    width: dotSize.width,
                    decoration: const BoxDecoration(
                        color: AskLoraColors.primaryMagenta,
                        shape: BoxShape.circle),
                  )),
              Positioned(
                  top: labelTopPadding,
                  left: currentPriceLeftMargin -
                      _textSize(currentPrice.toStringAsFixed(1),
                                  AskLoraTextStyles.body4)
                              .width /
                          2 +
                      dotSize.width / 2,
                  child: CustomTextNew(
                    currentPrice.toStringAsFixed(1),
                    style: AskLoraTextStyles.body4,
                  )),
              Positioned(
                  top: labelTopPadding,
                  left: takeProfitLeftMarginMinusTextWidth +
                      (takeProfitLeftMarginMinusTextWidth <
                              currentPriceLeftMargin +
                                  _textSize(currentPrice.toStringAsFixed(1),
                                              AskLoraTextStyles.body4)
                                          .width /
                                      2
                          ? (_textSize(currentPrice.toStringAsFixed(1),
                                          AskLoraTextStyles.body4)
                                      .width +
                                  dotSize.width) -
                              (takeProfitPriceLeftMargin -
                                      currentPriceLeftMargin)
                                  .abs()
                          : 0),
                  child: CustomTextNew(
                    takeProfitPrice.toStringAsFixed(1),
                    style: AskLoraTextStyles.body4,
                  )),
            ],
          ));
    });
  }

  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
