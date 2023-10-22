import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/presentation/custom_text_new.dart';
import '../../../../../../core/styles/asklora_text_styles.dart';

class CustomDonutChart extends StatelessWidget {
  final int total;
  final List<PieChartSectionData>? sections;
  const CustomDonutChart({
    Key? key,
    this.total = 0,
    this.sections,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<PieChartSectionData> totalGreaterThan100 = [
      PieChartSectionData(
        color: Colors.red,
        radius: 25,
        borderSide: const BorderSide(
          color: Colors.black54,
        ),
      )
    ];
    final List<PieChartSectionData> totalIsZero = [
      PieChartSectionData(
        color: Colors.white,
        radius: 25,
        borderSide: const BorderSide(
          color: Colors.black38,
        ),
      )
    ];

    List<PieChartSectionData> renderSection() {
      if (total == 0) {
        return totalIsZero;
      }
      if (total > 100) {
        return totalGreaterThan100;
      }
      if (total < 100) {
        sections!.add(
          PieChartSectionData(
            value: 100.0 - total,
            showTitle: false,
            color: Colors.white,
            radius: 25,
            borderSide: const BorderSide(
              color: Colors.black12,
            ),
          ),
        );
        return sections!;
      } else {
        return sections!;
      }
    }

    return SizedBox(
      width: double.infinity,
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              startDegreeOffset: -90,
              sections: renderSection(),
            ),
          ),
          CustomTextNew(
            '$total %',
            style: AskLoraTextStyles.subtitle2,
          ),
        ],
      ),
    );
  }
}
