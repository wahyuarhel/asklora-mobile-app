part of '../custom_key_pad.dart';

class CustomDeleteKeyPad extends StatelessWidget {
  final VoidCallback onTap;
  final double width;
  final double height;

  const CustomDeleteKeyPad(
      {required this.onTap,
      required this.width,
      required this.height,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 50, minHeight: 30),
        height: height,
        width: width,
        child: const Center(
          child: Icon(
            Icons.backspace_outlined,
            color: AskLoraColors.charcoal,
          ),
        ),
      ),
    );
  }
}
