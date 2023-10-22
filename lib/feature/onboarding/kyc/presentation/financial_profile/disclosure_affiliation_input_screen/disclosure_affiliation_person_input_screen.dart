import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../../../generated/l10n.dart';
import '../../../bloc/disclosure_affiliation/disclosure_affiliation_bloc.dart';
import '../../../bloc/kyc_bloc.dart';
import '../../../../../../core/presentation/buttons/button_pair.dart';
import '../../../domain/upgrade_account/save_kyc_request.dart';
import 'disclosure_affiliation_base_input_screen.dart';

class DisclosureAffiliationPersonInputScreen extends StatelessWidget {
  final DisclosureAffiliationState disclosureAffiliationState;
  final double progress;

  const DisclosureAffiliationPersonInputScreen(
      {required this.disclosureAffiliationState,
      required this.progress,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => DisclosureAffiliationBaseInputScreen(
      key: const Key('disclosure_affiliation_input'),
      progress: progress,
      initialFirstNameValue:
          disclosureAffiliationState.affiliatedPersonFirstName,
      initialLastNameValue: disclosureAffiliationState.affiliatedPersonLastName,
      onFirstNameChanged: (value) => context
          .read<DisclosureAffiliationBloc>()
          .add(AffiliatePersonFirstNameChanged(value)),
      onLastNameChanged: (value) => context
          .read<DisclosureAffiliationBloc>()
          .add(AffiliatePersonLastNameChanged(value)),
      bottomButton: _bottomButton);

  Widget get _bottomButton => BlocBuilder<DisclosureAffiliationBloc,
          DisclosureAffiliationState>(
      buildWhen: (previous, current) =>
          previous.affiliatedPersonFirstName !=
              current.affiliatedPersonFirstName ||
          previous.affiliatedPersonLastName != current.affiliatedPersonLastName,
      builder: (context, state) => ButtonPair(
            disablePrimaryButton: state.affiliatedPersonFirstName.isEmpty ||
                state.affiliatedPersonLastName.isEmpty,
            primaryButtonOnClick: () => context
                .read<NavigationBloc<KycPageStep>>()
                .add(const PageChanged(KycPageStep.financialProfileSummary)),
            secondaryButtonOnClick: () => context
                .read<KycBloc>()
                .add(SaveKyc(SaveKycRequest.getRequestForSavingKyc(context))),
            primaryButtonLabel: S.of(context).buttonNext,
            secondaryButtonLabel: S.of(context).saveForLater,
          ));
}
