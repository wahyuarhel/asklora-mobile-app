import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import '../../../../../core/presentation/custom_snack_bar.dart';
import '../../../../core/presentation/custom_text_new.dart';
import '../../../../core/presentation/round_colored_box.dart';
import '../../../../core/styles/asklora_colors.dart';
import '../../../../core/styles/asklora_text_styles.dart';
import '../../../onboarding/ppi/domain/question.dart';
import '../../../onboarding/ppi/presentation/widget/omni_search_question_widget/bloc/omni_search_question_widget_bloc.dart';
import '../../../onboarding/ppi/presentation/widget/omni_search_question_widget/widgets/custom_choice_chips.dart';
import '../../../onboarding/ppi/presentation/widget/question_title.dart';
import '../../widgets/demonstration_tooltip_guide.dart';

class OmniSearchQuestionWidget extends StatelessWidget {
  final String defaultAnswer;
  final Question question;
  final TextInputType textInputType;
  final List<TextInputFormatter>? textInputFormatterList;
  final TextEditingController keywordController = TextEditingController();
  final JustTheController tooltipController;

  OmniSearchQuestionWidget(
      {required this.tooltipController,
      this.defaultAnswer = '',
      required this.question,
      this.textInputType = TextInputType.text,
      this.textInputFormatterList,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          OmniSearchQuestionWidgetBloc(initialKeywordAnswers: const []),
      child: BlocListener<OmniSearchQuestionWidgetBloc,
          OmniSearchQuestionWidgetState>(
        listenWhen: (previous, current) =>
            previous.addKeywordError != current.addKeywordError,
        listener: (context, state) {
          if (state.addKeywordError) {
            CustomSnackBar(context)
                .setMessage('Keyword already added to the list')
                .showError();
            keywordController.text = '';
          }
        },
        child: Column(
          children: [
            QuestionTitle(
              question: question.question!,
              paddingBottom: 24,
            ),
            RoundColoredBox(
                backgroundColor: AskLoraColors.lightGreen,
                content: CustomTextNew(
                  'Search for stocks with keywords or phrases, let us surprise you with the relevant stocks!',
                  style: AskLoraTextStyles.body1,
                )),
            const SizedBox(
              height: 52,
            ),
            BlocBuilder<OmniSearchQuestionWidgetBloc,
                    OmniSearchQuestionWidgetState>(
                buildWhen: (previous, current) =>
                    previous.keywords != current.keywords ||
                    previous.keywordAnswers != current.keywordAnswers,
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: DemonstrationTooltipGuide(
                      verticalOffset: 34,
                      horizontalOffset: 32,
                      text: 'Here are my keyword examples.',
                      tooltipController: tooltipController,
                      child: Wrap(
                          key: const Key('omni_search_question_builder'),
                          spacing: 12,
                          runSpacing: 12,
                          children: state.keywords
                              .map((e) => CustomChoiceChips(
                                  active: true,
                                  enableClosedButton:
                                      !defaultKeywords.contains(e),
                                  label: e,
                                  onTap: () {}))
                              .toList()),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
