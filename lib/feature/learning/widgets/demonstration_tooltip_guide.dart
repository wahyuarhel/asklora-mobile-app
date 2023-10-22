import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/presentation/rotated_corner_decoration.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';

class DemonstrationTooltipGuide extends StatefulWidget {
  final Widget child;
  final String text;
  final double verticalOffset;
  final double horizontalOffset;
  final JustTheController tooltipController;
  final bool showImmediately;

  const DemonstrationTooltipGuide(
      {required this.tooltipController,
      required this.child,
      required this.text,
      this.verticalOffset = 0,
      this.horizontalOffset = 0,
      this.showImmediately = true,
      Key? key})
      : super(key: key);

  @override
  State<DemonstrationTooltipGuide> createState() =>
      _DemonstrationTooltipGuideState();
}

class _DemonstrationTooltipGuideState extends State<DemonstrationTooltipGuide> {
  @override
  void initState() {
    super.initState();
    if (widget.showImmediately) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.tooltipController.showTooltip(immediately: false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      fadeInDuration: const Duration(milliseconds: 500),
      fadeOutDuration: Duration.zero,
      elevation: 0,
      isModal: true,
      shadow: const Shadow(color: Colors.transparent),
      backgroundColor: Colors.transparent,
      barrierDismissible: false,
      tailLength: 0,
      controller: widget.tooltipController,
      tailBuilder: (Offset tip, Offset point2, Offset point3) {
        return Path();
      },
      content: Container(
        margin: EdgeInsets.only(
            left: widget.horizontalOffset, top: widget.verticalOffset),
        foregroundDecoration: const RotatedCornerDecoration(
          color: AskLoraColors.primaryMagenta,
          geometry: BadgeGeometry(
            cornerRadius: 0,
            width: 14,
            height: 14,
            alignment: BadgeAlignment.topLeft,
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 0.6,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(40),
              bottomRight: Radius.circular(40),
              bottomLeft: Radius.circular(40),
            )),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
        child: CustomTextNew(
          widget.text,
          style: AskLoraTextStyles.body2,
        ),
      ),
      child: widget.child,
    );
  }
}
