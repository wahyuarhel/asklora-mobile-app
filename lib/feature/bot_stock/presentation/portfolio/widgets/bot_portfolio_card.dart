part of '../portfolio_screen.dart';

class BotPortfolioCard extends StatelessWidget {
  final BotActiveOrderModel botActiveOrderModel;
  final double spacing;
  final double height;

  const BotPortfolioCard(
      {required this.height,
      required this.spacing,
      required this.botActiveOrderModel,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BotType botType =
        BotType.findByString(botActiveOrderModel.botAppsName);
    return GestureDetector(
      onTap: () {
        context
            .read<TabScreenBloc>()
            .add(TabChanged(TabPage.portfolio.setData(arguments: (
              path: SubTabPage.portfolioBotStockDetails.value,
              arguments: {
                'botType': botType.internalName,
                'symbol': botActiveOrderModel.symbol,
                'ticker': botActiveOrderModel.ticker,
                'duration': botActiveOrderModel.botDuration
              }
            ))));

        BotPortfolioDetailScreen.open(
            context: context,
            arguments: BotPortfolioDetailArguments(
              botUid: botActiveOrderModel.uid,
              botName: botActiveOrderModel.botName,
              callback: () {
                context.read<PortfolioBloc>().add(const FetchActiveOrders());
                context.read<PortfolioBloc>().add(FetchBalance());
              },
            ));
      },
      child: Stack(
        children: [
          Container(
            height: height,
            margin: const EdgeInsets.only(top: 10),
            width: (MediaQuery.of(context).size.width -
                    AppValues.screenHorizontalPadding.left -
                    AppValues.screenHorizontalPadding.right -
                    spacing) /
                2,
            padding: const EdgeInsets.fromLTRB(14, 20, 14, 11),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: botType.primaryBgColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextNew(
                      botActiveOrderModel.symbol,
                      style: AskLoraTextStyles.h5,
                      maxLines: 1,
                      ellipsis: true,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    AutoSizedTextWidget(
                      botActiveOrderModel.tickerName,
                      style: AskLoraTextStyles.body2,
                      maxLines: 2,
                      minFontSize: 9,
                      ellipsis: true,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 13,
                ),
                PairColumnTextWithAutoSizedText(
                  leftTitle: S.of(context).botValues,
                  rightTitle: S.of(context).portfolioTotalPL,
                  leftSubTitle: '\$${botActiveOrderModel.botStockValueString}',
                  rightSubTitle: botActiveOrderModel.totalPnLPctString,
                  maxLines: 1,
                  spaceWidth: 15.0,
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  decoration: BoxDecoration(
                      color: botType.secondaryBgColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: AutoSizedTextWidget(
                      botActiveOrderModel.startOrExpireShowDateOnly(context),
                      style: AskLoraTextStyles.subtitle4
                          .copyWith(color: botType.expiredTextColor),
                      maxLines: 1),
                )
              ],
            ),
          ),
          if (botActiveOrderModel.isDummy) const FreeBotBadge()
        ],
      ),
    );
  }
}
