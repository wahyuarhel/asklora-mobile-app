import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../app/bloc/app_bloc.dart';
import '../../../core/domain/base_response.dart';
import '../../../core/presentation/custom_in_app_notification.dart';
import '../../../core/presentation/custom_layout_with_blur_pop_up.dart';
import '../../../core/presentation/custom_scaffold.dart';
import '../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../core/presentation/lora_popup_message/model/lora_pop_up_message_model.dart';
import '../../../core/presentation/tutorial/Utils/tutorial_journey.dart';
import '../../../core/presentation/tutorial/bloc/tutorial_bloc.dart';
import '../../../core/presentation/tutorial/custom_show_case_view.dart';
import '../../../core/repository/transaction_repository.dart';
import '../../../core/repository/tutorial_repository.dart';
import '../../../core/styles/asklora_colors.dart';
import '../../../core/styles/asklora_text_styles.dart';
import '../../../core/utils/app_icons.dart';
import '../../../core/utils/route_generator.dart';
import '../../../core/utils/storage/cache/json_cache_shared_preferences.dart';
import '../../../core/utils/storage/shared_preference.dart';
import '../../../generated/l10n.dart';
import '../../bot_stock/bloc/bot_stock_bloc.dart';
import '../../bot_stock/presentation/portfolio/bloc/portfolio_bloc.dart';
import '../../bot_stock/presentation/portfolio/portfolio_screen.dart';
import '../../bot_stock/repository/bot_stock_repository.dart';
import '../../onboarding/kyc/repository/account_repository.dart';
import '../../onboarding/ppi/bloc/response/user_response_bloc.dart';
import '../../onboarding/ppi/repository/ppi_question_repository.dart';
import '../../onboarding/ppi/repository/ppi_response_repository.dart';
import '../../settings/bloc/account_information/account_information_bloc.dart';
import '../../tabs/bloc/tab_screen_bloc.dart';
import '../../tabs/for_you/bloc/for_you_bloc.dart';
import '../../tabs/for_you/for_you_screen_form.dart';
import '../../tabs/for_you/investment_style/bloc/for_you_question_bloc.dart';
import '../../tabs/for_you/repository/for_you_repository.dart';
import '../../tabs/home/home_screen_form.dart';
import '../ai_landing_page/presentation/ai_landing_page.dart';
import '../utils/tab_util.dart';
import 'widgets/ai_overlay.dart';

part 'widgets/tab_pages.dart';
part 'widgets/tabs.dart';

class TabScreen extends StatelessWidget {
  static const String route = '/custom_tab_screen';
  final TabPage? initialTabPage;

  const TabScreen({this.initialTabPage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                TutorialBloc(tutorialRepository: TutorialRepository()),
          ),
          BlocProvider(
            create: (_) =>
                AccountInformationBloc(accountRepository: AccountRepository())
                  ..add(GetAccountInformation()),
          ),
          BlocProvider(
            create: (_) {
              PortfolioBloc portfolioBloc = PortfolioBloc(
                botStockRepository: BotStockRepository(),
                transactionHistoryRepository: TransactionRepository(),
              );

              ///fetch portfolio when current UserJourney already passed freeBotStock
              if (UserJourney.compareUserJourney(
                  context: context, target: UserJourney.freeBotStock)) {
                portfolioBloc
                  ..add(FetchBalance())
                  ..add(const FetchActiveOrders());
              }
              return portfolioBloc;
            },
          ),
          BlocProvider(
            create: (_) => ForYouBloc(forYouRepository: ForYouRepository())
              ..add(GetInvestmentStyleState()),
          ),
          BlocProvider(
            create: (_) {
              BotStockBloc botStockBloc = BotStockBloc(
                botStockRepository: BotStockRepository(),
                transactionRepository: TransactionRepository(),
              );
              botStockBloc.add(FetchBotRecommendation());
              return botStockBloc;
            },
          ),
          BlocProvider(
            create: (_) => ForYouQuestionBloc(
                ppiQuestionRepository: PpiQuestionRepository(),
                sharedPreference: SharedPreference())
              ..add(LoadQuestion()),
          ),
          BlocProvider(
              create: (_) => UserResponseBloc(
                  sharedPreference: SharedPreference(),
                  ppiResponseRepository: PpiResponseRepository(),
                  jsonCacheSharedPreferences: JsonCacheSharedPreferences())),
        ],
        child: BlocConsumer<AccountInformationBloc, AccountInformationState>(
            listener: (context, state) =>
                CustomLoadingOverlay(context).show(state.response.state),
            buildWhen: (previous, current) =>
                previous.response.data != current.response.data ||
                current.response.state == ResponseState.error,
            builder: (context, accountInformationState) {
              if (accountInformationState.response.data != null ||
                  accountInformationState.response.state ==
                      ResponseState.error) {
                return BlocProvider(
                  create: (_) => TabScreenBloc(
                      initialTabPage: _getTabPage(accountInformationState)),
                  child: BlocConsumer<TabScreenBloc, TabScreenState>(
                    listenWhen: tabScreenBlocListenWhen,
                    listener: tabScreenBlocListener,
                    buildWhen: (previous, current) =>
                        previous.backgroundImageType !=
                        current.backgroundImageType,
                    builder: (context, tabScreenState) => Container(
                      decoration: BoxDecoration(
                        color: tabScreenState
                            .backgroundImageType.baseBackgroundColor,
                        image: tabScreenState.backgroundImageType !=
                                BackgroundImageType.none
                            ? DecorationImage(
                                image: AssetImage(tabScreenState
                                    .backgroundImageType.imageAsset!),
                                fit: BoxFit.cover)
                            : null,
                      ),
                      child: CustomScaffold(
                        appBarBackgroundColor: tabScreenState
                            .backgroundImageType.appBarBackgroundColor,
                        backgroundColor: tabScreenState
                            .backgroundImageType.scaffoldBackgroundColor,
                        enableBackNavigation: false,
                        body: CustomLayoutWithBlurPopUp(
                          showPopUp: accountInformationState.response.state ==
                              ResponseState.error,
                          content: accountInformationState.response.data != null
                              ? ShowCaseWidget(
                                  disableBarrierInteraction: true,
                                  disableMovingAnimation: true,
                                  showCaseViewScrollPosition:
                                      ShowCaseViewScrollPosition.scrollToTop,
                                  blurValue: 2.5,
                                  builder: Builder(
                                    builder: (context) => WillPopScope(
                                      onWillPop: () async {
                                        context
                                            .read<TabScreenBloc>()
                                            .add(BackButtonClicked());
                                        return false;
                                      },
                                      child: Column(
                                        children: [
                                          TabPages(
                                              canTrade: accountInformationState
                                                  .response.data!.canTrade),
                                          Tabs(
                                              backgroundImageType:
                                                  tabScreenState
                                                      .backgroundImageType,
                                              canTrade: accountInformationState
                                                  .response.data!.canTrade)
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),

                          ///TODO : IMPLEMENT THE RIGHT COPYWRITING LATER
                          loraPopUpMessageModel: LoraPopUpMessageModel(
                              title: S.of(context).errorGettingInformationTitle,
                              subTitle: S
                                  .of(context)
                                  .errorGettingInformationPortfolioSubTitle,
                              primaryButtonLabel:
                                  S.of(context).buttonReloadPage,
                              onPrimaryButtonTap: () => context
                                  .read<AccountInformationBloc>()
                                  .add(GetAccountInformation())),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Container(color: AskLoraColors.white);
              }
            }),
      );

  TabPage _getTabPage(AccountInformationState accountInformationState) {
    if (accountInformationState.response.state == ResponseState.success) {
      if (initialTabPage == null) {
        if (accountInformationState.response.data!.canTrade) {
          return TabPage.aiLandingPage;
        } else {
          return TabPage.home;
        }
      } else {
        return initialTabPage!;
      }
    } else {
      return TabPage.none;
    }
  }

  void tabScreenBlocListener(BuildContext context, TabScreenState state) {
    if (state.tabScreenBackState == TabScreenBackState.openConfirmation) {
      CustomInAppNotification.show(context, S.of(context).pressBackAgain,
          type: PopupType.grey);
    } else if (state.tabScreenBackState == TabScreenBackState.closeApp) {
      SystemNavigator.pop();
    }
  }

  bool tabScreenBlocListenWhen(
          TabScreenState previous, TabScreenState current) =>
      previous.tabScreenBackState != current.tabScreenBackState ||
      previous.currentTabPage != current.currentTabPage;

  static void openAndRemoveAllRoute(BuildContext context,
          {TabPage? initialTabPage}) =>
      Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
          route, (Route<dynamic> route) => false,
          arguments: initialTabPage);
}
