import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/presentation/buttons/secondary/view_file_button.dart';
import '../../../../../core/presentation/custom_checkbox.dart';
import '../../../../../core/presentation/custom_text.dart';
import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../generated/l10n.dart';
import '../../bloc/kyc_bloc.dart';
import '../../bloc/signing_agreement/signing_agreement_bloc.dart';
import '../../domain/upgrade_account/save_kyc_request.dart';
import '../widgets/kyc_base_form.dart';
import '../../../../../core/presentation/buttons/button_pair.dart';

class BrokerAgreementScreen extends StatelessWidget {
  final double progress;

  const BrokerAgreementScreen({required this.progress, Key? key})
      : super(key: key);

  static const double _spaceHeightDouble = 20;
  final SizedBox _spaceHeight = const SizedBox(height: _spaceHeightDouble);

  @override
  Widget build(BuildContext context) {
    return KycBaseForm(
      onTapBack: () =>
          context.read<NavigationBloc<KycPageStep>>().add(const PagePop()),
      title: S.of(context).signAgreements,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextNew(
            S.of(context).pleaseReadTheAskloraCustomerAgreement,
            style:
                AskLoraTextStyles.body1.copyWith(color: AskLoraColors.charcoal),
          ),
          const SizedBox(
            height: 24,
          ),
          ViewFileButton(
              key: const Key('asklora_agreement'),
              label: S.of(context).AskloraAgreementFile,
              onTap: () => context
                  .read<SigningAgreementBloc>()
                  .add(const AskLoraClientAgreementOpened())),
          const SizedBox(
            height: 36,
          ),
          _boundByAskloraLoraAgreement,
          _spaceHeight,
          _understandOnTheAgreement,
          const SizedBox(
            height: 45,
          ),
        ],
      ),
      bottomButton: _bottomButton(context),
      progress: progress,
    );
  }

  Widget get _boundByAskloraLoraAgreement =>
      BlocBuilder<SigningAgreementBloc, SigningAgreementState>(
          buildWhen: (previous, current) =>
              previous.isAskLoraClientAgreementOpened !=
                  current.isAskLoraClientAgreementOpened ||
              previous.isBoundByAskloraAgreementChecked !=
                  current.isBoundByAskloraAgreementChecked,
          builder: (context, state) => CustomCheckbox(
                checkboxKey:
                    const Key('bound_alpaca_lora_agreement_checkbox_value'),
                key: const Key('bound_alpaca_lora_agreement_checkbox'),
                text: S.of(context).iHaveReadAndAgreed,
                disabled: !state.isAskLoraClientAgreementOpened,
                isChecked: state.isBoundByAskloraAgreementChecked,
                fontType: FontType.smallText,
                fontHeight: 1.4,
                onChanged: (value) => context
                    .read<SigningAgreementBloc>()
                    .add(BoundByAskloraAgreementChecked(value!)),
              ));

  Widget get _understandOnTheAgreement =>
      BlocBuilder<SigningAgreementBloc, SigningAgreementState>(
          buildWhen: (previous, current) =>
              previous.isBoundByAskloraAgreementChecked !=
                  current.isBoundByAskloraAgreementChecked ||
              previous.isUnderstandOnTheAgreementChecked !=
                  current.isUnderstandOnTheAgreementChecked,
          builder: (context, state) => CustomCheckbox(
                checkboxKey: const Key('understand_agreement_checkbox_value'),
                key: const Key('understand_agreement_checkbox'),
                text: S.of(context).iUnderstandSigningAgreement,
                fontHeight: 1.4,
                disabled: !state.isBoundByAskloraAgreementChecked,
                isChecked: state.isUnderstandOnTheAgreementChecked,
                fontType: FontType.smallText,
                onChanged: (value) => context
                    .read<SigningAgreementBloc>()
                    .add(UnderstandOnTheAgreementChecked(value!)),
              ));

  Widget _bottomButton(BuildContext context) =>
      BlocBuilder<SigningAgreementBloc, SigningAgreementState>(
          buildWhen: (previous, current) =>
              previous.disabledBrokerButton() != current.disabledBrokerButton(),
          builder: (context, state) => ButtonPair(
                primaryButtonOnClick: () => context
                    .read<NavigationBloc<KycPageStep>>()
                    .add(const PageChanged(
                        KycPageStep.signRiskDisclosureAgreements)),
                secondaryButtonOnClick: () => context.read<KycBloc>().add(
                    SaveKyc(SaveKycRequest.getRequestForSavingKyc(context))),
                disablePrimaryButton: state.disabledBrokerButton(),
                primaryButtonLabel: S.of(context).buttonNext,
                secondaryButtonLabel: S.of(context).saveForLater,
              ));
}
