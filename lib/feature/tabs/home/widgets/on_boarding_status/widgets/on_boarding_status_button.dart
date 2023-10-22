part of '../on_boarding_status.dart';

class OnBoardingStatusButton extends StatefulWidget {
  final VoidCallback onTap;
  final int arrowPointingOnSection;
  final int intersectCount;
  final String subTitle;

  const OnBoardingStatusButton(
      {required this.arrowPointingOnSection,
      required this.onTap,
      required this.intersectCount,
      required this.subTitle,
      Key? key})
      : super(key: key);

  @override
  State<OnBoardingStatusButton> createState() => _OnBoardingStatusButtonState();
}

class _OnBoardingStatusButtonState extends State<OnBoardingStatusButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      const triangleWidth = 20;
      return GestureDetector(
        onTapDown: (_) => setState(() {
          _isPressed = true;
        }),
        onTapUp: (_) => setState(() {
          _isPressed = false;
        }),
        onTapCancel: () => setState(() {
          _isPressed = false;
        }),
        onTap: widget.onTap,
        child: Stack(
          children: [
            Positioned(
              left: (constraints.maxWidth *
                      (1 + (widget.arrowPointingOnSection - 1) * 2) /
                      ((widget.intersectCount + 1) * 2) -
                  triangleWidth / 2),
              child: ClipPath(
                clipper: TriangleClipper(),
                child: Container(
                  color: _isPressed
                      ? AskLoraColors.darkGray
                      : AskLoraColors.charcoal,
                  height: 10,
                  width: 20,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 9),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(43),
                  color: _isPressed
                      ? AskLoraColors.darkGray
                      : AskLoraColors.charcoal),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextNew(
                          S.of(context).nextStep,
                          style: AskLoraTextStyles.subtitleAllCap1.copyWith(
                              color: AskLoraColors.white, letterSpacing: 1),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextNew(
                          widget.subTitle,
                          style: AskLoraTextStyles.h6
                              .copyWith(color: AskLoraColors.white),
                        ),
                      ],
                    ),
                  ),
                  CustomTextNew(
                    S.of(context).go,
                    style: AskLoraTextStyles.button2
                        .copyWith(color: AskLoraColors.primaryGreen),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AskLoraColors.primaryGreen,
                    size: 10,
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
