import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/chart_util.dart';

class AnimatedIconLabel extends StatefulWidget {
  final double left;
  final double top;
  final HedgeType hedgeType;
  final Duration animationDuration;
  final double height;
  final double width;
  final double animationLength;

  const AnimatedIconLabel({
    Key? key,
    required this.left,
    required this.top,
    required this.hedgeType,
    this.height = 40,
    this.width = 40,
    this.animationLength = 30,
    this.animationDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  State<AnimatedIconLabel> createState() => _AnimatedIconLabelState();
}

class _AnimatedIconLabelState extends State<AnimatedIconLabel> {
  bool show = false;

  @override
  void initState() {
    super.initState();
    animate();
  }

  void animate() async {
    await Future.delayed(Duration.zero);
    if (mounted) {
      setState(() {
        show = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        left: widget.left,
        top: show
            ? widget.hedgeType == HedgeType.sell
                ? widget.top
                : widget.top
            : widget.hedgeType == HedgeType.sell
                ? widget.top - widget.animationLength
                : widget.top + widget.animationLength,
        duration: widget.animationDuration,
        child: AnimatedOpacity(
            opacity: show ? 1 : 0,
            duration: widget.animationDuration,
            child: SizedBox(
              width: widget.width,
              height: widget.height,
              child: SvgPicture.asset(
                widget.hedgeType == HedgeType.buy
                    ? 'assets/buy_icon.svg'
                    : 'assets/sell_icon.svg',
              ),
            )));
  }
}
