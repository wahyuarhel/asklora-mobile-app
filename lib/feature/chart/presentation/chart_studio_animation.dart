import 'dart:async';

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import '../../../core/presentation/dashed_line_horizontal_painter.dart';
import '../../../core/styles/asklora_colors.dart';
import '../../../core/styles/asklora_text_styles.dart';
import '../domain/chart_models.dart';
import '../domain/chart_studio_animation_model.dart';
import '../utils/chart_util.dart';
import 'widgets/animated_icon_label.dart';
import 'widgets/animated_line_pointer.dart';
import 'widgets/animated_line_target.dart';
import 'widgets/pop_up_choices_widget.dart';
import 'widgets/pop_up_value_widget.dart';

class ChartStudioAnimation extends StatefulWidget {
  final ChartStudioAnimationModel chartStudioAnimationModel;

  const ChartStudioAnimation(
      {required this.chartStudioAnimationModel, super.key});

  @override
  State<ChartStudioAnimation> createState() => _ChartStudioAnimationState();
}

class _ChartStudioAnimationState extends State<ChartStudioAnimation> {
  final TextStyle axisStyle =
      AskLoraTextStyles.body3.copyWith(color: AskLoraColors.darkGray);
  final double targetTextHeight = 14;

  final double chartHeight = 250;
  final int lineAnimationDuration = 600;
  final int pauseOnHedgeFoundDuration = 1000;
  final double reservedLeftTitle = 30;

  final double _topChartPadding = 18;
  final double _bottomChartPadding = 18;
  final double _leftChartPadding = 0;
  final double _rightChartPadding = 8;

  final List<CoordinatesModel> flSpotsCoordinate = [];
  late List<FlSpot> flSpots = [];
  final List<int> showIndexes = [];
  final List<Widget> showCenterValue = [];

  final List<double> dashArray = [0, 1000];
  Timer? drawLineTimer;
  Timer? resumeTimer;

  bool isLineAnimatedOnce = false;
  bool isLabelAnimatedOnce = false;
  bool isCurved = false;
  bool animationComplete = false;
  List<Widget> labels = [];
  int animateIndex = 0;
  double space = 0;
  double dash = 0;
  int linePathLength = 0;
  UiData? uiData;
  late int factor;
  double currentDistance = 0;
  bool showUiWidget = false;
  bool showTargetUiWidget = false;
  bool showUiOptionWidget = false;
  OptionModel? optionModel;
  bool animationStarted = false;
  double addition = 0.08;

  @override
  void initState() {
    super.initState();
    drawLineChart();
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
    return LayoutBuilder(builder: (context, constraints) {
      final double actualChartWidth = constraints.maxWidth -
          _rightChartPadding -
          _leftChartPadding -
          reservedLeftTitle;
      ChartDataStudioSet? botData = _searchForBotFromDate(
          widget.chartStudioAnimationModel.chartData[animateIndex].date!);
      final double chartHeightFactor =
          (chartHeight - _topChartPadding - _bottomChartPadding) / getMaxYValue;
      return Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: chartHeight,
                width: MediaQuery.of(context).size.width,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: _rightChartPadding,
                      left: _leftChartPadding,
                      top: _topChartPadding,
                      bottom: _bottomChartPadding,
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
                ),
              ),
            ],
          ),
          if (animationStarted &&
              !animationComplete &&
              (showUiWidget || showUiOptionWidget) &&
              flSpotsCoordinate[animateIndex].offset.dx <
                  (MediaQuery.of(context).size.width - 25))
            Positioned(
              key: UniqueKey(),
              top: flSpotsCoordinate[animateIndex].offset.dy + 13,
              left: flSpotsCoordinate[animateIndex].offset.dx - 4,
              child: AnimatedLinePointer(
                height: (chartHeight +
                    40 -
                    flSpotsCoordinate[animateIndex].offset.dy),
                color: AskLoraColors.primaryMagenta,
              ),
            ),
          Container(
            margin: EdgeInsets.only(top: chartHeight),
            width: double.infinity,
            child: Column(
              children: [
                if (showUiWidget)
                  PopUpChoicesWidget(
                      uiData: uiData!,
                      onClick: () {
                        setState(() {
                          showUiWidget = false;
                          showTargetUiWidget = false;
                          uiData = null;
                          resumeAnimationFromTempDashToDistance(
                              factor, currentDistance);
                        });
                      },
                      onOptionClick: (value) {
                        setState(() {
                          showUiWidget = false;
                          showTargetUiWidget = false;
                          optionModel = value;
                          showUiOptionWidget = true;
                        });
                      }),
                if (showUiOptionWidget)
                  PopUpValueWidget(
                      onClick: () {
                        showUiOptionWidget = false;
                        uiData = null;
                        optionModel = null;
                        resumeAnimationFromTempDashToDistance(
                            factor, currentDistance);
                      },
                      optionModel: optionModel!),
                if (animationComplete) _restartButton
              ],
            ),
          ),
          if (showTargetUiWidget && botData != null) ...[
            Positioned(
                left: _leftChartPadding + reservedLeftTitle,
                top: chartHeight -
                    _bottomChartPadding -
                    (botData.targetProfitLevel! * chartHeightFactor) -
                    targetTextHeight -
                    4,
                child: AnimatedLineTarget(
                  text: 'Target Profit Level',
                  width: actualChartWidth,
                  color: AskLoraColors.primaryGreen,
                  dashedType: DashedType.shortDash,
                  targetTextPosition: TargetTextPosition.top,
                  targetTextHeight: targetTextHeight,
                )),
            Positioned(
                left: _leftChartPadding + reservedLeftTitle,
                top: chartHeight -
                    _bottomChartPadding -
                    (botData.targetMaxLossLevel! * chartHeightFactor),
                child: AnimatedLineTarget(
                  text: 'Target Max Loss Level',
                  width: actualChartWidth,
                  color: AskLoraColors.primaryMagenta,
                  dashedType: DashedType.shortDash,
                  targetTextPosition: TargetTextPosition.bottom,
                  targetTextHeight: targetTextHeight,
                )),
          ]
        ],
      );
    });
  }

  Widget get _restartButton {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: GestureDetector(
        onTap: () {
          if (animationComplete) {
            restartAnimation();
          }
        },
        child: Icon(
          Icons.restart_alt_rounded,
          color: Colors.grey[700],
          size: 34,
        ),
      ),
    );
  }

  void restartAnimation() {
    setState(() {
      lastIndexShown = 0;
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
          timer.cancel();
          animateLine();
        }
        tempDash = tempDash + addition;
      }
    });
  }

  int lastIndexShown = 0;

  void animateLine() {
    setState(() {
      animationStarted = true;
    });
    factor = (lineAnimationDuration /
            widget.chartStudioAnimationModel.chartData.length)
        .round();
    currentDistance = 0;
    if (animateIndex < flSpotsCoordinate.length) {
      currentDistance = flSpotsCoordinate[animateIndex].distance;
    } else {
      setState(() {
        animationComplete = true;
      });
      return;
    }

    double tempDash = 0;

    drawLineTimer = Timer.periodic(
        Duration(milliseconds: ((factor / currentDistance)).round()), (timer) {
      if (mounted) {
        uiData = _searchForUiDataFromDate(
            widget.chartStudioAnimationModel.chartData[animateIndex].date!);

        if (uiData != null) {
          drawLineTimer!.cancel();
          setState(() {
            showUiWidget = true;
            showTargetUiWidget = true;
          });
        }

        ChartDataStudioSet? botData = _searchForBotFromDate(
            widget.chartStudioAnimationModel.chartData[animateIndex].date!);
        if (botData != null &&
            botData.hedgeStatus != 'Hold' &&
            animateIndex > lastIndexShown + 5) {
          lastIndexShown = animateIndex;
          if (botData.hedgeStatus == 'Buy') {
            setState(() {
              labels.add(AnimatedIconLabel(
                  key: UniqueKey(),
                  left: flSpotsCoordinate[animateIndex].offset.dx - 25,
                  top: flSpotsCoordinate[animateIndex].offset.dy + 10,
                  hedgeType: HedgeType.buy));
            });
          } else if (botData.hedgeStatus == 'Sell') {
            setState(() {
              labels.add(AnimatedIconLabel(
                  key: UniqueKey(),
                  left: flSpotsCoordinate[animateIndex].offset.dx - 25,
                  top: flSpotsCoordinate[animateIndex].offset.dy - 58,
                  hedgeType: HedgeType.sell));
            });
          }
          if (uiData == null) {
            drawLineTimer!.cancel();
            Future.delayed(Duration(milliseconds: pauseOnHedgeFoundDuration))
                .then((value) {
              resumeAnimationFromTempDashToDistance(factor, currentDistance);
            });
          }
        }
        if (tempDash <= currentDistance) {
          dash = dash + addition;
          space = space - addition;
          setState(() {
            dashArray[0] = dash;
            dashArray[1] = space;
          });
        } else if (tempDash >= currentDistance) {
          animateIndex++;
          drawLineTimer!.cancel();
          animateLine();
        }
        tempDash = tempDash + addition;
      }
    });
  }

  void drawLineChart() {
    flSpots = widget.chartStudioAnimationModel.chartData
        .map((e) => FlSpot(e.index!.toDouble(), e.price!))
        .toList();
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    ChartDataStudioSet? chartDataStudioSet = widget
        .chartStudioAnimationModel.chartData
        .firstWhereOrNull((element) => element.index == value.round());
    if (chartDataStudioSet != null) {
      return Transform.rotate(
          angle: math.pi / 8,
          child: Text(
            DateFormat('MM-dd').format(chartDataStudioSet.date!),
            style: axisStyle,
          ));
    } else {
      return Container();
    }
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return Text(value.round().toString(),
        style: axisStyle, textAlign: TextAlign.left);
  }

  double get getMaxYValue {
    double maxValue = 0;
    for (var element in widget.chartStudioAnimationModel.chartData) {
      if (element.price! > maxValue) {
        maxValue = element.price!;
      }
    }
    //add multiply factor of 1.1 to add some space on top of y axis
    maxValue *= 1.1;
    maxValue = maxValue.round().toDouble();
    //check if maxValue is not rounded by 10 then add the rest using mod
    if (maxValue % 10 != 0) {
      maxValue += (10 - maxValue % 10);
    }
    return maxValue;
  }

  double get getMinYValue {
    double minValue = double.infinity;
    for (var element in widget.chartStudioAnimationModel.chartData) {
      if (element.price! < minValue) {
        minValue = element.price!;
      }
    }
    double minFactor = minValue * 0.2;
    if ((minValue - minFactor) >= 0) {
      minValue -= minFactor;
    }
    return minValue;
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
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 24,
            interval: 20,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 40,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: reservedLeftTitle,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
              left: BorderSide(width: 1, color: Color(0XFFD2D2D2)),
              bottom: BorderSide(width: 1, color: Color(0XFFD2D2D2)))),
      minX: flSpots.first.x,
      maxX: widget.chartStudioAnimationModel.chartData.length - 1,
      minY: 0,
      maxY: getMaxYValue,
      lineBarsData: [
        LineChartBarData(
          lineLengthCallback: (value) async {
            //add dummy delay to make sure the widget is built before trigger animation()
            await Future.delayed(Duration.zero);
            if (!isLineAnimatedOnce) {
              linePathLength = value.round() + (isCurved ? 40 : 0);
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
              // animateLabel();
            }
          },
          dashArray: dashArray,
          showingIndicators: showIndexes,
          showingTopRightValue: showCenterValue,
          spots: flSpots,
          isCurved: isCurved,
          color: Colors.black,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
        ),
      ],
    );
  }

  ChartDataStudioSet? _searchForBotFromDate(DateTime date) {
    List<ChartDataStudioSet> chartDataStudioSets =
        widget.chartStudioAnimationModel.botData;
    return chartDataStudioSets
        .firstWhereOrNull((element) => element.date == date);
  }

  UiData? _searchForUiDataFromDate(DateTime date) {
    List<UiData> uiDatas = widget.chartStudioAnimationModel.uiData;
    return uiDatas.firstWhereOrNull((element) => element.date == date);
  }
}
