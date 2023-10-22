import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/buttons/primary_button.dart';
import '../../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../generated/l10n.dart';
import '../../bloc/question/question_bloc.dart';
import '../ppi_result_screen.dart';

class PrivacyResultSuccessScreen extends StatelessWidget {
  const PrivacyResultSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: PpiResultScreen(
        ppiResult: PpiResult.success,
        title: S.of(context).privacySuccessScreenTitle,
        additionalMessageTextStyle:
            AskLoraTextStyles.subtitle1.copyWith(color: AskLoraColors.charcoal),
        additionalMessage: S.of(context).privacySuccessScreenDescription,
        bottomButton: PrimaryButton(
          key: const Key('next_button'),
          label: S.of(context).buttonSure,
          onTap: () {
            context
                .read<QuestionBloc>()
                .add(const CurrentPersonalisationPageIncremented());
            context
                .read<NavigationBloc<QuestionPageStep>>()
                .add(const PageChanged(QuestionPageStep.personalisation));
          },
        ),
      ),
    );
  }
}
