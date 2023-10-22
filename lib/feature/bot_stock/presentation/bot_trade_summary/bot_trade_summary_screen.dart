import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../../core/presentation/buttons/primary_button.dart';
import '../../../../../../core/presentation/custom_text_new.dart';
import '../../../../../../core/styles/asklora_colors.dart';
import '../../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../core/domain/base_response.dart';
import '../../../../app/bloc/app_bloc.dart';
import '../../../../core/domain/validation_enum.dart';
import '../../../../core/presentation/column_text/pair_column_text.dart';
import '../../../../core/presentation/column_text/pair_column_text_with_bottom_sheet.dart';
import '../../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../../core/presentation/round_colored_box.dart';
import '../../../../core/presentation/suspended_account_screen.dart';
import '../../../../core/presentation/tutorial/Utils/tutorial_journey.dart';
import '../../../../core/presentation/tutorial/bloc/tutorial_bloc.dart';
import '../../../../core/presentation/tutorial/custom_show_case_view.dart';
import '../../../../core/repository/transaction_repository.dart';
import '../../../../core/repository/tutorial_repository.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../generated/l10n.dart';
import '../../../tabs/presentation/tab_screen.dart';
import '../../../tabs/utils/tab_util.dart';
import '../../bloc/bot_stock_bloc.dart';
import '../../domain/bot_recommendation_detail_model.dart';
import '../../domain/bot_recommendation_model.dart';
import '../../domain/orders/bot_create_order_response.dart';
import '../../repository/bot_stock_repository.dart';
import '../../utils/bot_stock_bottom_sheet.dart';
import '../../utils/bot_stock_utils.dart';
import '../bot_stock_result_screen.dart';
import '../widgets/bot_stock_form.dart';

class BotTradeSummaryModel {
  final double amount;
  final BotRecommendationModel botRecommendationModel;
  final BotRecommendationDetailModel botDetailModel;
  final BotType botType;
  final VoidCallback onCreateOrderSuccessCallback;

  BotTradeSummaryModel(
      {required this.botType,
      required this.amount,
      required this.botRecommendationModel,
      required this.botDetailModel,
      required this.onCreateOrderSuccessCallback});
}

class BotTradeSummaryScreen extends StatelessWidget {
  static const String route = '/bot_trade_summary_screen';

  final BotTradeSummaryModel botTradeSummaryModel;

  final SizedBox _spaceBetweenInfo = const SizedBox(
    height: 16,
  );

  const BotTradeSummaryScreen({required this.botTradeSummaryModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BotRecommendationDetailModel botDetailModel =
        botTradeSummaryModel.botDetailModel;
    final isFreeBotTrade = botTradeSummaryModel.botRecommendationModel.freeBot;
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => BotStockBloc(
                    botStockRepository: BotStockRepository(),
                    transactionRepository: TransactionRepository(),
                  )),
          BlocProvider(
              create: (_) =>
                  TutorialBloc(tutorialRepository: TutorialRepository())
                    ..add(InitiateTradeSummaryTutorial())),
        ],
        child: ShowCaseWidget(
          disableBarrierInteraction: true,
          disableMovingAnimation: true,
          showCaseViewScrollPosition: ShowCaseViewScrollPosition.scrollToTop,
          blurValue: 2.5,
          builder: Builder(builder: (context) {
            return BlocListener<TutorialBloc, TutorialState>(
              listenWhen: (_, current) => current.isTradeSummaryTutorial,
              listener: (context, state) => Future.delayed(
                  const Duration(milliseconds: 300),
                  () => ShowCaseWidget.of(context)
                      .startShowCase([TutorialJourney.summaryTrade])),
              child: BlocListener<BotStockBloc, BotStockState>(
                listenWhen: (previous, current) =>
                    previous.createBotOrderResponse !=
                    current.createBotOrderResponse,
                listener: (context, state) {
                  CustomLoadingOverlay.of(context)
                      .show(state.createBotOrderResponse.state);

                  if (state.createBotOrderResponse.state ==
                      ResponseState.success) {
                    botTradeSummaryModel.onCreateOrderSuccessCallback();
                    if (!UserJourney.compareUserJourney(
                        context: context, target: UserJourney.deposit)) {
                      context.read<AppBloc>().add(
                            const SaveUserJourney(UserJourney.deposit),
                          );
                    }

                    if (isFreeBotTrade) {
                      TabScreen.openAndRemoveAllRoute(context,
                          initialTabPage: TabPage.portfolio);
                      BotStockBottomSheet.freeBotStockSuccessfullyAdded(
                          context);
                    } else {
                      BotStockResultScreen.openReplace(
                          context: context,
                          arguments: BotStockResultArgument(
                            title: S.of(context).tradeRequestSubmitted,
                            desc: _tradeRequestSuccessMessage(
                                context, state.createBotOrderResponse.data!),
                          ));
                    }
                  } else if (state.createBotOrderResponse.state ==
                      ResponseState.suspended) {
                    SuspendedAccountScreen.open(context);
                  } else if (state.createBotOrderResponse.state ==
                      ResponseState.error) {
                    if (state.createBotOrderResponse.validationCode ==
                        ValidationCode.tradeAuthorization) {
                      BotStockBottomSheet.notYetRegisteredToBroker(context);

                      ///TODO : INSUFFICIENT BALANCE ERROR IS SAME 403 THEREFORE WILL BE IMPLEMENTED LATER WHEN GOT NEW ENUM STATUS_CODE
                      //BotStockBottomSheet.insufficientBalance(context);
                    } else {
                      BotStockBottomSheet.generalError(context);
                    }
                  }
                },
                child: BotStockForm(
                    useHeader: true,
                    title:
                        '${botDetailModel.botInfo.botName} ${botTradeSummaryModel.botRecommendationModel.tickerSymbol}',
                    content: Column(
                      children: [
                        CustomShowcaseView(
                          tutorialKey: TutorialJourney.summaryTrade,
                          tooltipWidget: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: S.of(context).reviewYourTradeSummary,
                                    style: AskLoraTextStyles.body1),
                                TextSpan(
                                    text: S.of(context).confirmTrade,
                                    style: AskLoraTextStyles.subtitle2),
                                TextSpan(
                                    text: S.of(context).toExecuteIt,
                                    style: AskLoraTextStyles.body1)
                              ],
                            ),
                          ),
                          onToolTipClick: () =>
                              _onTradeSummaryTutorialFinished(context),
                          child: RoundColoredBox(
                            content: Column(
                              children: [
                                PairColumnTextWithBottomSheet(
                                  leftTitle:
                                      '${S.of(context).investmentAmount} (HKD)',
                                  rightTitle:
                                      '${S.of(context).botManagementFee} (HKD)',
                                  leftSubTitle: botTradeSummaryModel.amount
                                      .convertToCurrencyDecimal(),
                                  rightSubTitle: S.of(context).free,
                                  rightBottomSheetText:
                                      S.of(context).botManagementFeeTooltip,
                                ),
                                _spaceBetweenInfo,
                                ..._detailedInformation(context),
                                _spaceBetweenInfo,
                                PairColumnText(
                                    leftTitle:
                                        '${S.of(context).marketPrice} (USD)',
                                    leftSubTitle:
                                        '${botTradeSummaryModel.botDetailModel.price}',
                                    rightTitle: S.of(context).investmentPeriod,
                                    rightSubTitle: botDetailModel.botDuration),
                                _spaceBetweenInfo,
                                PairColumnText(
                                    leftTitle: S.of(context).startDate,
                                    rightTitle: S.of(context).endDate,
                                    leftSubTitle: botTradeSummaryModel
                                        .botDetailModel.formattedStartDate,
                                    rightSubTitle: botTradeSummaryModel
                                        .botDetailModel.endDateHKTString),
                              ],
                            ),
                            title: isFreeBotTrade
                                ? 'Free Botstock Trade Summary'
                                : S.of(context).tradeSummary,
                          ),
                        ),
                        const SizedBox(
                          height: 19,
                        ),
                        if (isFreeBotTrade)
                          RoundColoredBox(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 13),
                            backgroundColor: AskLoraColors.lightGreen,
                            content: CustomTextNew(
                              'You will have more flexibility in the next real trade. Come on, this is FREE!',
                              style: AskLoraTextStyles.body1
                                  .copyWith(color: AskLoraColors.charcoal),
                            ),
                          ),
                      ],
                    ),
                    bottomButton: Builder(
                        builder: (context) => Padding(
                              padding:
                                  const EdgeInsets.only(top: 24, bottom: 30),
                              child: PrimaryButton(
                                label: S.of(context).confirmTrade,
                                onTap: () {
                                  context.read<BotStockBloc>().add(
                                      CreateBotOrder(
                                          botRecommendationModel:
                                              botTradeSummaryModel
                                                  .botRecommendationModel,
                                          tradeBotStockAmount:
                                              botTradeSummaryModel.amount));
                                },
                              ),
                            ))),
              ),
            );
          }),
        ));
  }

  List<Widget> _detailedInformation(BuildContext context) => [
        PairColumnText(
          crossAxisAlignment: CrossAxisAlignment.start,
          leftTitle: botTradeSummaryModel.botType == BotType.plank
              ? S.of(context).estStopLossPercent
              : S.of(context).estMaxLossPercent,
          leftSubTitle:
              botTradeSummaryModel.botDetailModel.estStopLossPctFormatted,
          rightTitle: botTradeSummaryModel.botType == BotType.plank
              ? S.of(context).estTakeProfitPercent
              : S.of(context).estMaxProfitPercent,
          rightSubTitle:
              botTradeSummaryModel.botDetailModel.estTakeProfitPctFormatted,
        ),
      ];

  String _tradeRequestSuccessMessage(
          BuildContext context, BotCreateOrderResponse createOrderResponse) =>
      S.of(context).startBotStockAcknowledgement(
          createOrderResponse.botAppsName, createOrderResponse.symbol);

  void _onTradeSummaryTutorialFinished(BuildContext context) {
    ShowCaseWidget.of(context).dismiss();
    context.read<TutorialBloc>().add(TradeSummaryTutorialFinished());
  }

  static void open(
          {required BuildContext context,
          required BotTradeSummaryModel botTradeSummaryModel}) =>
      Navigator.of(context, rootNavigator: true)
          .pushNamed(route, arguments: botTradeSummaryModel);

  static void openWithBackCallBack(
          {required BuildContext context,
          required BotTradeSummaryModel botTradeSummaryModel,
          required VoidCallback backCallBack}) =>
      Navigator.of(context, rootNavigator: true)
          .pushNamed(route, arguments: botTradeSummaryModel)
          .then((value) => backCallBack());
}
