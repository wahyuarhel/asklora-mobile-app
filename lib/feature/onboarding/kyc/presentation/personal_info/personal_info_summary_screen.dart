import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../../generated/l10n.dart';
import '../../bloc/address_proof/address_proof_bloc.dart';
import '../../bloc/kyc_bloc.dart';
import '../../bloc/personal_info/personal_info_bloc.dart';
import '../../domain/upgrade_account/save_kyc_request.dart';
import '../widgets/kyc_base_form.dart';
import '../../../../../core/presentation/buttons/button_pair.dart';
import 'widgets/personal_info_summary_content.dart';

class PersonalInfoSummaryScreen extends StatelessWidget {
  final PersonalInfoState personalInfoState;
  final AddressProofState addressProofState;
  final double progress;

  const PersonalInfoSummaryScreen(
      {required this.personalInfoState,
      required this.progress,
      required this.addressProofState,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KycBaseForm(
      onTapBack: () =>
          context.read<NavigationBloc<KycPageStep>>().add(const PagePop()),
      title: S.of(context).personalInfo,
      content: PersonalInfoSummaryContent(
        key: const Key('personal_info_summary_content'),
        personalInfoState: personalInfoState,
        addressProofState: addressProofState,
        title: S.of(context).summary,
      ),
      bottomButton: _bottomButton(context),
      progress: progress,
    );
  }

  Widget _bottomButton(BuildContext context) => ButtonPair(
        primaryButtonOnClick: () => context
            .read<NavigationBloc<KycPageStep>>()
            .add(const PageChanged(KycPageStep.disclosureAffiliationPerson)),
        secondaryButtonOnClick: () => context
            .read<KycBloc>()
            .add(SaveKyc(SaveKycRequest.getRequestForSavingKyc(context))),
        primaryButtonLabel: S.of(context).confirmAndContinue,
        secondaryButtonLabel: S.of(context).saveForLater,
      );
}
