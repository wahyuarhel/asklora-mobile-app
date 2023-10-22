part of '../multiple_choice_question_widget.dart';

class MultipleChoiceButton extends StatelessWidget {
  final int index;
  final String label;
  final bool selectable;
  final VoidCallback onTap;
  final bool active;

  const MultipleChoiceButton(
      {required this.index,
      required this.label,
      this.selectable = false,
      required this.onTap,
      this.active = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultipleQuestionWidgetBloc, MultipleQuestionWidgetState>(
        buildWhen: (previous, current) =>
            previous.defaultChoiceIndex != current.defaultChoiceIndex,
        builder: (context, state) => Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: SecondaryMultipleChoiceButton(
                  active: index == state.defaultChoiceIndex || active,
                  label: label,
                  disabled: !selectable,
                  onTap: selectable ? () => onTap() : () {}),
            ));
  }
}
