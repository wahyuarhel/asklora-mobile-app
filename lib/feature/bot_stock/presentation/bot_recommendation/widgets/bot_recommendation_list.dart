part of '../bot_recommendation_screen.dart';

class BotRecommendationList extends StatelessWidget {
  final double _spacing = 16;
  final double botCardHeight = 166;
  final double blurPadding;
  final double verticalMargin;
  final BotStockState botStockState;

  const BotRecommendationList(
      {required this.verticalMargin, required this.botStockState, Key? key})
      : blurPadding = verticalMargin - 8,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (botStockState.botRecommendationResponse.state ==
            ResponseState.success &&
        botStockState.botRecommendationResponse.data!.data.isNotEmpty) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: verticalMargin),
        padding: AppValues.screenHorizontalPadding,
        child: Wrap(
          spacing: _spacing,
          runSpacing: _spacing,
          children: botStockState.botRecommendationResponse.data!.data.map((e) {
            return BotRecommendationCard(
              onTap: () => BotRecommendationDetailScreen.open(
                  context: context, botRecommendationModel: e),
              height: botCardHeight,
              spacing: _spacing,
              botRecommendationModel: e,
            );
          }).toList(),
        ),
      );
    } else if (botStockState.botRecommendationResponse.state ==
            ResponseState.success &&
        botStockState.botRecommendationResponse.data!.data.isEmpty) {
      return SizedBox(
        height: _getListHeight,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: blurPadding),
              padding: AppValues.screenHorizontalPadding
                  .copyWith(top: blurPadding, bottom: blurPadding),
              child: Wrap(
                spacing: _spacing,
                runSpacing: _spacing,
                children: defaultBotRecommendation
                    .map((e) => BotRecommendationCard(
                          onTap: () {},
                          height: botCardHeight,
                          botRecommendationModel: e,
                          spacing: _spacing,
                        ))
                    .toList(),
              ),
            ),
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: AppValues.screenHorizontalPadding,
                child: LoraPopUpMessage(
                  backgroundColor: AskLoraColors.charcoal,
                  title: 'No Botstock recommendations',
                  titleColor: AskLoraColors.white,
                  subTitle:
                      'Oops! Looks like there aren’t enough recommendations that meet your current investment profile - Let’s go through your Investment Style again to find suitable recommendations.',
                  subTitleColor: AskLoraColors.white,
                  primaryButtonLabel: S.of(context).retakeInvestmentStyle,
                  buttonPrimaryType: ButtonPrimaryType.solidGreen,
                  onPrimaryButtonTap: () => UserJourney.onAlreadyPassed(
                    context: context,
                    target: UserJourney.freeBotStock,
                    onTrueCallback: () => context
                        .read<NavigationBloc<ForYouPage>>()
                        .add(const PageChanged(ForYouPage.investmentStyle)),
                    onFalseCallback: () =>
                        AiInvestmentStyleQuestionWelcomeScreen.open(context),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    } else if (botStockState.botRecommendationResponse.state ==
        ResponseState.loading) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: verticalMargin),
        padding: AppValues.screenHorizontalPadding,
        child: Wrap(
          spacing: _spacing,
          runSpacing: _spacing,
          children: defaultBotRecommendation
              .map((e) => BotRecommendationCardShimmer(
                    height: botCardHeight,
                    spacing: _spacing,
                  ))
              .toList(),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(vertical: blurPadding),
        padding: AppValues.screenHorizontalPadding
            .copyWith(top: blurPadding, bottom: blurPadding),
        child: Wrap(
          spacing: _spacing,
          runSpacing: _spacing,
          children: defaultBotRecommendation
              .map((e) => BotRecommendationCard(
                    onTap: () {},
                    height: botCardHeight,
                    botRecommendationModel: e,
                    spacing: _spacing,
                  ))
              .toList(),
        ),
      );
    }
  }

  double get _getListHeight =>
      botCardHeight * defaultBotRecommendation.length / 2 +
      _spacing * ((defaultBotRecommendation.length / 2).ceil() - 1) +
      2 * blurPadding;
}
