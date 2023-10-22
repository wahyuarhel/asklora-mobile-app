import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/buttons/button_pair.dart';
import '../../../../../core/presentation/buttons/secondary/view_file_button.dart';
import '../../../../../core/presentation/custom_checkbox.dart';
import '../../../../../core/presentation/custom_text.dart';
import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../../core/presentation/text_fields/master_text_field.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../generated/l10n.dart';
import '../../bloc/kyc_bloc.dart';
import '../../bloc/personal_info/personal_info_bloc.dart';
import '../../bloc/signing_agreement/signing_agreement_bloc.dart';
import '../../domain/upgrade_account/save_kyc_request.dart';
import '../financial_profile/widgets/dot_text.dart';
import '../widgets/kyc_base_form.dart';
import '../widgets/kyc_sub_title.dart';

class TaxAgreementScreen extends StatelessWidget {
  final double progress;
  final PersonalInfoBloc personalInfoBloc;

  const TaxAgreementScreen(
      {required this.progress, required this.personalInfoBloc, Key? key})
      : super(key: key);

  final Widget _spaceHeight = const SizedBox(
    height: 8,
  );

  @override
  Widget build(BuildContext context) {
    return KycBaseForm(
      onTapBack: () =>
          context.read<NavigationBloc<KycPageStep>>().add(const PagePop()),
      title: S.of(context).signAgreements,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KycSubTitle(
            key: const Key('sub_title'),
            subTitle: S.of(context).formW8ben,
          ),
          const SizedBox(
            height: 24,
          ),
          ViewFileButton(
              key: const Key('w8_ben_form'),
              label: S.of(context).w8benForm,
              onTap: () => context
                  .read<SigningAgreementBloc>()
                  .add(const W8BenFormOpened())),
          const SizedBox(
            height: 24,
          ),
          CustomTextNew(
            S.of(context).taxAgreementDesc1,
            key: const Key('statements'),
            style:
                AskLoraTextStyles.body1.copyWith(color: AskLoraColors.charcoal),
          ),
          _spaceHeight,
          DotText(S.of(context).taxAgreementDescPoint1),
          _spaceHeight,
          DotText(S.of(context).taxAgreementDescPoint2),
          _spaceHeight,
          DotText(S.of(context).taxAgreementDescPoint3),
          _spaceHeight,
          _dotTextSlightRight(S.of(context).taxAgreementDescPoint3SubPoint1),
          _spaceHeight,
          _dotTextSlightRight(S.of(context).taxAgreementDescPoint3SubPoint2),
          _spaceHeight,
          _dotTextSlightRight(S.of(context).taxAgreementDescPoint3SubPoint3),
          _spaceHeight,
          _dotTextSlightRight(S.of(context).taxAgreementDescPoint3SubPoint4),
          _spaceHeight,
          DotText(S.of(context).taxAgreementDescPoint4),
          _spaceHeight,
          DotText(S.of(context).taxAgreementDescPoint5),
          _spaceHeight,
          CustomTextNew(
            S.of(context).taxAgreementDesc2,
            style:
                AskLoraTextStyles.body1.copyWith(color: AskLoraColors.charcoal),
          ),
          const SizedBox(
            height: 46,
          ),
          CustomTextNew(
            S.of(context).taxAgreementDesc3,
            style:
                AskLoraTextStyles.body1.copyWith(color: AskLoraColors.charcoal),
          ),
          const SizedBox(
            height: 20,
          ),
          _signatureCheck,
          const SizedBox(
            height: 46,
          ),
          _signatureSection(context),
          _legalNameInput
        ],
      ),
      bottomButton: _bottomButton(context),
      progress: progress,
    );
  }

  Widget get _signatureCheck =>
      BlocBuilder<SigningAgreementBloc, SigningAgreementState>(
          buildWhen: (previous, current) =>
              previous.isSignatureChecked != current.isSignatureChecked,
          builder: (context, state) => CustomCheckbox(
                checkboxKey: const Key('signature_check_value'),
                key: const Key('signature_check'),
                text: S.of(context).taxAgreementCheckboxDesc,
                fontHeight: 1.4,
                isChecked: state.isSignatureChecked,
                fontType: FontType.smallText,
                onChanged: (value) => context
                    .read<SigningAgreementBloc>()
                    .add(SignatureChecked(value!)),
              ));

  Widget _signatureSection(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 28,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextNew(S.of(context).taxAgreementSignatureTitle,
                style: AskLoraTextStyles.h5
                    .copyWith(color: AskLoraColors.charcoal)),
            const SizedBox(
              height: 8,
            ),
            CustomTextNew(
              S.of(context).taxAgreementSignatureDesc,
              style: AskLoraTextStyles.body2
                  .copyWith(color: AskLoraColors.charcoal),
            ),
            _spaceHeight,
            CustomTextNew(
              S.of(context).taxAgreementSignatureDescPoint1,
              style: AskLoraTextStyles.body2
                  .copyWith(color: AskLoraColors.charcoal),
            ),
            _spaceHeight,
            CustomTextNew(
              S.of(context).taxAgreementSignatureDescPoint2,
              style: AskLoraTextStyles.body2
                  .copyWith(color: AskLoraColors.charcoal),
            ),
            _spaceHeight,
            CustomTextNew(
              S.of(context).taxAgreementSignatureDescPoint3,
              style: AskLoraTextStyles.body2
                  .copyWith(color: AskLoraColors.charcoal),
            ),
            _spaceHeight,
            CustomTextNew(
              S.of(context).taxAgreementSignatureDescPoint4,
              style: AskLoraTextStyles.body2
                  .copyWith(color: AskLoraColors.charcoal),
            ),
            const SizedBox(
              height: 46,
            ),
            CustomTextNew(
              S.of(context).signInElectronically,
              style: AskLoraTextStyles.body2.copyWith(
                color: AskLoraColors.charcoal,
              ),
            ),
            _acceptedSignatureNameHint,
          ],
        ),
      );

  Widget get _acceptedSignatureNameHint =>
      BlocBuilder<SigningAgreementBloc, SigningAgreementState>(
          buildWhen: (previous, current) =>
              previous.legalName != current.legalName,
          builder: (context, state) {
            return RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: S.of(context).acceptedSignature,
                  style: AskLoraTextStyles.body2
                      .copyWith(color: AskLoraColors.charcoal)),
              TextSpan(
                  text:
                      '${personalInfoBloc.state.firstName} ${personalInfoBloc.state.lastName}',
                  style: AskLoraTextStyles.body2.copyWith(
                      color: AskLoraColors.charcoal,
                      fontWeight: FontWeight.bold)),
            ]));
          });

  Widget get _legalNameInput =>
      BlocBuilder<SigningAgreementBloc, SigningAgreementState>(
          buildWhen: (previous, current) =>
              previous.legalName != current.legalName,
          builder: (context, state) => Padding(
                padding: const EdgeInsets.only(top: 46),
                child: MasterTextField(
                  initialValue: state.legalName,
                  key: const Key('legal_name_input'),
                  onChanged: (value) => context
                      .read<SigningAgreementBloc>()
                      .add(LegalNameSignatureChanged(value)),
                  errorText: state.legalNameErrorText,
                ),
              ));

  Widget _dotTextSlightRight(String text) => Padding(
        padding: const EdgeInsets.only(left: 28.0),
        child: DotText(
          text,
        ),
      );

  Widget _bottomButton(BuildContext context) =>
      BlocBuilder<SigningAgreementBloc, SigningAgreementState>(
        buildWhen: (previous, current) =>
            previous.isSignatureChecked != current.isSignatureChecked ||
            previous.isInputNameValid != current.isInputNameValid,
        builder: (context, state) {
          return ButtonPair(
            primaryButtonOnClick: () => context
                .read<NavigationBloc<KycPageStep>>()
                .add(const PageChanged(KycPageStep.kycSummary)),
            disablePrimaryButton: state.disableAgreeButton(),
            secondaryButtonOnClick: () => context
                .read<KycBloc>()
                .add(SaveKyc(SaveKycRequest.getRequestForSavingKyc(context))),
            primaryButtonLabel: S.of(context).agree,
            secondaryButtonLabel: S.of(context).saveForLater,
          );
        },
      );
}
