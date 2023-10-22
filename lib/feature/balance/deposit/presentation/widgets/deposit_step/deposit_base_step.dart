part of '../../deposit_screen.dart';

class DepositBaseStep extends StatelessWidget {
  final List<Widget> contents;
  final bool drawLine;

  const DepositBaseStep(
      {required this.contents, this.drawLine = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomStep(
      spaceHorizontal: 30,
      widgetIcon: Container(
        height: 18,
        width: 18,
        decoration: BoxDecoration(
            color: AskLoraColors.white,
            shape: BoxShape.circle,
            border: Border.all(width: 2, color: AskLoraColors.primaryGreen)),
      ),
      drawLine: drawLine,
      widgetStep: RoundColoredBox(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: contents,
        ),
      ),
    );
  }
}
