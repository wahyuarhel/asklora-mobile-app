import 'package:flutter/material.dart';

import '../../../../../../core/styles/asklora_colors.dart';
import '../../../../../../core/values/app_values.dart';

class CustomDetailExpansionTile extends StatefulWidget {
  final Widget title;

  final List<Widget> children;
  final Color? backgroundColor;
  final Color? collapsedBackgroundColor;

  const CustomDetailExpansionTile(
      {required this.title,
      required this.children,
      this.backgroundColor,
      this.collapsedBackgroundColor,
      Key? key})
      : super(key: key);

  @override
  State<CustomDetailExpansionTile> createState() =>
      _CustomDetailExpansionTileState();
}

class _CustomDetailExpansionTileState extends State<CustomDetailExpansionTile> {
  var isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppValues.screenHorizontalPadding.copyWith(top: 10, bottom: 10),
      color: AskLoraColors.whiteSmoke,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          collapsedBackgroundColor: widget.collapsedBackgroundColor,
          backgroundColor: widget.backgroundColor,
          trailing: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AskLoraColors.primaryGreen)),
            padding: const EdgeInsets.all(3),
            child: Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: AskLoraColors.primaryGreen,
              size: 18,
            ),
          ),
          onExpansionChanged: (bool expanded) {
            setState(() => isExpanded = expanded);
          },
          tilePadding: EdgeInsets.zero,
          title: widget.title,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          childrenPadding: const EdgeInsets.only(bottom: 16, top: 16),
          children: widget.children,
        ),
      ),
    );
  }
}
