import 'package:flutter/material.dart';

import '../../../../../core/presentation/custom_scaffold.dart';
import '../../../core/presentation/custom_header.dart';
import '../../../core/presentation/custom_stretched_layout.dart';

class BalanceBaseForm extends StatelessWidget {
  final Widget content;
  final Widget bottomButton;
  final bool useHeader;
  final String title;
  final bool enableBackNavigation;

  const BalanceBaseForm(
      {required this.content,
      this.useHeader = true,
      required this.bottomButton,
      this.title = '',
      this.enableBackNavigation = true,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => CustomScaffold(
        enableBackNavigation: enableBackNavigation,
        body: CustomStretchedLayout(
          header: useHeader
              ? CustomHeader(
                  title: title,
                )
              : null,
          content: content,
          bottomButton: bottomButton,
        ),
      );
}
