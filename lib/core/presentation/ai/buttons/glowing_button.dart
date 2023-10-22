import 'package:flutter/material.dart';

class GlowingButton extends StatelessWidget {
  final double width;
  final double height;
  final Color buttonBackgroundColor;
  final Color glowColor;
  final VoidCallback onTap;
  final Widget child;

  const GlowingButton({
    super.key,
    this.width = 60,
    this.height = 60,
    this.buttonBackgroundColor = const Color(0xFF373A49),
    this.glowColor = const Color(0xFF777AF9),
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: buttonBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: glowColor,
                blurRadius: 10,
                spreadRadius: 3,
              ),
            ],
          ),
          child: child,
        ),
        onTap: () => onTap(),
      );
}
