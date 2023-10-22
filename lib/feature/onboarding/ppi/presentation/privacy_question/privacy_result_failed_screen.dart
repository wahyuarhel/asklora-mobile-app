import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/domain/endpoints.dart';
import '../../../../../core/domain/pair.dart';
import '../../../../../core/presentation/buttons/button_pair.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../generated/l10n.dart';
import '../../bloc/question/question_bloc.dart';
import '../ppi_result_screen.dart';
import '../ppi_screen.dart';

class PrivacyResultFailedScreen extends StatelessWidget {
  const PrivacyResultFailedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: PpiResultScreen(
        ppiResult: PpiResult.failed,
        title: S.of(context).privacyFailedScreenTitle,
        additionalMessage: S.of(context).privacyFailedScreenDescription,
        additionalMessageTextStyle: AskLoraTextStyles.subtitle1,
        bottomPadding: 0,
        bottomButton: ButtonPair(
            primaryButtonOnClick: () => PpiScreen.openReplace(context,
                arguments: const Pair(
                    QuestionPageType.privacy, QuestionPageStep.privacy)),
            secondaryButtonOnClick: () =>
                openUrl(askloraFaq, mode: LaunchMode.externalApplication),
            primaryButtonLabel: S.of(context).buttonTryAgain,
            secondaryButtonLabel: S.of(context).needHelp),
      ),
    );
  }
}
