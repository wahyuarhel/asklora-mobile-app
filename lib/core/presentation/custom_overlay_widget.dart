import 'package:flutter/material.dart';

class CustomOverlayWidget {
  static final CustomOverlayWidget _singleton = CustomOverlayWidget._internal();

  factory CustomOverlayWidget() {
    return _singleton;
  }

  CustomOverlayWidget._internal();

  static OverlayState? overlayState;
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  static void show(BuildContext context, Widget widget) async {
    dismiss();
    overlayState = Overlay.of(context);

    _overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Positioned(child: widget));
    _isVisible = true;
    overlayState?.insert(_overlayEntry!);
  }

  static dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }
}
