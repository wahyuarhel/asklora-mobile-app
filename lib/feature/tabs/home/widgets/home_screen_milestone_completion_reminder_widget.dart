part of '../home_screen_form.dart';

class HomeScreenMilestoneCompletionReminderWidget extends StatelessWidget {
  const HomeScreenMilestoneCompletionReminderWidget({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScreenHorizontalPaddingWidget(
      child: CustomTextNew(
        'Complete the 3 milestones in 3 months to redeem more than HKD500 from the free Botstock!',
        style: AskLoraTextStyles.body2.copyWith(color: AskLoraColors.charcoal),
      ),
    );
  }
}
