part of '../demonstration_bot_detail_screen.dart';

class DemonstrationBotChart extends StatelessWidget {
  const DemonstrationBotChart({Key? key}) : super(key: key);

  ///UPDATE TO USE BOTDETAILMODEL PERFORMANCE
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DemonstrationBotBloc, DemonstrationBotState>(
        buildWhen: (previous, current) =>
            previous.chartDataResponse != current.chartDataResponse,
        builder: (context, state) {
          if (state.chartDataResponse.state != ResponseState.success) {
            return const SizedBox.shrink();
          } else {
            return ChartAnimation(chartDataSets: state.chartDataResponse.data!);
          }
        });
  }
}
