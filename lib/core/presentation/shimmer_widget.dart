import 'package:flutter/material.dart';

import '../styles/asklora_colors.dart';
import 'shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  const ShimmerWidget({required this.width, required this.height, super.key});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: AskLoraColors.gray.withOpacity(0.2),
        highlightColor: AskLoraColors.gray,
        child: Container(
          decoration: BoxDecoration(
              color: AskLoraColors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20)),
          height: height,
          width: width,
        ),
      );
}
