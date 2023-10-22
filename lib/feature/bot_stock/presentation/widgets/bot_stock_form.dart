import 'package:flutter/material.dart';

import '../../../../../core/values/app_values.dart';
import '../../../../core/presentation/custom_header.dart';
import '../../../../core/presentation/custom_scaffold.dart';
import '../../../../core/presentation/custom_stretched_layout.dart';
import '../../../../core/styles/asklora_colors.dart';

class BotStockForm extends StatelessWidget {
  final bool enableBackNavigation;
  final Widget content;
  final Widget? bottomButton;
  final EdgeInsets padding;
  final EdgeInsets contentPadding;
  final String title;
  final Color backgroundColor;
  final bool useHeader;
  final VoidCallback? onTapBack;
  final Widget? customHeader;

  const BotStockForm({
    Key? key,
    this.title = '',
    this.enableBackNavigation = true,
    required this.content,
    this.bottomButton,
    this.useHeader = false,
    this.backgroundColor = AskLoraColors.white,
    this.padding = AppValues.screenHorizontalPadding,
    this.contentPadding = const EdgeInsets.only(top: 24.0, bottom: 43),
    this.customHeader,
    this.onTapBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      onTapBack: onTapBack,
      enableBackNavigation: enableBackNavigation,
      backgroundColor: backgroundColor,
      body: CustomStretchedLayout(
        contentPadding: contentPadding,
        header: useHeader
            ? customHeader ??
                CustomHeader(
                  title: title,
                )
            : null,
        content: content,
        bottomButton: bottomButton,
        padding: padding,
      ),
    );
  }
}
