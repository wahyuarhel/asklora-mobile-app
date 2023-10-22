import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/presentation/buttons/primary_button.dart';
import '../../../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../../../core/values/app_values.dart';
import '../../../../../core/domain/base_response.dart';
import '../../../../../generated/l10n.dart';
import '../../../../bot_stock/domain/bot_recommendation_model.dart';
import '../../../../bot_stock/presentation/widgets/bot_stock_form.dart';
import '../../../../bot_stock/repository/bot_stock_repository.dart';
import '../../../../bot_stock/utils/bot_stock_utils.dart';
import '../../../../chart/presentation/chart_animation.dart';
import '../../../learning_bot_stock_screen.dart';
import '../../bloc/demonstration_bot_bloc.dart';
import '../../utils/demonstration_bottom_sheet.dart';
import 'widgets/demonstration_bot_detail_content.dart';

part 'widgets/demonstration_bot_chart.dart';

class DemonstrationBotDetailScreen extends StatelessWidget {
  final BotRecommendationModel botRecommendationModel;
  final BotType botType;

  const DemonstrationBotDetailScreen(
      {required this.botRecommendationModel, required this.botType, Key? key})
      : super(key: key);

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
              ..add(FetchChartData()),
        child: BotStockForm(
            onTapBack: () => context
                .read<NavigationBloc<LearningBotStockPageStep>>()
                .add(const PagePop()),
            useHeader: true,
            title:
                '${botType.upperCaseName} ${botRecommendationModel.tickerSymbol}',
            padding: EdgeInsets.zero,
            content: DemonstrationBotDetailContent(
              botRecommendationModel: botRecommendationModel,
              botType: botType,
              chart: const DemonstrationBotChart(),
            ),
            bottomButton: Padding(
              padding: AppValues.screenHorizontalPadding
                  .copyWith(top: 24, bottom: 30),
              child: PrimaryButton(
                label: S.of(context).trade,
                onTap: () => DemonstrationBottomSheet.show(
                  context,
                  onPrimaryButtonTap: () {
                    Navigator.pop(context);
                    context
                        .read<NavigationBloc<LearningBotStockPageStep>>()
                        .add(const PageChanged(LearningBotStockPageStep.trade));
                  },
                  onSecondaryButtonTap: () => Navigator.pop(context),
                  title: 'Trade any amount above HKD1,500',
                  subTitle: 'Bot will buy fractions of a share for you',
                  primaryButtonLabel: 'See Trade Demonstration',
                  secondaryButtonLabel: S.of(context).buttonCancel,
                ),
              ),
            )),
      ),
    );
  }
}
