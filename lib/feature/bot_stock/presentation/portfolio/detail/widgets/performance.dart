part of '../bot_portfolio_detail_screen.dart';

class Performance extends StatelessWidget {
  final BotType botType;
  final BotActiveOrderDetailModel botActiveOrderDetailModel;

  final SizedBox _spaceBetweenInfo = const SizedBox(
    height: 16,
  );

  const Performance(
      {required this.botActiveOrderDetailModel,
      required this.botType,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomTextNew(
          S.of(context).performance,
          style: AskLoraTextStyles.h5,
        ),
        const SizedBox(
          height: 20,
        ),
        RoundColoredBox(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: ColumnTextWithTooltip(
                      title: S
                          .of(context)
                          .portfolioDetailPerformanceBotStockValues,
                      subTitle: botActiveOrderDetailModel.botStockValueString)),
              Expanded(
                  child: ColumnTextWithTooltip(
                      title: S
                          .of(context)
                          .portfolioDetailPerformanceInvestmentAmount,
                      subTitle:
                          botActiveOrderDetailModel.investmentAmountString)),
              Expanded(
                  child: ColumnTextWithTooltip(
                      title: S.of(context).portfolioDetailPerformanceTotalPL,
                      subTitle: botActiveOrderDetailModel.totalPnLPctString)),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        PairColumnTextWithBottomSheet(
          leftTitle: S.of(context).portfolioCurrentPrice,
          leftSubTitle: botActiveOrderDetailModel.currentPriceString,
          rightTitle: S.of(context).portfolioDetailPerformanceNumberOfShares,
          rightSubTitle: botActiveOrderDetailModel.botShareString,
          rightBottomSheetText:
              S.of(context).portfolioDetailPerformanceNumberOfSharesTooltip,
        ),
        _spaceBetweenInfo,
        PairColumnText(
          leftTitle: S.of(context).portfolioDetailPerformanceStockValues,
          leftSubTitle: botActiveOrderDetailModel.stockValuesString,
          rightTitle: S.of(context).portfolioDetailPerformanceCash,
          rightSubTitle: botActiveOrderDetailModel.botCashBalanceString,
        ),
        _spaceBetweenInfo,
        ColumnTextWithBottomSheet(
          title: S.of(context).portfolioDetailPerformanceBotAssetsInStock,
          subTitle: botActiveOrderDetailModel.botAssetInStockPctString,
          bottomSheetText:
              S.of(context).portfolioDetailPerformanceBotAssetsInStockTooltip,
        ),
        const SizedBox(
          height: 32,
        ),
        if (!FeatureFlags.isMockApp) _chartWidget(context)
      ]);

  Widget _chartWidget(BuildContext context) => Align(
      alignment: Alignment.center,
      child: BotPerformanceChart(
        botOrderId: botActiveOrderDetailModel.uid,
        chartCaption: _getChartCaption(context),
      ));

  Widget _getChartCaption(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: CustomTextNew(
            S.of(context).portfolioDetailChartCaption(
                '${botType.upperCaseName} ${botActiveOrderDetailModel.stockInfoWithPlaceholder.symbol}',
                botActiveOrderDetailModel.spotDate,
                botActiveOrderDetailModel.expireDateFormatted(),
                botActiveOrderDetailModel.botDuration),
            style: AskLoraTextStyles.body4),
      );
}
