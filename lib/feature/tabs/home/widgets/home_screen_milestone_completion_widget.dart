part of '../home_screen_form.dart';

class HomeScreenMilestoneCompletionWidget extends StatelessWidget {
  const HomeScreenMilestoneCompletionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScreenHorizontalPaddingWidget(
      child: CustomTextNew(
        S.of(context).onBoardingCompletionMessage,
        style: AskLoraTextStyles.body2.copyWith(color: AskLoraColors.charcoal),
      ),
    );
  }
}
