part of '../ppi_screen.dart';

class PpiProgressIndicatorWidget extends StatelessWidget {
  final QuestionPageType questionPageType;
  const PpiProgressIndicatorWidget({required this.questionPageType, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (questionPageType == QuestionPageType.personalisation) {
      return BlocBuilder<QuestionBloc, QuestionState>(
        buildWhen: (previous, current) =>
            previous.currentPersonalisationPages !=
                current.currentPersonalisationPages ||
            previous.totalPersonalisationPages !=
                current.totalPersonalisationPages,
        builder: (context, state) => CustomLinearProgressIndicator(
          padding:
              const EdgeInsets.only(right: 10, top: 10, bottom: 10, left: 2),
          progress: state.currentPersonalisationPages > 0
              ? state.currentPersonalisationPages /
                  state.totalPersonalisationPages
              : 0,
        ),
      );
    } else {
      return BlocBuilder<QuestionBloc, QuestionState>(
          buildWhen: (previous, current) =>
              previous.currentPrivacyPages != current.currentPrivacyPages ||
              previous.totalPrivacyPages != current.totalPrivacyPages ||
              previous.currentPersonalisationPages !=
                  current.currentPersonalisationPages ||
              previous.totalPersonalisationPages !=
                  current.totalPersonalisationPages,
          builder: (context, state) => Row(
                children: [
                  Expanded(
                    child: CustomLinearProgressIndicator(
                      padding: const EdgeInsets.only(
                          left: 10, top: 10, bottom: 10, right: 2),
                      progress: state.currentPrivacyPages > 0
                          ? state.currentPrivacyPages / state.totalPrivacyPages
                          : 0,
                    ),
                  ),
                  Expanded(
                    child: CustomLinearProgressIndicator(
                      padding: const EdgeInsets.only(
                          right: 10, top: 10, bottom: 10, left: 2),
                      progress: state.currentPersonalisationPages > 0
                          ? state.currentPersonalisationPages /
                              state.totalPersonalisationPages
                          : 0,
                    ),
                  ),
                ],
              ));
    }
  }
}
