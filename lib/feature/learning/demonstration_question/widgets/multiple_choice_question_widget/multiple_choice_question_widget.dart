import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import '../../../../../../../core/presentation/buttons/secondary/secondary_multiple_choice_button.dart';
import '../../../../onboarding/ppi/domain/question.dart';
import '../../../../onboarding/ppi/presentation/widget/multiple_question_widget/bloc/multiple_question_widget_bloc.dart';
import '../../../../onboarding/ppi/presentation/widget/question_title.dart';
import '../../../widgets/demonstration_tooltip_guide.dart';

part 'widgets/multiple_choice_button.dart';

class MultipleChoiceQuestionWidget extends StatelessWidget {
  final Question question;
  final bool alreadyAnswered;
  final VoidCallback? onAnswered;
  final JustTheController tooltipController;

  const MultipleChoiceQuestionWidget(
      {required this.tooltipController,
      required this.question,
      required this.alreadyAnswered,
      this.onAnswered,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MultipleQuestionWidgetBloc(defaultChoiceIndex: -1),
      child:
          BlocListener<MultipleQuestionWidgetBloc, MultipleQuestionWidgetState>(
        listenWhen: (previous, current) =>
            previous.defaultChoiceIndex != current.defaultChoiceIndex,
        listener: (context, state) {
          if (onAnswered != null) {
            onAnswered!();
          }
        },
        child: Builder(builder: (context) {
          return Column(
            children: [
              QuestionTitle(
                question: question.question!,
              ),
              ...question.choices!.map((e) {
                int index = question.choices!.indexOf(e);
                if (e.selectable != null && e.selectable!) {
                  return DemonstrationTooltipGuide(
                    tooltipController: tooltipController,
                    horizontalOffset: MediaQuery.of(context).size.width / 2,
                    text: 'Choose this!',
                    child: MultipleChoiceButton(
                      active: alreadyAnswered,
                      selectable: true,
                      label: e.name!,
                      onTap: () => context
                          .read<MultipleQuestionWidgetBloc>()
                          .add(AnswerChanged(index)),
                      index: index,
                    ),
                  );
                } else {
                  return MultipleChoiceButton(
                    index: index,
                    active: false,
                    selectable: false,
                    label: e.name!,
                    onTap: () => context
                        .read<MultipleQuestionWidgetBloc>()
                        .add(AnswerChanged(index)),
                  );
                }
              }),
            ],
          );
        }),
      ),
    );
  }
}
