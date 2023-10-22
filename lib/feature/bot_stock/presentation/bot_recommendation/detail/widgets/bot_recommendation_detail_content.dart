import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../../core/presentation/auto_sized_text_widget.dart';
import '../../../../../../core/presentation/bot_badge/bot_badge.dart';
import '../../../../../../core/presentation/buttons/primary_button.dart';
import '../../../../../../core/presentation/column_text/column_text_with_tooltip.dart';
import '../../../../../../core/presentation/column_text/pair_column_text.dart';
import '../../../../../../core/presentation/column_text/pair_column_text_with_bottom_sheet.dart';
import '../../../../../../core/presentation/custom_text_new.dart';
import '../../../../../../core/presentation/tutorial/Utils/tutorial_journey.dart';
import '../../../../../../core/presentation/tutorial/custom_show_case_view.dart';
import '../../../../../../core/styles/asklora_colors.dart';
import '../../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../../core/utils/extensions.dart';
import '../../../../../../core/utils/feature_flags.dart';
import '../../../../../../core/values/app_values.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../chart/presentation/chart_animation.dart';
import '../../../../../tabs/bloc/tab_screen_bloc.dart';
import '../../../../domain/bot_recommendation_detail_model.dart';
import '../../../../domain/bot_recommendation_model.dart';
import '../../../../utils/bot_stock_utils.dart';
import '../../../widgets/custom_detail_expansion_tile.dart';
import '../../../widgets/iex_data_provider_link.dart';
import 'bot_price_level_indicator.dart';
import 'toggleable_price_text.dart';

class BotRecommendationDetailContent extends StatelessWidget {
  final BotRecommendationModel botRecommendationModel;
  final BotRecommendationDetailModel? botDetailModel;
  final BotType botType;
  final SizedBox _spaceBetweenInfo = const SizedBox(
    height: 16,
  );

  const BotRecommendationDetailContent(
      {required this.botRecommendationModel,
      required this.botType,
      this.botDetailModel,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BotBadge(
            botType: botType,
            tickerSymbol: botRecommendationModel.tickerSymbol,
            textColor: AskLoraColors.charcoal,
            margin: EdgeInsets.zero),
        if (!FeatureFlags.isMockApp)
          _botDetailsExpansionTile(context)
        else
          _botDetails(context),
        _detailedInformation(context),
        if (!FeatureFlags.isMockApp) _performanceWidget(context),
      ],
    );
  }

  Widget _botDetails(BuildContext context) => Container(
        padding: AppValues.screenHorizontalPadding.copyWith(top: 15),
        margin: const EdgeInsets.only(bottom: 25),
        decoration: const BoxDecoration(color: AskLoraColors.whiteSmoke),
        child: Column(
          children: [
            CustomShowcaseView(
              tutorialKey: TutorialJourney.tickerDetails,
              tooltipWidget: CustomTextNew(
                S.of(context).tooltipDescOfTickerDetailsTutorial,
                style: AskLoraTextStyles.body1,
              ),
              margin: const EdgeInsets.only(top: 117),
              onToolTipClick: () => ShowCaseWidget.of(context).next(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextNew('${botType.upperCaseName} Bot',
                      style: AskLoraTextStyles.h5
                          .copyWith(color: AskLoraColors.charcoal)),
                  const SizedBox(height: 8),
                  CustomTextNew(
                    botDetailModel?.botInfo.botDescription.detail ?? 'NA',
                    style: AskLoraTextStyles.body3
                        .copyWith(color: AskLoraColors.charcoal),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizedTextWidget(
                              '${botDetailModel?.stockInfo.tickerName} (${botDetailModel?.stockInfo.symbol})',
                              style: AskLoraTextStyles.h5
                                  .copyWith(color: AskLoraColors.charcoal),
                              maxLines: 2,
                              minFontSize: 12,
                              ellipsis: true,
                            ),
                            const SizedBox(height: 8),
                            CustomTextNew(
                              '${S.of(context).prevClose} ${botDetailModel?.prevCloseDateFormatted ?? 'NA'}',
                              style: AskLoraTextStyles.body2
                                  .copyWith(color: AskLoraColors.charcoal),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomTextNew(
                            (botDetailModel?.price ?? 0)
                                .convertToCurrencyDecimal(),
                            style: AskLoraTextStyles.h5
                                .copyWith(color: AskLoraColors.charcoal),
                          ),
                          ToggleablePriceText(
                            fillColor: botDetailModel?.prevClosePct != null &&
                                    botDetailModel!.prevClosePct < 0
                                ? AskLoraColors.primaryMagenta
                                : AskLoraColors.primaryGreen,
                            percentDifference:
                                botDetailModel?.prevClosePctFormatted ?? 'NA',
                            priceDifference:
                                botDetailModel?.prevCloseAmtFormatted ?? 'NA',
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const IexDataProviderLink(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: CustomShowcaseView(
                tutorialKey: TutorialJourney.tellMeMoreButton,
                tooltipWidget: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: S.of(context).youCanClickOn,
                          style: AskLoraTextStyles.body1),
                      TextSpan(
                          text: "'${S.of(context).tellMeMore}'",
                          style: AskLoraTextStyles.subtitle2),
                      TextSpan(
                          text: S.of(context).toOpenLora,
                          style: AskLoraTextStyles.body1),
                    ],
                  ),
                ),
                margin: const EdgeInsets.only(top: 30),
                onToolTipClick: () => ShowCaseWidget.of(context).next(),
                child: SizedBox(
                    width: 169,
                    child: PrimaryButton(
                        label: S.of(context).tellMeMore,
                        onTap: () => context
                            .read<TabScreenBloc>()
                            .add(const OnAiOverlayClick()),
                        buttonPrimaryType: ButtonPrimaryType.solidGreen)),
              ),
            )
          ],
        ),
      );

  Widget _botDetailsExpansionTile(BuildContext context) => Column(
        children: [
          CustomDetailExpansionTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextNew(
                  '${botType.upperCaseName} Bot',
                  style: AskLoraTextStyles.h5
                      .copyWith(color: AskLoraColors.charcoal),
                ),
                CustomTextNew(
                  botDetailModel?.botInfo.botDescription.detail ?? 'NA',
                  style: AskLoraTextStyles.body3
                      .copyWith(color: AskLoraColors.charcoal),
                )
              ],
            ),
            children: [
              CustomTextNew(
                S.of(context).bestSuitedFor,
                style: AskLoraTextStyles.body4
                    .copyWith(color: AskLoraColors.charcoal),
              ),
              const SizedBox(
                height: 6,
              ),
              CustomTextNew(
                botDetailModel?.botInfo.botDescription.suited ?? 'NA',
                style: AskLoraTextStyles.body1
                    .copyWith(color: AskLoraColors.charcoal),
              ),
              const SizedBox(
                height: 18,
              ),
              CustomTextNew(
                S.of(context).howItWorks,
                style: AskLoraTextStyles.body4
                    .copyWith(color: AskLoraColors.charcoal),
              ),
              const SizedBox(
                height: 6,
              ),
              CustomTextNew(
                botDetailModel?.botInfo.botDescription.works ?? 'NA',
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
                        '${botDetailModel?.stockInfo.tickerName} ${botDetailModel?.stockInfo.symbol}',
                        style: AskLoraTextStyles.h5
                            .copyWith(color: AskLoraColors.charcoal),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 5),
                      CustomTextNew(
                        '${S.of(context).prevClose} ${botDetailModel?.prevCloseDate ?? 'NA'}',
                        style: AskLoraTextStyles.body2
                            .copyWith(color: AskLoraColors.charcoal),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomTextNew(
                          (botDetailModel?.price ?? 0)
                              .convertToCurrencyDecimal(),
                          style: AskLoraTextStyles.h5
                              .copyWith(color: AskLoraColors.charcoal),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ToggleablePriceText(
                          fillColor: botDetailModel?.prevClosePct != null &&
                                  botDetailModel!.prevClosePct < 0
                              ? AskLoraColors.primaryMagenta
                              : AskLoraColors.primaryGreen,
                          percentDifference:
                              botDetailModel?.prevClosePctFormatted ?? 'NA',
                          priceDifference:
                              botDetailModel?.prevCloseAmtFormatted ?? 'NA',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            children: [
              PairColumnText(
                leftTitle: S.of(context).prevClose,
                leftSubTitle: botDetailModel?.prevClosePrice != null
                    ? (botDetailModel?.prevClosePrice ?? 0).toString()
                    : '-',
                rightTitle: S.of(context).marketCap,
                rightSubTitle: botDetailModel?.marketCap != null
                    ? (botDetailModel?.marketCap ?? '-')
                    : '-',
              ),
              const SizedBox(height: 10),
              const IexDataProviderLink(),
              const Divider(
                color: AskLoraColors.gray,
              ),
              CustomTextNew(
                  '${S.of(context).about} ${botDetailModel?.stockInfo.tickerName}',
                  style: AskLoraTextStyles.h6
                      .copyWith(color: AskLoraColors.charcoal)),
              const SizedBox(
                height: 21,
              ),
              PairColumnText(
                leftTitle: S.of(context).sectors,
                leftSubTitle: botDetailModel?.stockInfo.sector ?? 'NA',
                rightTitle: S.of(context).industry,
                rightSubTitle: botDetailModel?.stockInfo.industry ?? 'NA',
              ),
              _spaceBetweenInfo,
              PairColumnText(
                leftTitle: S.of(context).ceo,
                leftSubTitle: botDetailModel?.stockInfo.ceo ?? 'NA',
                rightTitle: S.of(context).employees,
                rightSubTitle: '${botDetailModel?.stockInfo.employees}',
              ),
              _spaceBetweenInfo,
              PairColumnText(
                leftTitle: S.of(context).headquarters,
                leftSubTitle: botDetailModel?.stockInfo.headquarter ?? 'NA',
                rightTitle: S.of(context).founded,
                rightSubTitle:
                    botDetailModel?.stockInfo.foundedFormatted ?? 'NA',
              ),
              const SizedBox(
                height: 23,
              ),
              CustomTextNew(
                botDetailModel?.stockInfo.description ?? 'NA',
                style: AskLoraTextStyles.body1
                    .copyWith(color: AskLoraColors.charcoal),
              )
            ],
          ),
          const SizedBox(height: 26),
        ],
      );

  Widget _detailedInformation(BuildContext context) => Padding(
        padding: AppValues.screenHorizontalPadding,
        child: CustomShowcaseView(
          tooltipPosition: TooltipPosition.bottom,
          tutorialKey: TutorialJourney.botDetails,
          onToolTipClick: () {
            ShowCaseWidget.of(context).next();
          },
          tooltipWidget: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: S.of(context).hereYouCanFind,
                    style: AskLoraTextStyles.body1),
                TextSpan(
                    text: S.of(context).botStocksDetails,
                    style: AskLoraTextStyles.subtitle2),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (botDetailModel != null)
                Column(
                  children: [
                    if (!FeatureFlags.isMockApp) ...[
                      BotPriceLevelIndicator(
                        stopLossPrice:
                            botDetailModel!.estStopLossPriceFormatted,
                        currentPrice: botDetailModel!.priceFormatted,
                        takeProfitPrice:
                            botDetailModel!.estTakeProfitPriceFormatted,
                        botType: botType,
                      ),
                      const SizedBox(height: 28),
                    ],
                    PairColumnTextWithBottomSheet(
                        leftTitle: botType == BotType.plank
                            ? S.of(context).estStopLossPercent
                            : S.of(context).estMaxLossPercent,
                        leftSubTitle: botDetailModel!.estStopLossPctFormatted,
                        rightTitle: botType == BotType.plank
                            ? S.of(context).estTakeProfitPercent
                            : S.of(context).estMaxProfitPercent,
                        rightSubTitle:
                            botDetailModel!.estTakeProfitPctFormatted,
                        leftBottomSheetText: botType == BotType.plank
                            ? S.of(context).tooltipBotDetailsEstStopLoss
                            : S.of(context).tooltipBotDetailsEstMaxLoss,
                        rightBottomSheetText: botType == BotType.plank
                            ? S.of(context).tooltipBotDetailsEstTakeProfit
                            : S.of(context).tooltipBotDetailsEstMaxProfit),
                    _spaceBetweenInfo,
                  ],
                ),
              PairColumnTextWithBottomSheet(
                  leftTitle: S.of(context).startDate,
                  leftSubTitle: '${botDetailModel?.formattedStartDate}',
                  rightTitle: S.of(context).investmentPeriod,
                  rightSubTitle: '${botDetailModel?.botDuration}',
                  leftBottomSheetText: S.of(context).tooltipBotDetailsStartDate,
                  rightBottomSheetText:
                      S.of(context).tooltipBotDetailsInvestmentPeriod),
              _spaceBetweenInfo,
              ColumnTextWithTooltip(
                  title: S.of(context).estimatedEndDate,
                  subTitle: '${botDetailModel?.endDateHKTString}'),
            ],
          ),
        ),
      );

  Widget _performanceWidget(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(15, 32, 15, 0),
        child: CustomShowcaseView(
          tutorialKey: TutorialJourney.botChart,
          tooltipPosition: TooltipPosition.bottom,
          tooltipWidget: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: S.of(context).thisInteractiveGraph,
                    style: AskLoraTextStyles.body1),
                TextSpan(
                    text: S.of(context).twoWeekPerformance,
                    style: AskLoraTextStyles.subtitle2),
                TextSpan(
                    text: S.of(context).toGiveYou,
                    style: AskLoraTextStyles.body1),
              ],
            ),
          ),
          onToolTipClick: () => ShowCaseWidget.of(context).next(),
          child: Column(
            children: [
              _chartWidget(context),
              const SizedBox(
                height: 6,
              ),
              _getChartCaption(context),
            ],
          ),
        ),
      );

  Widget _chartWidget(BuildContext context) {
    if (botDetailModel?.performance != null &&
        botDetailModel!.performance.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: ChartAnimation(chartDataSets: botDetailModel!.performance),
      );
    } else {
      return SizedBox(
        height: 300,
        child: Align(
            alignment: Alignment.center,
            child: Text(S.of(context).portfolioDetailChartEmptyMessage)),
      );
    }
  }

  Widget _getChartCaption(BuildContext context) {
    if (botDetailModel?.performance != null &&
        botDetailModel!.performance.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: CustomTextNew(
            S.of(context).portfolioDetailChartCaption(
                '${botType.upperCaseName} ${botDetailModel!.stockInfo.symbol}',
                botDetailModel!.botPerformanceStartDate,
                botDetailModel!.botPerformanceEndDate,
                botDetailModel!.botDuration),
            style: AskLoraTextStyles.body4),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
