part of '../bot_recommendation_screen.dart';

class BotRecommendationCard extends StatelessWidget {
  final double height;
  final BotRecommendationModel botRecommendationModel;
  final double spacing;
  final VoidCallback onTap;
  final bool isDisabled;

  const BotRecommendationCard(
      {required this.onTap,
      required this.height,
      required this.spacing,
      required this.botRecommendationModel,
      this.isDisabled = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BotType botType =
        BotType.findByString(botRecommendationModel.botAppType);
    return GestureDetector(
      onTap: () {
        _setTabData(context, botType);
        isDisabled ? () {} : onTap();
      },
      child: Container(
        height: height,
        width: (MediaQuery.of(context).size.width -
                AppValues.screenHorizontalPadding.left -
                AppValues.screenHorizontalPadding.right -
                spacing) /
            2,
        padding: const EdgeInsets.fromLTRB(14, 11, 14, 11),
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
                  botRecommendationModel.tickerSymbol,
                  style: AskLoraTextStyles.h5,
                  maxLines: 1,
                  ellipsis: true,
                ),
                const SizedBox(
                  height: 4,
                ),
                CustomTextNew(
                  botRecommendationModel.tickerName,
                  style: AskLoraTextStyles.body2,
                  maxLines: 1,
                  ellipsis: true,
                ),
                const SizedBox(
                  height: 13,
                ),
                CustomTextNew(
                  botRecommendationModel.botAppType,
                  style: AskLoraTextStyles.body1,
                ),
                if (!FeatureFlags.isMockApp)
                  Column(
                    children: [
                      const SizedBox(height: 1),
                      CustomTextNew(
                        '\$${botRecommendationModel.latestPriceFormatted}',
                        style: AskLoraTextStyles.subtitle2,
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 32,
                child: PrimaryButton(
                    disabled: isDisabled,
                    buttonPrimarySize: ButtonPrimarySize.small,
                    label: botRecommendationModel.freeBot
                        ? 'FREE TRADE'
                        : S.of(context).trade,
                    onTap: () {
                      _setTabData(context, botType);
                      onTap();
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _setTabData(BuildContext context, BotType botType) {
    context
        .read<TabScreenBloc>()
        .add(TabChanged(TabPage.forYou.setData(arguments: (
          path: SubTabPage.recommendationsBotStockDetails.value,
          arguments: {
            'botType': botType.internalName,
            'symbol': botRecommendationModel.tickerSymbol,
            'ticker': botRecommendationModel.ticker,
            'duration': botRecommendationModel.botDuration
          }
        ))));
  }
}
