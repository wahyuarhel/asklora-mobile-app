import 'package:flutter/material.dart';

import '../../../../core/presentation/custom_text_new.dart';
import '../../../../core/styles/asklora_colors.dart';
import '../../../../core/styles/asklora_text_styles.dart';
import '../../utils/chart_util.dart';

class AnimatedProfitLabel extends StatefulWidget {
  final double left;
  final double top;
  final double profit;
  final HedgeType hedgeType;
  final Duration animationDuration;
  final Duration showDuration;
  final Duration delayDuration;
  final String additionalText;
  final bool hideProfit;

  const AnimatedProfitLabel(
      {Key? key,
      required this.left,
      required this.top,
      required this.profit,
      required this.hedgeType,
      this.hideProfit = true,
      this.additionalText = 'Profit/Loss',
      this.animationDuration = const Duration(milliseconds: 500),
      this.showDuration = const Duration(milliseconds: 1000),
      this.delayDuration = const Duration(milliseconds: 100)})
      : super(key: key);

  @override
  State<AnimatedProfitLabel> createState() => _AnimatedProfitLabelState();
}

class _AnimatedProfitLabelState extends State<AnimatedProfitLabel> {
  bool show = false;

  @override
  void initState() {
    super.initState();
    animate();
  }

  void animate() async {
    await Future.delayed(widget.delayDuration);
    if (mounted) {
      setState(() {
        show = true;
      });
    }

    await Future.delayed(widget.showDuration);
    if (mounted) {
      setState(() {
        if (widget.hideProfit) {
          show = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.profit == 0) {
      return const SizedBox.shrink();
    } else {
      return Positioned(
          left: widget.left,
          top: widget.top,
          child: AnimatedOpacity(
            opacity: show ? 1 : 0,
            duration: widget.animationDuration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextNew(
                  '${widget.profit > 0 ? '+' : ''}${widget.profit}%',
                  style: AskLoraTextStyles.h2.copyWith(
                      color: widget.hedgeType == HedgeType.buy
                          ? AskLoraColors.primaryMagenta
                          : AskLoraColors.primaryGreen),
                ),
                CustomTextNew(
                  widget.additionalText,
                  style: AskLoraTextStyles.subtitle3.copyWith(
                      color: widget.hedgeType == HedgeType.buy
                          ? AskLoraColors.primaryMagenta
                          : AskLoraColors.primaryGreen),
                ),
              ],
            ),
          ));
    }
  }

  List<Color> get getColor => widget.hedgeType == HedgeType.buy
      ? [const Color(0xffec6cfe), const Color(0xfff4a2fd)]
      : [const Color(0xff50ecbe), const Color(0xffacf8e1)];
}
