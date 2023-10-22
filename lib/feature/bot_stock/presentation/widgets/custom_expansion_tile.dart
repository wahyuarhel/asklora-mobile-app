import 'package:flutter/material.dart';

import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';

class CustomExpansionTile extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final Color? backgroundColor;
  final Color? collapsedBackgroundColor;

  const CustomExpansionTile(
      {required this.title,
      required this.children,
      this.backgroundColor,
      this.collapsedBackgroundColor,
      Key? key})
      : super(key: key);

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  var isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
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
        title: CustomTextNew(
          widget.title,
          style: AskLoraTextStyles.subtitle1
              .copyWith(color: AskLoraColors.charcoal),
        ),
        childrenPadding: const EdgeInsets.only(bottom: 32),
        children: widget.children,
      ),
    );
  }
}
