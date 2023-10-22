part of '../for_you_investment_style_screen.dart';

class ForYouOmniSearchQuestionScreen extends StatelessWidget {
  final Question question;

  const ForYouOmniSearchQuestionScreen({required this.question, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OmniSearchQuestionWidget(
      key: Key(question.questionId!),
      enableBackNavigation: !UserJourney.compareUserJourney(
          context: context, target: UserJourney.freeBotStock),
      defaultOmniSearch:
          PpiDefaultAnswer.getOmniSearch(context, question.questionId!),
      question: question,
      onSubmitSuccess: () => context
          .read<NavigationBloc<InvestmentStyleQuestionType>>()
          .add(const PageChanged(InvestmentStyleQuestionType.others)),
      onCancel: () {},
    );
  }
}
