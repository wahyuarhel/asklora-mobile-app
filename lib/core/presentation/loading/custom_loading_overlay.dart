import 'dart:ui';

import 'package:flutter/material.dart';

import '../../domain/base_response.dart';
import 'jumping_dots_widget.dart';

class CustomLoadingOverlay {
  static bool _isShowing = false;
  BuildContext context;

  bool show(ResponseState state) {
    state == ResponseState.loading ? appear() : dismiss();
    return _isShowing;
  }

  void dismiss() {
    if (_isShowing) {
      _isShowing = !_isShowing;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void appear() {
    dismiss();
    _isShowing = !_isShowing;
    showDialog(
        context: context,
        barrierColor: Colors.transparent,
        useSafeArea: false,
        barrierDismissible: false,
        builder: (ctx) => WillPopScope(
              onWillPop: () async => false,
              child: Material(
                color: Colors.white70,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: JumpingDotsWidget(
                    color: Colors.yellow,
                    radius: 30,
                    numberOfDots: 3,
                    animationDuration: const Duration(milliseconds: 300),
                  ),
                ),
              ),
            ));
  }

  Future<T> during<T>(Future<T> future) {
    appear();
    return future.whenComplete(() => dismiss());
  }

  factory CustomLoadingOverlay(BuildContext context) {
    return CustomLoadingOverlay._create(context);
  }

  CustomLoadingOverlay._create(this.context);

  factory CustomLoadingOverlay.of(BuildContext context) {
    return CustomLoadingOverlay._create(context);
  }
}
