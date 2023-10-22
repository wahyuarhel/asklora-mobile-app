part of '../custom_key_pad.dart';

class CustomKeyPadButton extends StatefulWidget {
  final double width;
  final double height;
  final String value;
  final Function(String) onTap;

  const CustomKeyPadButton(
      {required this.width,
      required this.value,
      required this.height,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  State<CustomKeyPadButton> createState() => _CustomKeyPadButtonState();
}

class _CustomKeyPadButtonState extends State<CustomKeyPadButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(widget.value),
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      child: Container(
        constraints: const BoxConstraints(maxHeight: 50, minHeight: 30),
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _isPressed
                ? AskLoraColors.lightGreen
                : AskLoraColors.lightGray),
        child: Center(
            child: CustomTextNew(
          widget.value,
          style: AskLoraTextStyles.h3.copyWith(color: AskLoraColors.charcoal),
        )),
      ),
    );
  }
}
