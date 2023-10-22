import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/bloc/app_bloc.dart';
import '../../../../../core/domain/base_response.dart';
import '../../../../../core/presentation/buttons/button_pair.dart';
import '../../../../../core/presentation/buttons/primary_button.dart';
import '../../../../../core/presentation/custom_layout_with_blur_pop_up.dart';
import '../../../../../core/presentation/custom_linear_progress_indicator/custom_linear_progress_indicator.dart';
import '../../../../../core/presentation/custom_stretched_layout.dart';
import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../../../core/presentation/lora_popup_message/model/lora_pop_up_message_model.dart';
import '../../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../../core/presentation/round_colored_box.dart';
import '../../../../../core/presentation/text_fields/custom_dropdown.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../core/values/app_values.dart';
import '../../../../../generated/l10n.dart';
import '../../../../bot_stock/bloc/bot_stock_bloc.dart';
import '../../../../onboarding/ppi/bloc/response/user_response_bloc.dart';
import '../../../../onboarding/ppi/domain/question.dart';
import '../../../../onboarding/ppi/presentation/widget/omni_search_question_widget/omni_search_question_widget.dart';
import '../../../../onboarding/ppi/presentation/widget/question_title.dart';
import '../../../../onboarding/ppi/utils/ppi_utils.dart';
import '../../bloc/for_you_bloc.dart';
import '../../for_you_screen_form.dart';
import '../bloc/for_you_question_bloc.dart';

part 'widgets/for_you_omni_search_question_screen.dart';
part 'widgets/for_you_others_question_screen.dart';

class ForYouInvestmentStyleScreen extends StatelessWidget {
  const ForYouInvestmentStyleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ForYouQuestionBloc, ForYouQuestionState>(
          listenWhen: (previous, current) =>
              previous.response.state != current.response.state,
          listener: _investmentStyleQuestionListener,
        ),
        BlocListener<UserResponseBloc, UserResponseState>(
          listenWhen: (previous, current) =>
              previous.responseState != current.responseState ||
              previous.ppiResponseState != current.ppiResponseState,
          listener: _userResponseListener,
        ),
      ],
      child: BlocBuilder<ForYouQuestionBloc, ForYouQuestionState>(
        buildWhen: (previous, current) => previous.response != current.response,
        builder: (context, investmentStyleQuestionState) =>
            CustomLayoutWithBlurPopUp(
          loraPopUpMessageModel: LoraPopUpMessageModel(
            title: S.of(context).errorGettingInformationTitle,
            subTitle: S
                .of(context)
                .errorGettingInformationInvestmentStyleQuestionSubTitle,
            primaryButtonLabel: S.of(context).buttonReloadPage,
            onPrimaryButtonTap: () =>
                context.read<ForYouQuestionBloc>().add(LoadQuestion()),
          ),
          showPopUp: investmentStyleQuestionState.response.state ==
              ResponseState.error,
          content: investmentStyleQuestionState.response.state ==
                  ResponseState.success
              ? Padding(
                  padding: AppValues.screenHorizontalPadding,
                  child: BlocProvider(
                    create: (_) => NavigationBloc<InvestmentStyleQuestionType>(
                        investmentStyleQuestionState.response.data!.left != null
                            ? InvestmentStyleQuestionType.omnisearch
                            : InvestmentStyleQuestionType.others),
                    child: BlocBuilder<
                        NavigationBloc<InvestmentStyleQuestionType>,
                        NavigationState<InvestmentStyleQuestionType>>(
                      builder: (context, navigationState) {
                        return Column(
                          children: [
                            CustomLinearProgressIndicator(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 10, bottom: 10, right: 2),
                              progress: navigationState.page ==
                                      InvestmentStyleQuestionType.omnisearch
                                  ? 0.5
                                  : 1,
                            ),
                            Expanded(
                                child: _pages(navigationState.page,
                                    investmentStyleQuestionState))
                          ],
                        );
                      },
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _pages(InvestmentStyleQuestionType investmentStyleQuestionType,
      ForYouQuestionState investmentQuestionStyleState) {
    switch (investmentStyleQuestionType) {
      case InvestmentStyleQuestionType.omnisearch:
        return ForYouOmniSearchQuestionScreen(
          question: investmentQuestionStyleState.response.data!.left!,
        );
      case InvestmentStyleQuestionType.others:
        return ForYouOthersQuestionScreen(
          isFirstQuestion:
              investmentQuestionStyleState.response.data!.left == null,
          questions: investmentQuestionStyleState.response.data!.right,
        );
    }
  }

  void _investmentStyleQuestionListener(
      BuildContext context, ForYouQuestionState state) {
    CustomLoadingOverlay.of(context).show(state.response.state);
    if (state.response.state == ResponseState.success) {
      context.read<UserResponseBloc>().add(InitiateUserResponse());
    }
  }

  void _userResponseListener(BuildContext context, UserResponseState state) {
    CustomLoadingOverlay.of(context).show(state.responseState);
    if (state.ppiResponseState == PpiResponseState.dispatchResponse &&
        state.responseState == ResponseState.success) {
      context.read<ForYouBloc>().add(SaveInvestmentStyleState());
      context.read<BotStockBloc>().add(FetchBotRecommendation());
      context
          .read<NavigationBloc<ForYouPage>>()
          .add(const PageChanged(ForYouPage.botRecommendation));
    }
  }
}
