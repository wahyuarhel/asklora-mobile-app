part of '../../bot_portfolio_detail_screen.dart';

class BotRolloverButton extends StatelessWidget {
  final BotActiveOrderDetailModel botActiveOrderDetailModel;
  final BotType botType;

  const BotRolloverButton(
      {required this.botActiveOrderDetailModel,
      required this.botType,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocListener<PortfolioBloc, PortfolioState>(
        listenWhen: (previous, current) =>
            previous.rolloverBotStockResponse.state !=
            current.rolloverBotStockResponse.state,
        listener: (context, state) {
          CustomLoadingOverlay.of(context)
              .show(state.rolloverBotStockResponse.state);
          if (state.rolloverBotStockResponse.state == ResponseState.success) {
            BotStockResultScreen.open(
              context: context,
              arguments: BotStockResultArgument(
                title: S.of(context).tradeRequestSubmitted,
                desc:
                    '${botType.name} ${botActiveOrderDetailModel.stockInfoWithPlaceholder.symbol} will rollover at ${newExpiryDateOnRollover(state.rolloverBotStockResponse.data!.newExpireDate)}',
              ),
            );
          } else if (state.rolloverBotStockResponse.state ==
              ResponseState.suspended) {
            SuspendedAccountScreen.open(context);
          } else if (state.rolloverBotStockResponse.state ==
              ResponseState.error) {
            CustomInAppNotification.show(
                context, state.rolloverBotStockResponse.message);
          }
        },
        child: PrimaryButton(
          label: S.of(context).portfolioDetailButtonRolloverBotStock,
          onTap: () => BotStockBottomSheet.rolloverBotStockConfirmation(context,
              orderId: botActiveOrderDetailModel.uid,
              expireDate: botActiveOrderDetailModel.daysToExpireString),
        ),
      );
}
