import 'dart:async';

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import '../../../core/presentation/custom_text_new.dart';
import '../../../core/styles/asklora_colors.dart';
import '../../../core/styles/asklora_text_styles.dart';
import '../../../core/utils/extensions.dart';
import '../domain/chart_models.dart';
import '../utils/chart_util.dart';
import 'widgets/animated_icon_label.dart';
import 'widgets/animated_profit_label.dart';

class ChartAnimation extends StatefulWidget {
  final List<ChartDataSet> chartDataSets;

  const ChartAnimation({required this.chartDataSets, super.key});

  @override
  State<ChartAnimation> createState() => _ChartAnimationState();
}

class _ChartAnimationState extends State<ChartAnimation> {
  final TextStyle axisStyle =
      AskLoraTextStyles.body4.copyWith(color: AskLoraColors.charcoal);

  final double chartHeight = 300;
  final int lineAnimationDuration = 250;
  final int pauseOnHedgeFoundDuration = 1000;

  final double _leftChartPadding = 6;
  final double _rightChartPadding = 12;

  final List<CoordinatesModel> flSpotsCoordinate = [];
  final List<FlSpot> flSpots = [];
  final List<int> showIndexes = [];
  final List<Widget> showCenterValue = [];

  final List<double> dashArray = [0, 1000];
  Timer? drawLineTimer;
  Timer? resumeTimer;
  late Timer drawLabelTimer;

  bool isLineAnimatedOnce = false;
  bool isLabelAnimatedOnce = false;
  bool isCurved = false;
  bool animationComplete = false;
  List<Widget> labels = [];
  int animateIndex = 0;
  double space = 0;
  double dash = 0;
  int linePathLength = 0;
  double addition = 0.08;
  double lastProfit = 0;

  late double maxPriceValue;
  late double minPriceValue;
  late double maxYValue;
  late double minYValue;
  late double interval;

  @override
  void initState() {
    super.initState();
    getInitialAxisValue();
    drawLineChart();
  }

  void getInitialAxisValue() {
    maxPriceValue = 0;
    minPriceValue = double.infinity;
    for (var element in widget.chartDataSets) {
      if (element.price > maxPriceValue) {
        maxPriceValue = element.price;
      }
      if (element.price < minPriceValue) {
        minPriceValue = element.price;
      }
    }

    maxPriceValue = maxPriceValue.ceilToDouble();

    minPriceValue = minPriceValue.floorToDouble();

    interval = ((maxPriceValue - minPriceValue) / 5).ceilToDouble();

    double median = (maxPriceValue - minPriceValue) / 2;

    double dividedMedian = median / 3;

    maxYValue = (maxPriceValue + dividedMedian).ceilToDouble();

    minYValue = (minPriceValue - dividedMedian).floorToDouble();
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    if (value >= minPriceValue &&
            value <= maxPriceValue &&
            (value - minPriceValue) % interval == 0 ||
        value == minPriceValue ||
        value == maxPriceValue) {
      return CustomTextNew(value.floor().toString(),
          style: axisStyle, textAlign: TextAlign.left);
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  void dispose() {
    if (drawLineTimer != null) {
      drawLineTimer!.cancel();
    }

    if (resumeTimer != null) {
      resumeTimer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: chartHeight,
      width: MediaQuery.of(context).size.width,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Stack(
          children: [
            LineChart(
              mainData(),
            ),
            ...labels
          ],
        ),
      ),
    );
  }

  void restartAnimation() {
    setState(() {
      animationComplete = false;
      drawLineTimer!.cancel();
      labels.clear();
      dashArray.clear();
      animateIndex = 0;
      dash = 0;
      space = linePathLength.toDouble();
      dashArray.addAll([dash, space]);
      animateLine();
    });
  }

  void resumeAnimationFromTempDashToDistance(factor, distance) {
    double tempDash = 0;
    resumeTimer = Timer.periodic(
        Duration(milliseconds: (factor / distance).round()), (timer) {
      if (mounted) {
        if (tempDash < distance) {
          dash = dash + addition;
          space = space - addition;

          setState(() {
            dashArray[0] = dash;
            dashArray[1] = space;
          });
        } else {
          animateIndex++;
          resumeTimer!.cancel();
          animateLine();
        }
        tempDash = tempDash + addition;
      }
    });
  }

  void animateLine() {
    int factor = (lineAnimationDuration / widget.chartDataSets.length).round();
    double currentDistance = 0;
    if (animateIndex < flSpotsCoordinate.length) {
      currentDistance = flSpotsCoordinate[animateIndex].distance;
    } else {
      setState(() {
        animationComplete = true;
        labels.add(AnimatedProfitLabel(
          hideProfit: false,
          key: UniqueKey(),
          additionalText: 'Overall Profit/Loss',
          delayDuration: Duration.zero,
          left: MediaQuery.of(context).size.width - 176,
          top: 0,
          profit: lastProfit,
          hedgeType: HedgeType.sell,
        ));
      });
      return;
    }

    double tempDash = 0;

    drawLineTimer = Timer.periodic(
        Duration(milliseconds: ((factor / currentDistance)).round()), (timer) {
      if (mounted) {
        double? hedgeShare = widget.chartDataSets[animateIndex].hedgeShare;
        double profit =
            widget.chartDataSets[animateIndex].currentPnlRetFormatted;
        if (profit != 0) {
          lastProfit =
              widget.chartDataSets[animateIndex].currentPnlRetFormatted;
        }

        if (hedgeShare != 0) {
          if (hedgeShare > 0) {
            setState(() {
              labels.add(AnimatedIconLabel(
                  key: UniqueKey(),
                  left: flSpotsCoordinate[animateIndex].offset.dx -
                      50 +
                      reservedLeftSize,
                  top: flSpotsCoordinate[animateIndex].offset.dy + 20,
                  hedgeType: HedgeType.buy));
            });
          } else {
            setState(() {
              labels.add(AnimatedIconLabel(
                  key: UniqueKey(),
                  left: flSpotsCoordinate[animateIndex].offset.dx -
                      50 +
                      reservedLeftSize,
                  top: flSpotsCoordinate[animateIndex].offset.dy - 43,
                  hedgeType: HedgeType.sell));
            });
          }
          labels.add(AnimatedProfitLabel(
            key: UniqueKey(),
            delayDuration: Duration.zero,
            left: flSpotsCoordinate[animateIndex].offset.dx >
                    (MediaQuery.of(context).size.width -
                        (_leftChartPadding + _rightChartPadding) -
                        120)
                ? (flSpotsCoordinate[animateIndex].offset.dx -
                    88 +
                    reservedLeftSize)
                : (flSpotsCoordinate[animateIndex].offset.dx -
                    80 +
                    reservedLeftSize),
            top: flSpotsCoordinate[animateIndex].offset.dy >
                    50 * (chartHeight - 24) / 100
                ? 10
                : (chartHeight - 80),
            profit: profit,
            hedgeType: hedgeShare > 0 ? HedgeType.buy : HedgeType.sell,
          ));

          drawLineTimer!.cancel();
          Future.delayed(Duration(milliseconds: pauseOnHedgeFoundDuration))
              .then((value) {
            resumeAnimationFromTempDashToDistance(factor, currentDistance);
          });
        } else if (tempDash < currentDistance) {
          dash = dash + addition;
          space = space - addition;

          setState(() {
            dashArray[0] = dash;
            dashArray[1] = space;
          });
        } else {
          animateIndex++;
          drawLineTimer!.cancel();
          if (dash < linePathLength) {
            animateLine();
          }
        }
        tempDash = tempDash + addition;
      }
    });
  }

  void drawLineChart() {
    for (var data in widget.chartDataSets) {
      flSpots.add(FlSpot(data.index!.toDouble(), data.price));
      showIndexes.add(data.index!);
      showCenterValue.add(Text(
        'Profit : ${data.currentPnlRetFormatted}',
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
      ));
    }
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    ChartDataSet? chartDataSet = widget.chartDataSets
        .firstWhereOrNull((element) => element.index == value.round());
    if (chartDataSet != null) {
      return Transform.rotate(
          angle: math.pi / 8,
          child: Text(
            DateFormat('MM-dd').format(chartDataSet.date),
            style: axisStyle,
          ));
    } else {
      return Container();
    }
  }

  double get reservedLeftSize {
    return maxYValue.toString().textWidth(axisStyle);
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
              FlLine(
                color: Colors.transparent,
              ),
              FlDotData(
                show: false,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: 8,
                  color: Colors.green,
                  strokeWidth: 1,
                  strokeColor: Colors.black,
                ),
              ),
            );
          }).toList();
        },
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0XFFF5F5F5),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0XFFF5F5F5),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, reservedSize: 5),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, reservedSize: 5),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: reservedLeftSize,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
              left: BorderSide(width: 1, color: Color(0XFFD2D2D2)),
              bottom: BorderSide(width: 1, color: Color(0XFFD2D2D2)))),
      minX: flSpots.first.x,
      maxX: widget.chartDataSets.length - 1,
      minY: minYValue,
      maxY: maxYValue,
      lineBarsData: [
        LineChartBarData(
          lineLengthCallback: (value) async {
            await Future.delayed(Duration.zero);
            if (!isLineAnimatedOnce) {
              linePathLength = value.round() + (isCurved ? 40 : 10);
              space = linePathLength.toDouble();
              dashArray.addAll([dash, space]);
              isLineAnimatedOnce = true;
              animateLine();
            }
          },
          drawingCoordinateCallback: (value) async {
            flSpotsCoordinate.clear();
            flSpotsCoordinate.addAll(value);
            await Future.delayed(Duration.zero);
            if (!isLabelAnimatedOnce) {
              isLabelAnimatedOnce = true;
            }
          },
          dashArray: dashArray,
          showingIndicators: showIndexes,
          showingTopRightValue: showCenterValue,
          spots: flSpots,
          isCurved: isCurved,
          color: Colors.black,
          barWidth: 3.2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
        ),
      ],
    );
  }
}
