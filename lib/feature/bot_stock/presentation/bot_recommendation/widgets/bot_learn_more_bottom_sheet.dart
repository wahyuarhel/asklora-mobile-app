part of '../bot_recommendation_screen.dart';

class BotLearnMoreBottomSheet extends StatelessWidget {
  const BotLearnMoreBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppValues.screenHorizontalPadding.copyWith(top: 32),
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close))),
          CustomTextNew(
            'Free AI Botstock for you to trade and learn',
            style: AskLoraTextStyles.h4.copyWith(color: AskLoraColors.charcoal),
          ),
          const SizedBox(
            height: 24,
          ),
          CustomTextNew(
            'Redeem the free Botstock by achieving the following:',
            style: AskLoraTextStyles.h6.copyWith(color: AskLoraColors.charcoal),
          ),
          const SizedBox(
            height: 18,
          ),
          _achievementCard(
              title: 'Complete 3 Milestones in 3 Months',
              subTitle:
                  'You will master how Botstock investment works and trade with 2 real Botstocks'),
          const SizedBox(
            height: 12,
          ),
          _achievementCard(
              title: 'Let your free Botstock trade for you',
              subTitle: 'Sit back and experience investing like never before'),
          const SizedBox(
            height: 12,
          ),
          _achievementCard(
              title: 'Stay on the Core Plan after 3 months',
              subTitle:
                  'It costs HKD100 per month, but your free Botstock can generate up to HKD800 for you!'),
        ],
      ),
    );
  }

  Widget _achievementCard({required String title, required String subTitle}) =>
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: AskLoraColors.lightGray,
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextNew(
              title,
              style: AskLoraTextStyles.subtitle1
                  .copyWith(color: AskLoraColors.charcoal),
            ),
            const SizedBox(
              height: 8,
            ),
            CustomTextNew(
              subTitle,
              style: AskLoraTextStyles.body2
                  .copyWith(color: AskLoraColors.charcoal),
            ),
          ],
        ),
      );
}
