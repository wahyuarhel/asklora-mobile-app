import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/domain/base_response.dart';
import '../../../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../../../core/styles/asklora_colors.dart';
import '../../../../../../core/values/app_values.dart';
import '../../../../bot_stock/repository/bot_stock_repository.dart';
import '../../../../chart/presentation/chart_studio_animation.dart';
import '../../../learning_bot_stock_screen.dart';
import '../../bloc/demonstration_bot_bloc.dart';

class DemonstrationBotTrade extends StatelessWidget {
  const DemonstrationBotTrade({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .read<NavigationBloc<LearningBotStockPageStep>>()
            .add(const PagePop());
        return false;
      },
      child: BlocProvider(
        create: (_) =>
            DemonstrationBotBloc(botStockRepository: BotStockRepository())
              ..add(FetchTradeChartData()),
        child: Padding(
          padding: AppValues.screenHorizontalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: InkWell(
                    onTap: () => context
                        .read<NavigationBloc<LearningBotStockPageStep>>()
                        .add(const PagePop()),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 24,
                      color: AskLoraColors.charcoal,
                    )),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 30),
                  child:
                      BlocBuilder<DemonstrationBotBloc, DemonstrationBotState>(
                          builder: (context, state) {
                    if (state.tradeChartDataResponse.state ==
                        ResponseState.success) {
                      return ChartStudioAnimation(
                        chartStudioAnimationModel:
                            state.tradeChartDataResponse.data!,
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
