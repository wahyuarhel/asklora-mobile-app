part of '../welcome_screen.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<NavigationBloc<WelcomePages>>().add(const PagePop());
        return false;
      },
      child: CustomStretchedLayout(
        contentPadding: AppValues.screenHorizontalPadding.copyWith(top: 10),
        padding: EdgeInsets.zero,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LocalizationToggleButton(),
            const SizedBox(
              height: 30,
            ),
            CustomTextNew(
              S.of(context).welcomeScreenTitle,
              style: AskLoraTextStyles.h2,
            ),
            const SizedBox(
              height: 25,
            ),
            CustomTextNew(
              S.of(context).welcomeScreenSubTitle,
              style: AskLoraTextStyles.subtitle2,
            ),
            const SizedBox(
              height: 43,
            ),
            _welcomeCard('welcome_screen_whistle',
                S.of(context).welcomeScreenFirstBenefit),
            const SizedBox(
              height: 28,
            ),
            _welcomeCard('welcome_screen_setting',
                S.of(context).welcomeScreenSecondBenefit),
            const SizedBox(
              height: 28,
            ),
            _welcomeCard('welcome_screen_chess',
                S.of(context).welcomeScreenThirdBenefit),
            const SizedBox(
              height: 45,
            ),
          ],
        ),
        bottomButton: Padding(
          padding: AppValues.screenHorizontalPadding,
          child: ButtonPair(
              key: const Key('button_pair'),
              primaryButtonOnClick: () => AskNameScreen.open(context),
              secondaryButtonOnClick: () => SignInScreen.open(context),
              primaryButtonLabel: S.of(context).buttonLetsBegin,
              secondaryButtonLabel: S.of(context).buttonHaveAnAccount),
        ),
      ),
    );
  }

  Widget _welcomeCard(String iconAssetName, String text) => RoundColoredBox(
        backgroundColor: AskLoraColors.extraLightGray,
        boxShadow: BoxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: const Offset(0, 4),
          blurRadius: 4,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 21),
        content: Row(
          children: [
            getPngImage(iconAssetName),
            const SizedBox(
              width: 22,
            ),
            Expanded(
              child: CustomTextNew(
                text,
                style: AskLoraTextStyles.h5,
              ),
            )
          ],
        ),
      );
}
