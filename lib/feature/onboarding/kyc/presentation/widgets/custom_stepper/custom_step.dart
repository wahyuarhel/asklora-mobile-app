part of 'custom_stepper.dart';

class CustomStep extends StatelessWidget {
  final String svgAssetName;
  final bool drawLine;
  final String? label;
  final Widget? widgetStep;
  final Widget? widgetIcon;
  final double spaceHorizontal;
  final double spaceVertical;

  const CustomStep(
      {this.svgAssetName = 'inactive_step_icon',
      this.drawLine = false,
      this.label,
      this.widgetStep,
      this.widgetIcon,
      this.spaceHorizontal = 20,
      this.spaceVertical = 20,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LayoutBuilder(builder: (context, constraints) {
          return Container(
            margin: const EdgeInsets.only(left: 9),
            width: constraints.maxWidth,
            child: UnconstrainedBox(
              constrainedAxis: Axis.horizontal,
              child: drawLine
                  ? CustomPaint(
                      painter: DashedLineVerticalPainter(),
                      child: _drawContent,
                    )
                  : _drawContent,
            ),
          );
        }),
        Container(
            transform: Matrix4.translationValues(0, -2, 0),
            child:
                widgetIcon ?? getSvgIcon(svgAssetName, height: 18, width: 18)),
      ],
    );
  }

  Widget get _drawContent => Container(
        transform: Matrix4.translationValues(0, -4, 0),
        margin: EdgeInsets.only(
          left: spaceHorizontal,
          bottom: drawLine ? spaceVertical : 0,
        ),
        child: widgetStep ??
            CustomTextNew(
              label ?? '',
              style: AskLoraTextStyles.body1
                  .copyWith(color: AskLoraColors.charcoal),
            ),
      );
}

class DashedLineVerticalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 2, dashSpace = 2, startY = 0;
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 0.5;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
