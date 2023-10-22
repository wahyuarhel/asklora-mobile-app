import 'package:flutter/material.dart';

import '../../../../core/styles/asklora_colors.dart';
import '../../../../core/styles/asklora_text_styles.dart';
import '../../../../core/values/app_values.dart';

class TransactionHistoryTabScreen extends StatelessWidget {
  final Widget header;
  final List<String> tabs;
  final List<Widget> tabViews;

  const TransactionHistoryTabScreen(
      {required this.header,
      required this.tabs,
      required this.tabViews,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          header,
          Container(
            margin: AppValues.screenHorizontalPadding.copyWith(top: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AskLoraColors.whiteSmoke,
            ),
            height: 40,
            child: TabBar(
                labelStyle: AskLoraTextStyles.subtitle4,
                padding: const EdgeInsets.all(2),
                indicatorColor: Colors.red,
                labelColor: AskLoraColors.charcoal,
                unselectedLabelColor: AskLoraColors.darkGray,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AskLoraColors.primaryGreen),
                tabs: tabs.map((e) => Tab(text: e)).toList()),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: TabBarView(children: tabViews),
          ),
        ],
      ),
    );
  }
}
