import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomSnackBar {
  final BuildContext context;

  CustomSnackBar(this.context);

  late String _message = '';

  CustomSnackBar setMessage(String message) {
    _message = message;
    return this;
  }

  void _show(CustomSnackBarType type) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        backgroundColor:
            type == CustomSnackBarType.success ? Colors.green : Colors.red,
        content: CustomText(_message),
      ));
  }

  void showError() {
    _show(CustomSnackBarType.error);
  }

  void show() {
    _show(CustomSnackBarType.success);
  }
}

enum CustomSnackBarType { error, success }
