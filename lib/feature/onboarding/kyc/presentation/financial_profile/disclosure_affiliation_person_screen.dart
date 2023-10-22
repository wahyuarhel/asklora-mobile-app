import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../../core/utils/feature_flags.dart';
import '../../../../../generated/l10n.dart';
import '../../bloc/disclosure_affiliation/disclosure_affiliation_bloc.dart';
import '../../bloc/kyc_bloc.dart';
import '../../domain/upgrade_account/save_kyc_request.dart';
import '../widgets/kyc_base_form.dart';
import 'widgets/choices_button.dart';
import 'widgets/dot_text.dart';
import 'widgets/financial_question.dart';

class DisclosureAffiliationPersonScreen extends StatelessWidget {
  final double progress;

  const DisclosureAffiliationPersonScreen({required this.progress, Key? key})
      : super(key: key);

  static const double _spaceHeightDouble = 20;
  final SizedBox _spaceHeight = const SizedBox(height: _spaceHeightDouble);

  @override
  Widget build(BuildContext context) {
    return KycBaseForm(
      onTapBack: () =>
          context.read<NavigationBloc<KycPageStep>>().add(const PagePop()),
      title: S.of(context).setUpFinancialProfile,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FinancialQuestion(
            S.of(context).doAnyOfTheFollowingApply,
          ),
          _spaceHeight,
          DotText(S.of(context).iAmASeniorExecutive),
          _spaceHeight,
          DotText(S.of(context).iAmASeniorPolitical),
          _spaceHeight,
          DotText(S.of(context).iAmAFamily),
          _spaceHeight,
          DotText(S.of(context).iAmADirector),
        ],
      ),
      bottomButton: BlocBuilder<DisclosureAffiliationBloc,
              DisclosureAffiliationState>(
          buildWhen: (previous, current) =>
              previous.isAffiliatedPerson != current.isAffiliatedPerson,
          builder: (context, state) => ChoicesButton(
                initialValue: state.isAffiliatedPerson != null
                    ? state.isAffiliatedPerson!
                        ? 'yes'
                        : 'no'
                    : 'unknown',
                key: const Key('choices_button'),
                onAnswerYes: () {
                  context
                      .read<DisclosureAffiliationBloc>()
                      .add(const AffiliatedPersonChanged(true));
                  context
                      .read<NavigationBloc<KycPageStep>>()
                      .add(const PageChanged(KycPageStep.disclosureRejected));
                },
                onAnswerNo: () {
                  context
                      .read<DisclosureAffiliationBloc>()
                      .add(const AffiliatedPersonChanged(false));

                  /// TODO: Confirm with James if we want to show the source of wealth and employment or not.
                  /// Disabling the source of wealth and employment as there are few demo with potential investors.
                  if (FeatureFlags.isDemoEnable) {
                    context.read<NavigationBloc<KycPageStep>>().add(
                        const PageChanged(
                            KycPageStep.disclosureAffiliationAssociates));
                  } else {
                    context.read<NavigationBloc<KycPageStep>>().add(
                        const PageChanged(
                            KycPageStep.financialProfileEmployment));
                  }
                },
                onSaveForLater: () => context.read<KycBloc>().add(
                    SaveKyc(SaveKycRequest.getRequestForSavingKyc(context))),
              )),
      progress: progress,
    );
  }
}
