import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/base_response.dart';
import '../../../../core/domain/pair.dart';
import '../../../../core/presentation/custom_layout_with_blur_pop_up.dart';
import '../../../../core/presentation/custom_scaffold.dart';
import '../../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../../core/presentation/lora_popup_message/model/lora_pop_up_message_model.dart';
import '../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../core/presentation/custom_linear_progress_indicator/custom_linear_progress_indicator.dart';
import '../../../../core/styles/asklora_colors.dart';
import '../../../../core/utils/storage/cache/json_cache_shared_preferences.dart';
import '../../../../core/utils/storage/shared_preference.dart';
import '../../../../generated/l10n.dart';
import '../bloc/question/question_bloc.dart';
import '../bloc/response/user_response_bloc.dart';
import '../repository/ppi_question_repository.dart';
import '../repository/ppi_response_repository.dart';
import 'personalisation_question/personalisation_question_screen.dart';
import 'personalisation_question/personalisation_result_end_screen.dart';
import 'privacy_question/privacy_question_screen.dart';
import 'privacy_question/privacy_result_failed_screen.dart';
import 'privacy_question/privacy_result_success_screen.dart';

part 'widget/ppi_progress_indicator_widget.dart';

class PpiScreen extends StatelessWidget {
  static const String route = '/ppi_screen';
  final QuestionPageStep initialQuestionPage;
  final QuestionPageType questionPageType;

  const PpiScreen(
      {Key? key,
      required this.questionPageType,
      required this.initialQuestionPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => UserResponseBloc(
                sharedPreference: SharedPreference(),
                ppiResponseRepository: PpiResponseRepository(),
                jsonCacheSharedPreferences: JsonCacheSharedPreferences())),
        BlocProvider(
            create: (_) => QuestionBloc(
                  ppiQuestionRepository: PpiQuestionRepository(),
                  questionPageType: questionPageType,
                )..add(const LoadQuestions())),
        BlocProvider(
            create: (_) =>
                NavigationBloc<QuestionPageStep>(initialQuestionPage)),
      ],
      child: BlocBuilder<NavigationBloc<QuestionPageStep>,
          NavigationState<QuestionPageStep>>(
        buildWhen: (previous, current) => previous.page != current.page,
        builder: (context, state) {
          return CustomScaffold(
            appBarBackgroundColor:
                state.page == QuestionPageStep.personalisationResultEnd
                    ? AskLoraColors.charcoal
                    : AskLoraColors.white,
            backgroundColor:
                state.page == QuestionPageStep.personalisationResultEnd
                    ? AskLoraColors.charcoal
                    : AskLoraColors.white,
            enableBackNavigation: false,
            body: BlocBuilder<QuestionBloc, QuestionState>(
              buildWhen: (previous, current) =>
                  previous.response.state != current.response.state,
              builder: (context, state) => CustomLayoutWithBlurPopUp(
                loraPopUpMessageModel: LoraPopUpMessageModel(
                  title: S.of(context).errorGettingInformationTitle,
                  subTitle: S
                      .of(context)
                      .errorGettingInformationInvestmentStyleQuestionSubTitle,
                  primaryButtonLabel: S.of(context).buttonReloadPage,
                  secondaryButtonLabel: S.of(context).buttonCancel,
                  onSecondaryButtonTap: () => Navigator.pop(context),
                  onPrimaryButtonTap: () =>
                      context.read<QuestionBloc>().add(const LoadQuestions()),
                ),
                showPopUp: state.response.state == ResponseState.error,
                content: BlocConsumer<NavigationBloc<QuestionPageStep>,
                    NavigationState<QuestionPageStep>>(
                  listenWhen: (_, current) => current.lastPage == true,
                  listener: (context, state) {
                    Navigator.pop(context);
                  },
                  builder: (context, state) => Column(
                    children: [
                      if (state.page !=
                          QuestionPageStep.personalisationResultEnd)
                        PpiProgressIndicatorWidget(
                          questionPageType: questionPageType,
                        ),
                      Expanded(child: _pages(state)),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _pages(NavigationState navigationState) {
    return BlocConsumer<QuestionBloc, QuestionState>(
        listener: (context, state) {
      CustomLoadingOverlay.of(context).show(state.response.state);
    }, builder: (context, state) {
      switch (state.response.state) {
        case ResponseState.success:
          switch (navigationState.page) {
            case QuestionPageStep.privacy:
              return PrivacyQuestionScreen(
                initialIndex: state.privacyQuestionIndex,
              );
            case QuestionPageStep.privacyResultSuccess:
              return const PrivacyResultSuccessScreen();
            case QuestionPageStep.privacyResultFailed:
              return const PrivacyResultFailedScreen();
            case QuestionPageStep.personalisation:
              return PersonalisationQuestionScreen(
                initialIndex: state.personalisationQuestionIndex,
              );
            case QuestionPageStep.personalisationResultEnd:
              return const PersonalisationResultEndScreen();
            default:
              return const SizedBox.shrink();
          }
        default:
          return const SizedBox.shrink();
      }
    });
  }

  static void open(BuildContext context,
          {required Pair<QuestionPageType, QuestionPageStep> arguments}) =>
      Navigator.of(context, rootNavigator: true)
          .pushNamed(route, arguments: arguments);

  static void openReplace(BuildContext context,
          {required Pair<QuestionPageType, QuestionPageStep> arguments}) =>
      Navigator.of(context).pushReplacementNamed(route, arguments: arguments);
}
