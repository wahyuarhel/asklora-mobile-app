import 'dart:async';

import 'package:flutter/material.dart';

import '../../utils/app_icons.dart';

class TutorialTouchGuide extends StatefulWidget {
  const TutorialTouchGuide({super.key});

  @override
  State<TutorialTouchGuide> createState() => _TutorialTouchGuideState();
}

class _TutorialTouchGuideState extends State<TutorialTouchGuide> {
  final Duration duration = const Duration(milliseconds: 600);
  late Timer timer;
  bool startAnimation = false;

  @override
  void initState() {
    animate();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void animate() {
    ///slight delayed before start animation by 100ms
    Future.delayed(const Duration(milliseconds: 100))
        .then((_) => setState(() => startAnimation = !startAnimation));

    ///start recurring animation every 'Duration'
    timer = Timer.periodic(
      duration,
      (_) => setState(() => startAnimation = !startAnimation),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 70,
      child: AnimatedOpacity(
        opacity: startAnimation ? 1 : 0.8,
        duration: duration,
        child: Stack(
          children: [
            AnimatedPositioned(
                top: startAnimation ? 6 : 0,
                duration: duration,
                curve: Curves.fastOutSlowIn,
                child: getSvgIcon('icon_hand_touch_guide')),
          ],
        ),
      ),
    );
  }
}
