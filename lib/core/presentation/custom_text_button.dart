import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final bool isLoading;
  final bool disable;
  final String buttonText;
  final Function onClick;
  final Color primaryColor;
  final double borderRadius;
  final double? height;
  final double? width;
  final EdgeInsets? padding;

  const CustomTextButton(
      {required this.buttonText,
      required this.onClick,
      this.primaryColor = Colors.lightBlueAccent,
      this.borderRadius = 0,
      this.isLoading = false,
      this.disable = false,
      this.height,
      this.width,
      this.padding,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: height,
      width: width,
      constraints: const BoxConstraints(minHeight: 55, minWidth: 55),
      child: isLoading
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () => disable ? null : onClick(),
              style: ElevatedButton.styleFrom(
                  primary: disable ? Colors.white38 : primaryColor,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  minimumSize: const Size.fromHeight(50)),
              child: Text(buttonText),
            ),
    );
  }
}
