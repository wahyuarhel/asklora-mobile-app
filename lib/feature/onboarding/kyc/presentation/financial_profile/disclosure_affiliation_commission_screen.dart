import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../bloc/disclosure_affiliation/disclosure_affiliation_bloc.dart';
import '../../bloc/kyc_bloc.dart';
import '../../domain/upgrade_account/save_kyc_request.dart';
import '../widgets/kyc_base_form.dart';
import 'widgets/choices_button.dart';
import 'widgets/financial_question.dart';

class DisclosureAffiliationCommissionScreen extends StatelessWidget {
  final double progress;

  const DisclosureAffiliationCommissionScreen(
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
            'Are your immediate family or/and you a director, employee, or licensed person registered with the Hong Kong Securities and Futures Commission.',
          ),
        ],
      ),
      bottomButton: BlocBuilder<DisclosureAffiliationBloc,
              DisclosureAffiliationState>(
          buildWhen: (previous, current) =>
              previous.isAffiliatedAssociates != current.isAffiliatedAssociates,
          builder: (context, state) => ChoicesButton(
                initialValue: state.isAffiliatedCommission != null
                    ? state.isAffiliatedCommission!
                        ? 'yes'
                        : 'no'
                    : 'unknown',
                key: const Key('choices_button'),
                onAnswerYes: () {
                  context
                      .read<DisclosureAffiliationBloc>()
                      .add(const AffiliatedCommissionChanged(true));
                  context
                      .read<NavigationBloc<KycPageStep>>()
                      .add(const PageChanged(KycPageStep.disclosureRejected));
                },
                onAnswerNo: () {
                  context
                      .read<DisclosureAffiliationBloc>()
                      .add(const AffiliatedCommissionChanged(false));
                  context.read<NavigationBloc<KycPageStep>>().add(
                      const PageChanged(
                          KycPageStep.financialProfileEmployment));
                },
                onSaveForLater: () => context.read<KycBloc>().add(
                    SaveKyc(SaveKycRequest.getRequestForSavingKyc(context))),
              )),
      progress: progress,
    );
  }
}
