import 'package:flutter/material.dart';

import '../../custom_status_widget.dart';

class AcknowledgementModel {
  final String title;
  final String subTitle;
  final String buttonTitle;
  final VoidCallback onButtonTap;
  final StatusType statusType;

  AcknowledgementModel(
      {required this.title,
      required this.subTitle,
      required this.buttonTitle,
      required this.onButtonTap,
      required this.statusType});
}
