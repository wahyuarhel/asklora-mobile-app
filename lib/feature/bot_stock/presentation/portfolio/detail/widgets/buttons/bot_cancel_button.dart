part of '../../bot_portfolio_detail_screen.dart';

class BotCancelButton extends StatelessWidget {
  final BotActiveOrderDetailModel botActiveOrderDetailModel;

  const BotCancelButton({required this.botActiveOrderDetailModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocListener<PortfolioBloc, PortfolioState>(
        listenWhen: (previous, current) =>
            previous.cancelBotStockResponse.state !=
            current.cancelBotStockResponse.state,
        listener: (context, state) {
          CustomLoadingOverlay.of(context)
              .show(state.cancelBotStockResponse.state);
          if (state.cancelBotStockResponse.state == ResponseState.success) {
            context.read<BackButtonInterceptorBloc>().add(RemoveInterceptor());
            BotStockResultScreen.openWithBackCallBack(
                context: context,
                arguments: BotStockResultArgument(
                    title: S.of(context).tradeCancelledTitle,
                    desc: S.of(context).tradeCancelledSubtitle,
                    botOrderType: BotOrderType.cancel),
                backCallBack: () => context
                    .read<BackButtonInterceptorBloc>()
                    .add(InitiateInterceptor()));
          } else if (state.cancelBotStockResponse.state ==
              ResponseState.suspended) {
            SuspendedAccountScreen.open(context);
          } else if (state.cancelBotStockResponse.state ==
              ResponseState.error) {
            ///TODO : Later (after error code implemented) to handle erro
            ///when the status have changed to live before hitting cancel
            ///currently is having status code 400
            CustomInAppNotification.show(
                context, state.cancelBotStockResponse.message);
          }
        },
        child: PrimaryButton(
          buttonPrimaryType: ButtonPrimaryType.ghostCharcoal,
          label: S.of(context).portfolioDetailButtonCancelBotStock,
          onTap: () => BotStockBottomSheet.cancelBotStockConfirmation(
              context: context,
              orderId: botActiveOrderDetailModel.uid,

              ///TODO : Later should add management fee when subscription done
              amount: botActiveOrderDetailModel.investmentAmountString),
        ),
      );
}
