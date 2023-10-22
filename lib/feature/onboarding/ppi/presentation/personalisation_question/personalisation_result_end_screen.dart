import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/base_response.dart';
import '../../../../../core/presentation/buttons/primary_button.dart';
import '../../../../../core/presentation/loading/custom_loading_overlay.dart';
import '../../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../../generated/l10n.dart';
import '../../../../auth/sign_up/presentation/sign_up_screen.dart';
import '../../bloc/question/question_bloc.dart';
import '../../bloc/response/user_response_bloc.dart';
import '../../domain/ppi_user_response.dart';
import '../ppi_result_screen.dart';

class PersonalisationResultEndScreen extends StatelessWidget {
  const PersonalisationResultEndScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocConsumer<UserResponseBloc, UserResponseState>(
          listener: (context, state) {
        CustomLoadingOverlay.of(context).show(state.responseState);
        switch (state.responseState) {
          case ResponseState.success:
            break;
          case ResponseState.error:
            context
                .read<QuestionBloc>()
                .add(const CurrentPersonalisationPageDecremented());
            context
                .read<NavigationBloc<QuestionPageStep>>()
                .add(const PagePop());
            break;
          default:
        }
      }, builder: (context, state) {
        if (state.ppiResponseState == PpiResponseState.finishAddResponse) {
          context.read<UserResponseBloc>().add(SendBulkResponse());
        }

        if (state.responseState == ResponseState.success &&
            state.ppiResponseState == PpiResponseState.dispatchResponse) {
          final scores = state.snapShot?.data?.scores;

          return PpiResultScreen(
            isDarkBgColor: true,
            ppiResult: PpiResult.success,
            title: 'Alright!',
            additionalMessage: _getMessage(context, scores),
            bottomButton: PrimaryButton(
                buttonPrimaryType: ButtonPrimaryType.solidGreen,
                key: const Key('next_button'),
                label: S.of(context).ppiGotIt,
                onTap: () => SignUpScreen.open(context)),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }

  String _getMessage(BuildContext context, Scores? scores) {
    const high = 9;
    String message = '';
    if (scores == null) {
      return message;
    }
    String resultFromOpennessScore = scores.openness >= high
        ? S.of(context).opennessMoreThan8
        : S.of(context).opennessLessThan8;
    String resultFromNeuroticismScore = scores.neuroticism >= high
        ? S.of(context).neuroticismMoreThan8
        : S.of(context).neuroticismLessThan8;
    String resultFromExtrovertScore = scores.extrovert >= high
        ? S.of(context).extrovertMoreThan8
        : S.of(context).extrovertLessThan8;

    message = S.of(context).resultOfPersonalizationQuestion(
        resultFromOpennessScore,
        resultFromNeuroticismScore,
        resultFromExtrovertScore);
    return message;
  }
}
