part of '../bot_portfolio_detail_screen.dart';

class KeyInfo extends StatelessWidget {
  final BotActiveOrderDetailModel botActiveOrderDetailModel;
  final BotStatus botStatus;
  final BotType botType;
  final SizedBox _spaceBetweenInfo = const SizedBox(
    height: 16,
  );

  const KeyInfo(
      {required this.botActiveOrderDetailModel,
      required this.botStatus,
      required this.botType,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextNew(
            S.of(context).portfolioDetailKeyInfoTitle,
            style: AskLoraTextStyles.h5,
          ),
          const SizedBox(
            height: 20,
          ),
          PairColumnTextWithTooltip(
              leftTitle: S.of(context).investmentPeriod,
              leftSubTitle: botActiveOrderDetailModel.botDuration,
              rightTitle: S.of(context).portfolioDetailKeyInfoDaysTillExpiry,
              rightSubTitle: botActiveOrderDetailModel.daysToExpireString),
          _spaceBetweenInfo,
          PairColumnTextWithTooltip(
              leftTitle: S.of(context).portfolioDetailKeyInfoStartTime,
              leftSubTitle: botActiveOrderDetailModel.startDateHKTString,
              rightTitle: S.of(context).portfolioDetailKeyInfoEndTime,
              rightSubTitle: botActiveOrderDetailModel.estEndDateFormatted),
          _spaceBetweenInfo,
          ..._stopLossMaxProfit(context),
          _spaceBetweenInfo,
          ColumnText(
              title: S.of(context).portfolioDetailKeyInfoBotStockStatus,
              subTitle: botStatus.name),
          if (!FeatureFlags.isMockApp) ...[
            const SizedBox(
              height: 40,
            ),
            RoundColoredBox(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _columnTextBigTitle(
                      title: botActiveOrderDetailModel.avgReturnString,
                      subTitle: S.of(context).portfolioDetailKeyInfoAvgReturn),
                  _columnTextBigTitle(
                      title: botActiveOrderDetailModel.avgLossString,
                      subTitle: S.of(context).portfolioDetailKeyInfoAvgLoss),
                  _columnTextBigTitle(
                      title: botActiveOrderDetailModel.avgPeriodString,
                      subTitle: S.of(context).portfolioDetailKeyInfoAvgPeriod),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            )
          ]
        ],
      );

  List<Widget> _stopLossMaxProfit(BuildContext context) => [
        PairColumnTextWithTooltip(
          leftTitle: botType == BotType.plank
              ? S.of(context).portfolioDetailKeyInfoEstimatedStopLoss
              : S.of(context).portfolioDetailKeyInfoEstimatedMaxLoss,
          leftSubTitle: botActiveOrderDetailModel.maxLossPctString,
          rightTitle: botType == BotType.plank
              ? S.of(context).portfolioDetailKeyInfoEstimatedTakeProfit
              : S.of(context).portfolioDetailKeyInfoEstimatedMaxProfit,
          rightSubTitle: botActiveOrderDetailModel.targetProfitPctString,
        ),
      ];

  Widget _columnTextBigTitle(
          {required String title, required String subTitle}) =>
      Column(
        children: [
          CustomTextNew(
            title,
            style: AskLoraTextStyles.h4.copyWith(color: AskLoraColors.charcoal),
          ),
          const SizedBox(
            height: 6,
          ),
          CustomTextNew(
            subTitle,
            style:
                AskLoraTextStyles.body3.copyWith(color: AskLoraColors.charcoal),
          ),
        ],
      );
}
