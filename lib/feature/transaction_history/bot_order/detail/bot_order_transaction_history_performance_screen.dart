part of 'bot_order_transaction_history_detail_screen.dart';

class BotOrderTransactionHistoryPerformanceScreen extends StatelessWidget {
  final String botOrderId;

  const BotOrderTransactionHistoryPerformanceScreen(
      {required this.botOrderId, Key? key})
      : super(key: key);

  final SizedBox _spaceBetweenInfo = const SizedBox(
    height: 16,
  );

  @override
  Widget build(BuildContext context) => BlocBuilder<
          BotTransactionHistoryDetailBloc, BotTransactionHistoryDetailState>(
      buildWhen: (previous, current) =>
          previous.response.state != current.response.state,
      builder: (context, state) {
        if (state.response.state == ResponseState.success) {
          BotDetailTransactionHistoryResponse data = state.response.data!;
          BotType botType = BotType.findByString(data.botInfo.botName);
          return ListView(
            padding: AppValues.screenHorizontalPadding.copyWith(top: 20),
            children: [
              RoundColoredBox(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: ColumnTextWithTooltip(
                            title: S
                                .of(context)
                                .portfolioDetailPerformanceBotStockValues,
                            subTitle: data.botStockValueString)),
                    Expanded(
                        child: ColumnTextWithTooltip(
                            title: S
                                .of(context)
                                .portfolioDetailPerformanceInvestmentAmount,
                            subTitle: data.investmentAmountString)),
                    Expanded(
                        child: ColumnTextWithTooltip(
                            title:
                                S.of(context).portfolioDetailPerformanceTotalPL,
                            subTitle: data.totalPnLPctString)),
                  ],
                ),
              ),
              const SizedBox(
                height: 42,
              ),
              CustomTextNew(
                S.of(context).portfolioDetailKeyInfoTitle,
                style: AskLoraTextStyles.h5,
              ),
              const SizedBox(
                height: 20,
              ),
              PairColumnTextWithTooltip(
                leftTitle: S.of(context).investmentPeriod,
                leftSubTitle: data.botDuration,
                rightTitle: '',
                rightSubTitle: '',
              ),
              _spaceBetweenInfo,
              PairColumnTextWithTooltip(
                  leftTitle: S.of(context).portfolioDetailKeyInfoStartTime,
                  leftSubTitle: data.spotDateFormatted,
                  rightTitle: S.of(context).portfolioDetailKeyInfoEndTime,
                  rightSubTitle:
                      data.expireDateFormatted(dateFormat: 'dd/MM/yy')),
              _spaceBetweenInfo,
              _stopLossMaxProfit(context, botType, data),
            ],
          );
        } else {
          ///TODO add error UI later
          return const SizedBox.shrink();
        }
      });

  Widget _stopLossMaxProfit(BuildContext context, BotType botType,
          BotDetailTransactionHistoryResponse data) =>
      PairColumnTextWithTooltip(
        leftTitle: botType == BotType.plank
            ? S.of(context).portfolioDetailKeyInfoEstimatedStopLoss
            : S.of(context).portfolioDetailKeyInfoEstimatedMaxLoss,
        leftSubTitle: data.estMaxLossPctString,
        rightTitle: botType == BotType.plank
            ? S.of(context).portfolioDetailKeyInfoEstimatedTakeProfit
            : S.of(context).portfolioDetailKeyInfoEstimatedMaxProfit,
        rightSubTitle: data.estMaxProfitPctString,
      );

// Widget _chartWidget(BuildContext context, String botOrderId) => Align(
//     alignment: Alignment.center,
//     child: BotPerformanceChart(
//       botOrderId: botOrderId,
//       chartCaption: null,
//     ));
}
