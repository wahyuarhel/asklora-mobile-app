import 'package:flutter/material.dart';

import 'animated_text.dart';

/// Animated Text that displays a [Text] element as if it is being typed one
/// character at a time.
///
/// ![Typer example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/typer.gif)
class TyperAnimatedText extends AnimatedText {
  /// The [Duration] of the delay between the apparition of each characters
  ///
  /// By default it is set to 40 milliseconds.
  final Duration speed;

  /// The [Curve] of the rate of change of animation over time.
  ///
  /// By default it is set to Curves.linear.
  final Curve curve;

  TyperAnimatedText(
    String text, {
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    this.speed = const Duration(milliseconds: 20),
    this.curve = Curves.linear,
  }) : super(
          text: text,
          textAlign: textAlign,
          textStyle: textStyle,
          duration: speed * text.characters.length,
        );

  late Animation<double> _typingText;

  @override
  Duration get remaining => speed * (textCharacters.length - _typingText.value);

  @override
  void initAnimation(AnimationController controller) {
    _typingText = CurveTween(
      curve: curve,
    ).animate(controller);
  }

  /// Widget showing partial text, up to [count] characters
  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    /// Output of CurveTween is in the range [0, 1] for majority of the curves.
    /// It is converted to [0, textCharacters.length].
    final count =
        (_typingText.value.clamp(0, 1) * textCharacters.length).round();

    assert(count <= textCharacters.length);
    return textWidget(textCharacters.take(count).toString());
  }
}
