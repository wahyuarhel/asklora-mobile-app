part of '../../bot_portfolio_detail_screen.dart';

class BotPortfolioButtons extends StatelessWidget {
  final PortfolioState portfolioState;
  const BotPortfolioButtons({required this.portfolioState, super.key});

  @override
  Widget build(BuildContext context) {
    if (portfolioState.botActiveOrderDetailResponse.state ==
            ResponseState.success &&
        UserJourney.compareUserJourney(
            context: context, target: UserJourney.deposit)) {
      final BotActiveOrderDetailModel botActiveOrderDetailModel =
          portfolioState.botActiveOrderDetailResponse.data!;
      return Padding(
        padding:
            AppValues.screenHorizontalPadding.copyWith(top: 36, bottom: 30),
        child: Column(
          children: [
            ///TODO : NEED TO TEMPORARY REMOVED AS AL1-2846
            // if (botStatus == BotStatus.liveExpireSoon)
            //   Padding(
            //     padding: const EdgeInsets.only(bottom: 20.0),
            //     child: BotRolloverButton(
            //       botActiveOrderDetailModel: botActiveOrderDetailModel,
            //       botType: botType,
            //     ),
            //   ),

            if (portfolioState.isShowTerminateButton)
              if (botActiveOrderDetailModel.terminationRequested)
                Padding(
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: IgnorePointer(
                    child: PrimaryButton(
                      label: S.of(context).requestedToEnd,
                      onTap: () => '',
                      buttonPrimaryType: ButtonPrimaryType.ghostCharcoal,
                      disabled: true,
                    ),
                  ),
                )
              else
                BotTerminateButton(
                  botActiveOrderDetailModel: botActiveOrderDetailModel,
                  botType: botActiveOrderDetailModel.botType,
                ),

            if (portfolioState.isShowCancelButton)
              BotCancelButton(
                botActiveOrderDetailModel: botActiveOrderDetailModel,
              ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
