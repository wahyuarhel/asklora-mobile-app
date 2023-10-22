import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/presentation/buttons/secondary/secondary_multiple_choice_button.dart';
import '../../../bloc/response/user_response_bloc.dart';
import '../../../domain/question.dart';
import '../header.dart';
import '../question_navigation_button_widget.dart';
import '../question_title.dart';
import 'bloc/multiple_question_widget_bloc.dart';

class MultipleChoiceQuestionWidget extends StatelessWidget {
  final Question question;
  final int defaultChoiceIndex;
  final Function onSubmitSuccess;
  final Function() onCancel;

  const MultipleChoiceQuestionWidget(
      {required this.question,
      this.defaultChoiceIndex = 0,
      required this.onSubmitSuccess,
      required this.onCancel,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) =>
            MultipleQuestionWidgetBloc(defaultChoiceIndex: defaultChoiceIndex),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuestionHeader(
                key: const Key('question_header'), onTapBack: onCancel),
            Expanded(
                child: LayoutBuilder(builder: (context, viewportConstraints) {
              return BlocBuilder<MultipleQuestionWidgetBloc,
                      MultipleQuestionWidgetState>(
                  buildWhen: (previous, current) =>
                      previous.defaultChoiceIndex != current.defaultChoiceIndex,
                  builder: (context, state) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: viewportConstraints.maxHeight),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          key: const Key('multiple_choice_question_builder'),
                          children: [
                            Column(
                              children: [
                                QuestionTitle(
                                  question: question.question!,
                                ),
                                ...question.choices!.map((e) {
                                  int index = question.choices!.indexOf(e);
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: SecondaryMultipleChoiceButton(
                                      key: Key('${question.question}-$index}'),
                                      active: state.defaultChoiceIndex == e.id!,
                                      label: e.name!,
                                      onTap: () {
                                        context
                                            .read<MultipleQuestionWidgetBloc>()
                                            .add(AnswerChanged(e.id!));
                                      },
                                    ),
                                  );
                                }),
                              ],
                            ),
                            BlocBuilder<MultipleQuestionWidgetBloc,
                                    MultipleQuestionWidgetState>(
                                buildWhen: (previous, current) =>
                                    previous.defaultChoiceIndex !=
                                    current.defaultChoiceIndex,
                                builder: (context, state) =>
                                    QuestionNavigationButtonWidget(
                                      disable:
                                          state.defaultChoiceIndex.isNegative,
                                      key: const Key(
                                          'question_navigation_button_widget'),
                                      onSubmitSuccess: onSubmitSuccess,
                                      onNext: () => context
                                          .read<UserResponseBloc>()
                                          .add(SaveUserResponse(
                                              question,
                                              state.defaultChoiceIndex
                                                  .toString())),
                                      onCancel: onCancel,
                                    )),
                          ],
                        ),
                      ),
                    );
                  });
            })),
          ],
        ));
  }
}
