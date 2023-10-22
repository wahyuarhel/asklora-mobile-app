import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/presentation/buttons/button_pair.dart';
import '../../../../../../core/presentation/custom_in_app_notification.dart';
import '../../../../../../core/presentation/custom_text_new.dart';
import '../../../../../../core/presentation/round_colored_box.dart';
import '../../../../../../core/presentation/text_fields/auto_resized_text_field.dart';
import '../../../../../../core/styles/asklora_colors.dart';
import '../../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../../generated/l10n.dart';
import '../../../bloc/response/user_response_bloc.dart';
import '../../../domain/question.dart';
import '../header.dart';
import '../question_title.dart';
import 'bloc/omni_search_question_widget_bloc.dart';
import 'domain/omni_search_model.dart';
import 'widgets/custom_choice_chips.dart';

class OmniSearchQuestionWidget extends StatelessWidget {
  final OmniSearchModel defaultOmniSearch;
  final Question question;
  final Function() onSubmitSuccess;
  final Function() onCancel;
  final TextInputType textInputType;
  final List<TextInputFormatter>? textInputFormatterList;
  final TextEditingController keywordController = TextEditingController();
  final bool enableBackNavigation;

  OmniSearchQuestionWidget(
      {required this.defaultOmniSearch,
      required this.question,
      required this.onSubmitSuccess,
      required this.onCancel,
      this.textInputType = TextInputType.text,
      this.textInputFormatterList,
      this.enableBackNavigation = true,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OmniSearchQuestionWidgetBloc(
          initialKeywordAnswers: defaultOmniSearch.keywordAnswers,
          initialKeywords: defaultOmniSearch.keywords),
      child: BlocListener<OmniSearchQuestionWidgetBloc,
          OmniSearchQuestionWidgetState>(
        listenWhen: (previous, current) =>
            previous.addKeywordError != current.addKeywordError,
        listener: (context, state) {
          if (state.addKeywordError) {
            CustomInAppNotification.show(
                context, 'Keyword already added to the list');
            keywordController.text = '';
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            enableBackNavigation
                ? QuestionHeader(
                    key: const Key('question_header'),
                    onTapBack: onCancel,
                  )
                : const SizedBox(
                    height: 20,
                  ),
            Expanded(
              child: LayoutBuilder(builder: (context, viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            QuestionTitle(
                              question: question.question!,
                              paddingBottom: 24,
                            ),
                            RoundColoredBox(
                                backgroundColor: AskLoraColors.lightGreen,
                                content: CustomTextNew(
                                  'Go search for stocks with keywords or phrases, Lora will get you the relevant stocks!',
                                  style: AskLoraTextStyles.body1,
                                )),
                            const SizedBox(
                              height: 52,
                            ),
                            _addKeywordInput,
                            const SizedBox(
                              height: 52,
                            ),
                            BlocBuilder<OmniSearchQuestionWidgetBloc,
                                    OmniSearchQuestionWidgetState>(
                                buildWhen: (previous, current) =>
                                    previous.keywords != current.keywords ||
                                    previous.keywordAnswers !=
                                        current.keywordAnswers,
                                builder: (context, state) {
                                  return SizedBox(
                                    width: double.infinity,
                                    child: Wrap(
                                        key: const Key(
                                            'omni_search_question_builder'),
                                        spacing: 12,
                                        runSpacing: 12,
                                        children: state.keywords
                                            .map((e) => CustomChoiceChips(
                                                active: state.keywordAnswers
                                                    .contains(e),
                                                enableClosedButton:
                                                    !defaultKeywords
                                                        .contains(e),
                                                label: e,
                                                onClosed: () => context
                                                    .read<
                                                        OmniSearchQuestionWidgetBloc>()
                                                    .add(KeywordRemoved(e)),
                                                onTap: () => context
                                                    .read<
                                                        OmniSearchQuestionWidgetBloc>()
                                                    .add(KeywordSelected(e))))
                                            .toList()),
                                  );
                                }),
                          ],
                        ),
                        BlocBuilder<OmniSearchQuestionWidgetBloc,
                                OmniSearchQuestionWidgetState>(
                            buildWhen: (previous, current) =>
                                previous.keywordAnswers !=
                                current.keywordAnswers,
                            builder: (context, state) => Padding(
                                  padding: const EdgeInsets.only(top: 24.0),
                                  child: ButtonPair(
                                      primaryButtonOnClick: () {
                                        onSubmitSuccess();
                                        final omniSearchState = context
                                            .read<
                                                OmniSearchQuestionWidgetBloc>()
                                            .state;
                                        context.read<UserResponseBloc>().add(
                                            SaveOmniSearchResponse(
                                                omniSearchState.keywordAnswers,
                                                omniSearchState.keywords));

                                        context.read<UserResponseBloc>().add(
                                            SaveUserResponse(
                                                question,
                                                omniSearchState.keywordAnswers
                                                    .join(',')));
                                      },
                                      secondaryButtonOnClick: () => context
                                          .read<OmniSearchQuestionWidgetBloc>()
                                          .add(KeywordReset()),
                                      disablePrimaryButton:
                                          state.keywordAnswers.isEmpty,
                                      primaryButtonLabel:
                                          S.of(context).buttonNext,
                                      secondaryButtonLabel: 'Reset'),
                                ))
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _addKeywordInput =>
      BlocConsumer<OmniSearchQuestionWidgetBloc, OmniSearchQuestionWidgetState>(
        listenWhen: (previous, current) =>
            previous.keywords != current.keywords,
        listener: (context, state) {
          keywordController.text = '';
        },
        buildWhen: (previous, current) => previous.keywords != current.keywords,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                child: AutoResizedTextField(
                  key: const Key('name_input'),
                  controller: keywordController,
                  onFieldSubmitted: (value) {
                    if (value.isNotEmpty) {
                      context
                          .read<OmniSearchQuestionWidgetBloc>()
                          .add(KeywordAdded(value));
                    }
                  },
                  hintText: 'Enter Keywords',
                  textInputType: TextInputType.text,
                  onChanged: (value) => context
                      .read<OmniSearchQuestionWidgetBloc>()
                      .add(KeywordChanged(value)),
                ),
              ),
              BlocBuilder<OmniSearchQuestionWidgetBloc,
                  OmniSearchQuestionWidgetState>(
                buildWhen: (previous, current) =>
                    previous.keyword != current.keyword,
                builder: (context, state) => Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (state.keyword.isNotEmpty) {
                            context
                                .read<OmniSearchQuestionWidgetBloc>()
                                .add(KeywordAdded(keywordController.text));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: state.keyword.isEmpty
                              ? AskLoraColors.gray
                              : AskLoraColors.charcoal,
                          foregroundColor: state.keyword.isEmpty
                              ? AskLoraColors.darkGray
                              : AskLoraColors.primaryGreen,
                          shape: const CircleBorder(),
                          fixedSize: const Size(44, 44),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 32,
                        ))),
              )
            ],
          );
        },
      );
}
