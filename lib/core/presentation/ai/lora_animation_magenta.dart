import 'package:flutter/material.dart';

class LoraAnimationMagenta extends StatelessWidget {
  final double height;
  final double width;
  const LoraAnimationMagenta({this.height = 170, this.width = 170, super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/apng/lora_animation_pink.png',
        height: height, width: width, filterQuality: FilterQuality.high);
  }
}
