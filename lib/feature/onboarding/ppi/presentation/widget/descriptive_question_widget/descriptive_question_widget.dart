import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/presentation/we_create/custom_centered_text_input.dart';
import '../../../bloc/response/user_response_bloc.dart';
import '../../../domain/question.dart';
import '../header.dart';
import '../question_navigation_button_widget.dart';
import '../question_title.dart';
import 'bloc/descriptive_question_widget_bloc.dart';

class DescriptiveQuestionWidget extends StatelessWidget {
  final String defaultAnswer;
  final Question question;
  final Function onSubmitSuccess;
  final Function() onCancel;
  final TextInputType textInputType;
  final List<TextInputFormatter>? textInputFormatterList;

  const DescriptiveQuestionWidget(
      {this.defaultAnswer = '',
      required this.question,
      required this.onSubmitSuccess,
      required this.onCancel,
      this.textInputType = TextInputType.text,
      this.textInputFormatterList,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          DescriptiveQuestionWidgetBloc(defaultAnswer: defaultAnswer),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionHeader(
            key: const Key('question_header'),
            onTapBack: onCancel,
          ),
          Expanded(
              child: LayoutBuilder(builder: (context, viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: viewportConstraints.maxHeight),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        QuestionTitle(
                          question: question.question!,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        BlocBuilder<DescriptiveQuestionWidgetBloc,
                            DescriptiveQuestionWidgetState>(
                          builder: (context, state) => CustomCenteredTextInput(
                              key: const Key('name_input'),
                              maxLength: 2,
                              onChanged: (value) => context
                                  .read<DescriptiveQuestionWidgetBloc>()
                                  .add(AnswerChanged(value)),
                              hintText: 'Age',
                              initialValue: state.answer,
                              textInputFormatterList: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              textInputType: TextInputType.number),
                        ),
                      ],
                    ),
                    BlocBuilder<DescriptiveQuestionWidgetBloc,
                            DescriptiveQuestionWidgetState>(
                        builder: (context, state) =>
                            QuestionNavigationButtonWidget(
                              disable: state.answer.isEmpty,
                              key: const Key(
                                  'question_navigation_button_widget'),
                              onSubmitSuccess: onSubmitSuccess,
                              onNext: () => context
                                  .read<UserResponseBloc>()
                                  .add(SaveUserResponse(
                                      question,
                                      context
                                          .read<DescriptiveQuestionWidgetBloc>()
                                          .state
                                          .answer)),
                              onCancel: onCancel,
                            ))
                  ],
                ),
              ),
            );
          })),
        ],
      ),
    );
  }
}
