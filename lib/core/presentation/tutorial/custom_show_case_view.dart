import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../generated/l10n.dart';
import '../../styles/asklora_colors.dart';
import '../../styles/asklora_text_styles.dart';
import '../custom_text_new.dart';

enum PointerPosition {
  top,
  bottom,
}

class CustomShowcaseView extends StatelessWidget {
  final GlobalKey tutorialKey;
  final Widget child;
  final Widget tooltipWidget;
  final VoidCallback? onToolTipClick;
  final TooltipPosition tooltipPosition;
  final BorderRadius targetBorderRadius;
  final EdgeInsets targetPadding;
  final EdgeInsets margin;

  final double overlayOpacity;
  final Color overlayColor;
  final PointerPosition pointerPosition;
  final BoxShadow? boxShadow;
  const CustomShowcaseView({
    Key? key,
    required this.tutorialKey,
    required this.child,
    required this.tooltipWidget,
    this.onToolTipClick,
    this.tooltipPosition = TooltipPosition.bottom,
    this.targetPadding = const EdgeInsets.all(10),
    this.targetBorderRadius = const BorderRadius.all(Radius.circular(20)),
    this.overlayColor = Colors.black,
    this.overlayOpacity = 0.8,
    this.pointerPosition = PointerPosition.bottom,
    this.margin = const EdgeInsets.only(top: 10),
    this.boxShadow,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Showcase.withWidget(
      onBarrierClick: onToolTipClick,
      onTargetClick: onToolTipClick,
      tooltipPosition: tooltipPosition,
      key: tutorialKey,
      overlayColor: overlayColor,
      overlayOpacity: overlayOpacity,
      targetPadding: targetPadding,
      boxShadow: boxShadow,
      width: MediaQuery.of(context)
          .size
          .width, //* container width for tooltip widget
      height: 0,
      targetBorderRadius: targetBorderRadius,
      container: GestureDetector(
        onTap: onToolTipClick,
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              if (pointerPosition == PointerPosition.top)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _tapAnyWhereButton(context),
                ),
              GestureDetector(
                onTap: onToolTipClick,
                child: Container(
                    margin: tooltipPosition == TooltipPosition.top
                        ? EdgeInsets.zero
                        : margin,
                    width: MediaQuery.of(context).size.width -
                        30, //* width of tooltip widget
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    decoration: BoxDecoration(
                      color: AskLoraColors.lightGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: tooltipWidget),
              ),
              if (pointerPosition == PointerPosition.bottom)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: _tapAnyWhereButton(context),
                )
            ],
          ),
        ),
      ),
      child: child,
    );
  }

  Widget _tapAnyWhereButton(BuildContext context) => GestureDetector(
        onTap: onToolTipClick,
        child: CustomTextNew(
          S.of(context).tapAnyWhere,
          style:
              AskLoraTextStyles.subtitle2.copyWith(color: AskLoraColors.white),
        ),
      );
}
