import 'package:flutter/material.dart';

import 'animated_text.dart';

/// Animated Text that rotates a [Text] in and then out.
///
/// ![Rotate example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/rotate.gif)
class RotateAnimatedText extends AnimatedText {
  /// Transition height.
  ///
  /// By default it is set to [TextStyle.fontSize] * 10 / 3.
  final double? transitionHeight;

  /// Adds [AlignmentGeometry] property to the text in the widget.
  ///
  /// By default it is set to [Alignment.center]
  final AlignmentGeometry alignment;

  /// Specifies the [TextDirection] for resolving alignment.
  ///
  /// By default it is set to [TextDirection.ltr]
  final TextDirection textDirection;

  /// Controls whether the text:
  /// * rotates in _and_ out (true), or
  /// * just rotates _in_ (false).
  ///
  /// Note that you may want to adjust the [duration] when mixing
  /// [RotateAnimatedText] instances with mixed [rotateOut] values.
  ///
  /// By default, it is set to true.
  final bool rotateOut;

  RotateAnimatedText(
    String text, {
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    Duration duration = const Duration(milliseconds: 2000),
    this.transitionHeight,
    this.alignment = Alignment.center,
    this.textDirection = TextDirection.ltr,
    this.rotateOut = true,
  }) : super(
          text: text,
          textAlign: textAlign,
          textStyle: textStyle,
          duration: duration,
        );

  late Animation<double> _fadeIn, _fadeOut;
  late Animation<Alignment> _slideIn, _slideOut;

  @override
  void initAnimation(AnimationController controller) {
    final direction = textDirection;

    final inIntervalEnd = rotateOut ? 0.4 : 1.0;

    _slideIn = AlignmentTween(
      begin: Alignment.center.add(alignment).resolve(direction),
      end: Alignment.topCenter.add(alignment).resolve(direction),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, inIntervalEnd, curve: Curves.decelerate),
      ),
    );

    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, inIntervalEnd, curve: Curves.easeOut),
      ),
    );

    if (rotateOut) {
      _slideOut = AlignmentTween(
        begin: Alignment.center.add(alignment).resolve(direction),
        end: Alignment.bottomCenter.add(alignment).resolve(direction),
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.7, 1.0, curve: Curves.linear),
        ),
      );

      _fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
        ),
      );
    }
  }

  @override
  Widget completeText(BuildContext context) =>
      rotateOut ? const SizedBox.shrink() : super.completeText(context);

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    final fontSize =
        textStyle?.fontSize ?? DefaultTextStyle.of(context).style.fontSize;

    return SizedBox(
      height: transitionHeight ?? (fontSize! * 10 / 5),
      child: AlignTransition(
        alignment: _slideIn.value.y != 0.0 || !rotateOut ? _slideIn : _slideOut,
        child: Opacity(
          opacity: _fadeIn.value != 1.0 || !rotateOut
              ? _fadeIn.value
              : _fadeOut.value,
          child: textWidget(text),
        ),
      ),
    );
  }
}
