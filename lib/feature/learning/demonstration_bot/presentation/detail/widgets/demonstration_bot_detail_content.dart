import 'package:flutter/material.dart';

import '../../../../../../core/presentation/custom_text_new.dart';
import '../../../../../../core/styles/asklora_colors.dart';
import '../../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../../core/values/app_values.dart';
import '../../../../../bot_stock/domain/bot_recommendation_model.dart';
import '../../../../../bot_stock/presentation/bot_recommendation/detail/widgets/bot_price_level_indicator.dart';
import '../../../../../bot_stock/presentation/widgets/custom_detail_expansion_tile.dart';
import '../../../../../bot_stock/presentation/widgets/iex_data_provider_link.dart';
import '../../../../../../core/presentation/column_text/pair_column_text_with_tooltip.dart';
import '../../../../../bot_stock/utils/bot_stock_utils.dart';

class DemonstrationBotDetailContent extends StatelessWidget {
  final BotRecommendationModel botRecommendationModel;
  final BotType botType;
  final Widget chart;
  final SizedBox _spaceBetweenInfo = const SizedBox(
    height: 16,
  );

  final String _tempTooltipText =
      'Lorem ipsum dolor sit amet consectetur. Integer neque ultrices amet fermentum condimentum consequat. ';

  const DemonstrationBotDetailContent(
      {required this.botRecommendationModel,
      required this.botType,
      required this.chart,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDetailExpansionTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextNew(
                '${botType.upperCaseName} Bots',
                style: AskLoraTextStyles.h5
                    .copyWith(color: AskLoraColors.charcoal),
              ),
              CustomTextNew(
                botRecommendationModel.botWordString,
                style: AskLoraTextStyles.body3
                    .copyWith(color: AskLoraColors.charcoal),
              )
            ],
          ),
          children: [
            CustomTextNew(
              'Best Suited For',
              style: AskLoraTextStyles.body4
                  .copyWith(color: AskLoraColors.charcoal),
            ),
            const SizedBox(
              height: 6,
            ),
            CustomTextNew(
              'Investors who want to take advantage of frequent price movements in the market.',
              style: AskLoraTextStyles.body1
                  .copyWith(color: AskLoraColors.charcoal),
            ),
            const SizedBox(
              height: 18,
            ),
            CustomTextNew(
              'How It Works',
              style: AskLoraTextStyles.body4
                  .copyWith(color: AskLoraColors.charcoal),
            ),
            const SizedBox(
              height: 6,
            ),
            CustomTextNew(
              'It sells all to stop loss or when it reaches the target profit. ',
              style: AskLoraTextStyles.body1
                  .copyWith(color: AskLoraColors.charcoal),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        CustomDetailExpansionTile(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextNew(
                      'Tesla TSLA',
                      style: AskLoraTextStyles.h5
                          .copyWith(color: AskLoraColors.charcoal),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextNew(
                      'Prev Close 10/07 16:00:04 ET',
                      style: AskLoraTextStyles.body2
                          .copyWith(color: AskLoraColors.charcoal),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomTextNew(
                      '223.07',
                      style: AskLoraTextStyles.h5
                          .copyWith(color: AskLoraColors.charcoal),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextNew(
                      '-15.060 -6.32%',
                      style: AskLoraTextStyles.body2
                          .copyWith(color: AskLoraColors.charcoal),
                    )
                  ],
                ),
              )
            ],
          ),
          children: [
            const PairColumnTextWithTooltip(
              leftTitle: 'Prev Close',
              leftSubTitle: '238.13',
              rightTitle: 'Market Cap',
              rightSubTitle: '698.98B',
            ),
            const SizedBox(
              height: 10,
            ),
            const IexDataProviderLink(),
            const Divider(
              color: AskLoraColors.gray,
            ),
            CustomTextNew(
              'About Tesla',
              style:
                  AskLoraTextStyles.h6.copyWith(color: AskLoraColors.charcoal),
            ),
            const SizedBox(
              height: 21,
            ),
            const PairColumnTextWithTooltip(
              leftTitle: 'Sector(s)',
              leftSubTitle: 'Consumer Cyclical',
              rightTitle: 'Take Profit Level',
              rightSubTitle: 'Auto Manufacturers',
            ),
            _spaceBetweenInfo,
            const PairColumnTextWithTooltip(
              leftTitle: 'CEO',
              leftSubTitle: 'Mr. Elon R. Musk',
              rightTitle: 'Employees',
              rightSubTitle: '99,290',
            ),
            _spaceBetweenInfo,
            const PairColumnTextWithTooltip(
              leftTitle: 'Headquarters',
              leftSubTitle: 'Austin, TX',
              rightTitle: 'Founded',
              rightSubTitle: '2003',
            ),
            const SizedBox(
              height: 23,
            ),
            CustomTextNew(
              'Tesla, Inc. designs, develops, manufactures, leases, and sells electric vehicles, and energy generation and storage systems in the United States, China, and internationally. The company operates in two segments, Automotive, and Energy Generation and Storage. ',
              style: AskLoraTextStyles.body1
                  .copyWith(color: AskLoraColors.charcoal),
            )
          ],
        ),
        const SizedBox(
          height: 26,
        ),
        Padding(
          padding: AppValues.screenHorizontalPadding,
          child: Column(
            children: [
              if (botType != BotType.squat) _detailedInformation,
              PairColumnTextWithTooltip(
                  leftTitle: 'Earliest Start Time',
                  leftSubTitle: '03/12 15:30 ET',
                  rightTitle: 'Optimized Start Time',
                  rightSubTitle: '03/12 15:30 ET',
                  leftTooltipText: _tempTooltipText,
                  rightTooltipText: _tempTooltipText),
              _spaceBetweenInfo,
              PairColumnTextWithTooltip(
                  leftTitle: 'Investment Period',
                  leftSubTitle: '2 weeks',
                  rightTitle: 'Estimated End Date',
                  rightSubTitle: '03/26',
                  leftTooltipText: _tempTooltipText,
                  rightTooltipText: _tempTooltipText),
              const SizedBox(
                height: 32,
              ),
              chart,
            ],
          ),
        ),
      ],
    );
  }

  Widget get _detailedInformation => Column(
        children: [
          BotPriceLevelIndicator(
            stopLossPrice: '210',
            currentPrice: '240',
            takeProfitPrice: '220',
            botType: botType,
          ),
          const SizedBox(
            height: 24,
          ),
          PairColumnTextWithTooltip(
              leftTitle: 'Stop Loss Level (USD)',
              leftSubTitle: '210.00',
              rightTitle: 'Take Profit Level (USD)',
              rightSubTitle: '210.00',
              leftTooltipText: _tempTooltipText,
              rightTooltipText: _tempTooltipText),
          _spaceBetweenInfo,
        ],
      );
}
