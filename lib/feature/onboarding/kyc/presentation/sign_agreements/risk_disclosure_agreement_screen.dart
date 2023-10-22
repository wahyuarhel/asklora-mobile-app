import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/buttons/button_pair.dart';
import '../../../../../core/presentation/custom_checkbox.dart';
import '../../../../../core/presentation/custom_text.dart';
import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../../core/presentation/round_colored_box.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../generated/l10n.dart';
import '../../bloc/kyc_bloc.dart';
import '../../bloc/signing_agreement/signing_agreement_bloc.dart';
import '../../domain/upgrade_account/save_kyc_request.dart';
import '../widgets/kyc_base_form.dart';
import '../widgets/kyc_sub_title.dart';

class RiskDisclosureAgreementScreen extends StatelessWidget {
  final double progress;

  const RiskDisclosureAgreementScreen({required this.progress, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KycBaseForm(
      onTapBack: () =>
          context.read<NavigationBloc<KycPageStep>>().add(const PagePop()),
      title: S.of(context).signAgreements,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _licenseeProfile(context),
          const SizedBox(
            height: 42,
          ),
          KycSubTitle(
            key: const Key('sub_title'),
            subTitle: S.of(context).riskDisclosureStatementLabel,
          ),
          const SizedBox(
            height: 24,
          ),
          CustomTextNew(
            S.of(context).riskDisclosureStatementString,
            key: const Key('statements'),
            style:
                AskLoraTextStyles.body1.copyWith(color: AskLoraColors.charcoal),
          ),
          const SizedBox(
            height: 46,
          ),
          _riskDisclosureAgreement,
          const SizedBox(
            height: 14,
          ),
        ],
      ),
      bottomButton: _bottomButton(context),
      progress: progress,
    );
  }

  Widget _licenseeProfile(BuildContext context) => RoundColoredBox(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        key: const Key('licensee_profile'),
        content: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 24),
              child: getPngImage('joseph_chang', height: 60, width: 60),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    S.of(context).licenseeName,
                    type: FontType.smallTextBold,
                    padding: const EdgeInsets.only(bottom: 8),
                  ),
                  CustomText(
                    S.of(context).licenseeNumber,
                    type: FontType.note,
                  ),
                ],
              ),
            )
          ],
        ),
      );

  Widget get _riskDisclosureAgreement =>
      BlocBuilder<SigningAgreementBloc, SigningAgreementState>(
          buildWhen: (previous, current) =>
              previous.isRiskDisclosureAgreementChecked !=
              current.isRiskDisclosureAgreementChecked,
          builder: (context, state) => CustomCheckbox(
                checkboxKey:
                    const Key('signing_risk_disclosure_agreement_value'),
                key: const Key('signing_risk_disclosure_agreement'),
                text: S.of(context).riskDisclosureStatementAcknowledgement,
                fontHeight: 1.4,
                isChecked: state.isRiskDisclosureAgreementChecked,
                fontType: FontType.smallText,
                onChanged: (value) => context
                    .read<SigningAgreementBloc>()
                    .add(RiskDisclosureAgreementChecked(value!)),
              ));

  Widget _bottomButton(BuildContext context) =>
      BlocBuilder<SigningAgreementBloc, SigningAgreementState>(
          buildWhen: (previous, current) =>
              previous.isRiskDisclosureAgreementChecked !=
              current.isRiskDisclosureAgreementChecked,
          builder: (context, state) => ButtonPair(
                primaryButtonOnClick: () => context
                    .read<NavigationBloc<KycPageStep>>()
                    .add(const PageChanged(KycPageStep.signTaxAgreements)),
                secondaryButtonOnClick: () => context.read<KycBloc>().add(
                    SaveKyc(SaveKycRequest.getRequestForSavingKyc(context))),
                disablePrimaryButton: !state.isRiskDisclosureAgreementChecked,
                primaryButtonLabel: S.of(context).buttonNext,
                secondaryButtonLabel: S.of(context).saveForLater,
              ));
}
