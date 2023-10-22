import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../../chart/presentation/chart_animation.dart';
import '../../repository/bot_stock_repository.dart';
import 'bloc/bot_performance_bloc.dart';

class BotPerformanceChart extends StatelessWidget {
  final String botOrderId;
  final Widget? chartCaption;

  const BotPerformanceChart(
      {required this.botOrderId, this.chartCaption, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          BotPerformanceBloc(botStockRepository: BotStockRepository())
            ..add(FetchBotPerformance(botOrderId: botOrderId)),
      child: BlocBuilder<BotPerformanceBloc, BotPerformanceState>(
        buildWhen: (previous, current) =>
            previous.botPerformanceResponse.state !=
            current.botPerformanceResponse.state,
        builder: (context, state) {
          return state.botPerformanceResponse.data != null &&
                  state.botPerformanceResponse.data!.isNotEmpty
              ? Column(
                  children: [
                    ChartAnimation(
                        chartDataSets: state.botPerformanceResponse.data!),
                    if (chartCaption != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: chartCaption,
                      ),
                  ],
                )
              : Text(S.of(context).portfolioDetailChartEmptyMessage);
        },
      ),
    );
  }
}
