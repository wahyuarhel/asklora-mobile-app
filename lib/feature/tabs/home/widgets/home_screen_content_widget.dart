part of '../home_screen_form.dart';

class HomeScreenContentWidget extends StatelessWidget {
  final Widget _spaceHeightSmall = const SizedBox(
    height: 20,
  );

  final Widget _spaceHeightBig = const SizedBox(
    height: 50,
  );

  const HomeScreenContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) =>
          previous.userJourney != current.userJourney,
      builder: (context, state) => Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Column(
          children:
              _getContents(context: context, userJourney: state.userJourney),
        ),
      ),
    );
  }

  List<Widget> _getContents(
      {required BuildContext context, required UserJourney userJourney}) {
    switch (userJourney) {
      case UserJourney.investmentStyle:
        return [
          const HomeScreenInvestmentStyleWidget(
            showPrimaryButton: true,
          ),
          _spaceHeightSmall,
          HomeScreenPopUpMessageWidget(
            title: 'Let me Invest in you.',
            subTitle:
                'What strategy and stocks fit you? Fill in the Investment style questions and I will figure it out right away! The more I know about you, the better recommendations I can offer!',
            buttonLabel: S.of(context).defineInvestmentStyle,
            secondaryButtonLabel: S.of(context).howItWorks,
            onPrimaryButtonTap: () =>
                AiInvestmentStyleQuestionWelcomeScreen.open(context),
            backgroundColor: AskLoraColors.primaryGreen,
          ),
          _spaceHeightSmall,
          const HomeScreenNeedHelpButtonWidget(),
        ];
      case UserJourney.kyc:
        return [
          HomeScreenPopUpMessageWidget(
            title: 'Get a FREE Botstock (HKD500)!',
            subTitle:
                'Experience automated and personalised stock trading. Receive free bot stock and redeem it after completing the required milestones.',
            buttonLabel: S.of(context).openInvestmentAccount,
            secondaryButtonLabel: 'LEARN MORE',
            onSecondaryButtonTap: () {},
            onPrimaryButtonTap: () => KycScreen.open(context),
            backgroundColor: AskLoraColors.whiteSmoke,
          ),
          _spaceHeightBig,
          const HomeScreenInvestmentStyleWidget(),
          _spaceHeightSmall,
          HomeScreenPopUpMessageWidget(
            title: 'Start with your first milestone!',
            subTitle:
                'Complete your account opening and experience your first trade with an AI strategy.  ',
            buttonLabel: S.of(context).openInvestmentAccount,
            onPrimaryButtonTap: () => KycScreen.open(context),
            backgroundColor: AskLoraColors.lime,
            pngImage: 'home_dumbell',
            boxTopMargin: 105,
          ),
          _spaceHeightSmall,
          const HomeScreenNeedHelpButtonWidget(),
        ];
      case UserJourney.freeBotStock:
        return [
          HomeScreenPopUpMessageWidget(
            title: 'Get a FREE Botstock (HKD500)!',
            subTitle:
                'Experience automated and personalised stock trading. Receive free bot stock and redeem it after completing the required milestones.',
            buttonLabel: 'Get It Now',
            secondaryButtonLabel: 'Learn More',
            onSecondaryButtonTap: () {},
            onPrimaryButtonTap: () => BotStockWelcomeScreen.open(context),
            backgroundColor: AskLoraColors.whiteSmoke,
          ),
          _spaceHeightBig,
          const HomeScreenInvestmentStyleWidget(),
          _spaceHeightSmall,
          const HomeScreenNeedHelpButtonWidget(),
        ];
      case UserJourney.deposit:
        return [
          const HomeScreenMilestoneCompletionReminderWidget(),
          _spaceHeightSmall,
          const HomeScreenFreeBotStockTimerWidget(),
          _spaceHeightBig,
          const HomeScreenInvestmentStyleWidget(),
          _spaceHeightSmall,
          const HomeScreenNeedHelpButtonWidget(),
        ];
      case UserJourney.learnBotPlank:
        return [
          const HomeScreenMilestoneCompletionWidget(),
        ];
      default:
        return [
          const HomeScreenInvestmentStyleWidget(),
          _spaceHeightSmall,
          const HomeScreenFreeBotStockTimerWidget(),
          _spaceHeightSmall,
          const HomeScreenPopUpWidgetWithBotBadgeWidget(),
          _spaceHeightSmall,
          const HomeScreenNeedHelpButtonWidget(),
        ];
    }
  }
}
