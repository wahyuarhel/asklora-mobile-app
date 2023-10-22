import 'package:flutter/material.dart';

class CustomAnimatedOpacity extends StatefulWidget {
  final Duration animationDuration;
  final Duration delayDuration;
  final Widget child;

  const CustomAnimatedOpacity(
      {this.animationDuration = const Duration(milliseconds: 500),
      this.delayDuration = const Duration(milliseconds: 500),
      required this.child,
      Key? key})
      : super(key: key);

  @override
  State<CustomAnimatedOpacity> createState() => _CustomAnimatedOpacityState();
}

class _CustomAnimatedOpacityState extends State<CustomAnimatedOpacity> {
  bool show = false;

  @override
  void initState() {
    super.initState();
    animateFadeIn();
  }

  void animateFadeIn() async {
    await Future.delayed(widget.delayDuration);
    if (mounted) {
      setState(() {
        show = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: show ? 1 : 0,
      duration: widget.animationDuration,
      child: widget.child,
    );
  }
}
