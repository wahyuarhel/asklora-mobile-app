import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../bloc/disclosure_affiliation/disclosure_affiliation_bloc.dart';
import '../../bloc/kyc_bloc.dart';
import '../../domain/upgrade_account/save_kyc_request.dart';
import '../widgets/kyc_base_form.dart';
import 'widgets/choices_button.dart';
import 'widgets/financial_question.dart';

class DisclosureAffiliationAssociatesScreen extends StatelessWidget {
  final double progress;

  const DisclosureAffiliationAssociatesScreen(
      {required this.progress, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KycBaseForm(
      onTapBack: () =>
          context.read<NavigationBloc<KycPageStep>>().add(const PagePop()),
      title: 'Set Up Financial Profile',
      content: const Column(
        children: [
          FinancialQuestion(
            'Are you and/or your immediate family affiliated with any director, shareholder,  or employee of LORA Advisors Limited or its associates?',
          ),
        ],
      ),
      bottomButton: BlocBuilder<DisclosureAffiliationBloc,
              DisclosureAffiliationState>(
          buildWhen: (previous, current) =>
              previous.isAffiliatedAssociates != current.isAffiliatedAssociates,
          builder: (context, state) => ChoicesButton(
                initialValue: state.isAffiliatedAssociates != null
                    ? state.isAffiliatedAssociates!
                        ? 'yes'
                        : 'no'
                    : 'unknown',
                key: const Key('choices_button'),
                onAnswerYes: () {
                  context
                      .read<DisclosureAffiliationBloc>()
                      .add(const AffiliatedAssociatesChanged(true));
                  context.read<NavigationBloc<KycPageStep>>().add(
                      const PageChanged(
                          KycPageStep.disclosureAffiliationPersonInput));
                },
                onAnswerNo: () {
                  context
                      .read<DisclosureAffiliationBloc>()
                      .add(const AffiliatedAssociatesChanged(false));
                  context
                      .read<DisclosureAffiliationBloc>()
                      .add(const AffiliateAssociatesReset());
                  context.read<NavigationBloc<KycPageStep>>().add(
                      const PageChanged(KycPageStep.financialProfileSummary));
                },
                onSaveForLater: () => context.read<KycBloc>().add(
                    SaveKyc(SaveKycRequest.getRequestForSavingKyc(context))),
              )),
      progress: progress,
    );
  }
}
