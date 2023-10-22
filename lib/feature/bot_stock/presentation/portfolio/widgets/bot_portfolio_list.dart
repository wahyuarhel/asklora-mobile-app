part of '../portfolio_screen.dart';

class BotPortfolioList extends StatelessWidget {
  final double _spacing = 16;
  final double _runSpacing = 8;
  final double botCardHeight = 196;
  final UserJourney userJourney;
  final PortfolioState portfolioState;

  const BotPortfolioList(
      {required this.userJourney, required this.portfolioState, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_header(context), _botList],
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextNew(
            S.of(context).portfolioYourBotStock,
            style: AskLoraTextStyles.h2.copyWith(color: AskLoraColors.charcoal),
          ),
        ),
        const BotPortfolioFilter()
      ],
    );
  }

  Widget get _botList {
    if (userJourney == UserJourney.investmentStyle) {
      return const BotPortfolioPopUp(
          botPortfolioPopUpType: BotPortfolioPopUpType.investmentStyle);
    } else if (userJourney == UserJourney.kyc) {
      return const BotPortfolioPopUp(
          botPortfolioPopUpType: BotPortfolioPopUpType.kyc);
    } else if (userJourney == UserJourney.freeBotStock) {
      return const BotPortfolioPopUp(
          botPortfolioPopUpType: BotPortfolioPopUpType.redeemBotStock);
    } else if (userJourney == UserJourney.deposit) {
      return const BotPortfolioPopUp(
          botPortfolioPopUpType: BotPortfolioPopUpType.deposit);
    } else {
      if (portfolioState.botActiveOrderResponse.state ==
          ResponseState.success) {
        if (portfolioState.botActiveOrderResponse.data!.isNotEmpty) {
          return SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: _spacing,
              runSpacing: _runSpacing,
              children: portfolioState.botActiveOrderResponse.data!
                  .map((e) => BotPortfolioCard(
                        height: botCardHeight,
                        spacing: _spacing,
                        botActiveOrderModel: e,
                      ))
                  .toList(),
            ),
          );
        } else if (portfolioState.isFilterChecked) {
          return const BotPortfolioPopUp(
              botPortfolioPopUpType: BotPortfolioPopUpType.noBotStock);
        } else {
          return const SizedBox.shrink();
        }
      } else if (portfolioState.botActiveOrderResponse.state ==
          ResponseState.loading) {
        return Wrap(
          spacing: _spacing,
          runSpacing: _runSpacing,
          children: defaultBotRecommendation
              .map(
                (e) => BotPortfolioCardShimmer(
                  height: botCardHeight,
                  spacing: _spacing,
                ),
              )
              .toList(),
        );
      } else if (portfolioState.botActiveOrderResponse.state ==
              ResponseState.error &&
          portfolioState.botActiveOrderResponse.validationCode ==
              ValidationCode.tradeAuthorization) {
        //403 is to show error on pending review (not registered yet to broker)
        return const BotPortfolioPopUp(
            botPortfolioPopUpType: BotPortfolioPopUpType.pendingReview);
      } else {
        return const SizedBox();
      }
    }
  }
}
