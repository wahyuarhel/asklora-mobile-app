import 'dart:async';

import 'package:flutter/material.dart';

import '../styles/asklora_colors.dart';
import '../styles/asklora_text_styles.dart';
import '../utils/app_icons.dart';
import 'custom_text_new.dart';

///TODO : LATER DIVERSIFY TYPE BY SOMETHING MORE RELEVANT
enum PopupType {
  pink,
  grey,
}

class CustomInAppNotification {
  static final CustomInAppNotification _singleton =
      CustomInAppNotification._internal();

  factory CustomInAppNotification() {
    return _singleton;
  }

  CustomInAppNotification._internal();

  static OverlayState? overlayState;
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  static void show(BuildContext context, String message,
      {PopupType type = PopupType.pink}) {
    dismiss();
    overlayState = Overlay.of(context);

    _overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Positioned(
            child: DefaultTextStyle(
                style: const TextStyle(decoration: TextDecoration.none),
                child: CustomInAppNotificationWidget(
                  message: message,
                  onDismiss: () => dismiss(),
                  type: type,
                ))));
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

class CustomInAppNotificationWidget extends StatefulWidget {
  const CustomInAppNotificationWidget({
    super.key,
    required this.message,
    this.onDismiss,
    this.type = PopupType.pink,
  });

  final String message;
  final VoidCallback? onDismiss;
  final PopupType? type;

  @override
  State<StatefulWidget> createState() => _CustomInAppNotificationWidgetState();
}

class _CustomInAppNotificationWidgetState
    extends State<CustomInAppNotificationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> position;
  late Timer timer;
  late Animation<double> animationGreyPopup;

  @override
  void initState() {
    super.initState();
    switch (widget.type) {
      case PopupType.grey:
        controller = AnimationController(
            vsync: this, duration: const Duration(milliseconds: 300));
        animationGreyPopup = Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInOutQuint));
      default:
        controller = AnimationController(
            vsync: this, duration: const Duration(milliseconds: 750));
        position =
            Tween<Offset>(begin: const Offset(0.0, -4.0), end: Offset.zero)
                .animate(CurvedAnimation(
                    parent: controller, curve: Curves.linearToEaseOut));
    }
    controller.forward();
    timer = Timer(const Duration(seconds: 3), () {
      controller.reverse();
    });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed && widget.onDismiss != null) {
        widget.onDismiss!();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    if (timer.isActive) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case PopupType.grey:
        return Align(
          alignment: Alignment.center,
          child: FadeTransition(
            opacity: animationGreyPopup,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: ShapeDecoration(
                      color: AskLoraColors.darkGray,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  child: CustomTextNew(
                    widget.message,
                    style: AskLoraTextStyles.subtitle3
                        .copyWith(color: AskLoraColors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      default:
        return Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 75.0, left: 20, right: 20),
              child: SlideTransition(
                position: position,
                child: Container(
                  decoration: ShapeDecoration(
                      color: AskLoraColors.primaryMagenta,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: CustomTextNew(
                              widget.message,
                              style: AskLoraTextStyles.body1
                                  .copyWith(color: AskLoraColors.white),
                            )),
                            GestureDetector(
                                onTap: () {
                                  controller.reverse();
                                  timer.cancel();
                                },
                                child: getSvgIcon(
                                    'icon_in_app_notification_close')),
                          ])),
                ),
              ),
            ));
    }
  }
}
