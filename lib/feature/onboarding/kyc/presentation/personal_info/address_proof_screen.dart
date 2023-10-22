import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/buttons/button_pair.dart';
import '../../../../../core/presentation/custom_image_picker.dart';
import '../../../../../core/presentation/custom_in_app_notification.dart';
import '../../../../../core/presentation/custom_text_new.dart';
import '../../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../../core/presentation/text_fields/custom_dropdown.dart';
import '../../../../../core/presentation/text_fields/master_text_field.dart';
import '../../../../../core/styles/asklora_colors.dart';
import '../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../core/utils/formatters/custom_formatters.dart';
import '../../../../../generated/l10n.dart';
import '../../bloc/address_proof/address_proof_bloc.dart';
import '../../bloc/kyc_bloc.dart';
import '../../domain/upgrade_account/save_kyc_request.dart';
import '../../utils/kyc_dropdown_enum.dart';
import '../widgets/kyc_base_form.dart';

class AddressProofScreen extends StatelessWidget {
  final double progress;

  const AddressProofScreen({required this.progress, Key? key})
      : super(key: key);

  static const double _spaceHeightDouble = 36;
  final SizedBox _spaceHeight = const SizedBox(height: _spaceHeightDouble);

  @override
  Widget build(BuildContext context) {
    return KycBaseForm(
      progress: progress,
      onTapBack: () =>
          context.read<NavigationBloc<KycPageStep>>().add(const PagePop()),
      title: S.of(context).personalInfo,
      content: GestureDetector(
        onTap: () {
          FocusScopeNode focus = FocusScope.of(context);
          if (!focus.hasPrimaryFocus && focus.focusedChild != null) {
            focus.focusedChild?.unfocus();
          }
        },
        child: BlocListener<AddressProofBloc, AddressProofState>(
          listenWhen: (previous, current) =>
              previous.proofOfAddressImagesErrorText !=
              current.proofOfAddressImagesErrorText,
          listener: (context, state) {
            if (state.proofOfAddressImagesErrorText.isNotEmpty) {
              CustomInAppNotification.show(
                  context, state.proofOfAddressImagesErrorText);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextNew(
                S.of(context).pleaseProvideYourResidentialAddress,
                key: const Key('sub_title'),
                style: AskLoraTextStyles.body1
                    .copyWith(color: AskLoraColors.charcoal),
              ),
              _spaceHeight,
              _textInput(
                initialValue:
                    context.read<AddressProofBloc>().state.addressLine1,
                key: const Key('address_line_1'),
                label: 'Address Line 1*',
                onChanged: (value) => context
                    .read<AddressProofBloc>()
                    .add(AddressLine1Changed(value)),
                hintText: 'Address Line 1',
              ),
              _spaceHeight,
              _textInput(
                initialValue:
                    context.read<AddressProofBloc>().state.addressLine2,
                key: const Key('address_line_2'),
                label: 'Address Line 2',
                onChanged: (value) => context
                    .read<AddressProofBloc>()
                    .add(AddressLine2Changed(value)),
                hintText: 'Address Line 2 (optional)',
              ),
              _spaceHeight,
              _district,
              _spaceHeight,
              _region,
              _spaceHeight,
              _addressImageProof
            ],
          ),
        ),
      ),
      bottomButton: _bottomButton,
    );
  }

  Widget get _addressImageProof =>
      BlocBuilder<AddressProofBloc, AddressProofState>(
          buildWhen: (previous, current) =>
              previous.addressProofImages != current.addressProofImages,
          builder: (context, state) => CustomImagePicker(
                hintText: S.of(context).uploadAddressProof,
                key: const Key('address_proof_image_picker'),
                title: S.of(context).uploadAddressProof,
                initialValue: state.addressProofImages,
                disabledPick: state.addressProofImages.length >=
                    AddressProofState.maximumProofOfAddressImagesAllowed,
                additionalText:
                    S.of(context).yourAddressProofMustContainFullName,
                allowMultiple: false,
                onImageDeleted: (image) =>
                    context.read<AddressProofBloc>().add(ImageDeleted(image)),
                onImagePicked: (images) =>
                    context.read<AddressProofBloc>().add(ImagesChanged(images)),
              ));

  Widget get _district => BlocBuilder<AddressProofBloc, AddressProofState>(
      builder: (context, state) => CustomDropdown(
          key: const Key('district_picker'),
          labelText: 'District*',
          hintText: 'District',
          initialValue: state.district?.value ?? '',
          itemsList: District.values.map((e) => e.value).toList(),
          onChanged: (value) => context.read<AddressProofBloc>().add(
              DistrictChanged(District.values
                  .firstWhere((element) => element.value == value)))));

  Widget get _region => BlocBuilder<AddressProofBloc, AddressProofState>(
      builder: (context, state) => CustomDropdown(
          key: const Key('region_picker'),
          labelText: 'Region*',
          hintText: 'Region',
          initialValue: state.region?.value ?? '',
          itemsList: Region.values.map((e) => e.value).toList(),
          onChanged: (value) => context.read<AddressProofBloc>().add(
              RegionChanged(Region.values
                  .firstWhere((element) => element.value == value)))));

  Widget _textInput(
          {required String initialValue,
          required String label,
          required Function(String) onChanged,
          String hintText = '',
          required Key key}) =>
      MasterTextField(
        key: key,
        initialValue: initialValue,
        onChanged: onChanged,
        labelText: label,
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        textInputFormatterList: [denyEmoji()],
      );

  Widget get _bottomButton => BlocBuilder<AddressProofBloc, AddressProofState>(
      buildWhen: (previous, current) =>
          previous.enableNextButton() != current.enableNextButton(),
      builder: (context, state) => ButtonPair(
            disablePrimaryButton: !state.enableNextButton(),
            primaryButtonOnClick: () => context
                .read<NavigationBloc<KycPageStep>>()
                .add(const PageChanged(KycPageStep.personalInfoSummary)),
            secondaryButtonOnClick: () => context
                .read<KycBloc>()
                .add(SaveKyc(SaveKycRequest.getRequestForSavingKyc(context))),
            primaryButtonLabel: S.of(context).buttonNext,
            secondaryButtonLabel: S.of(context).saveForLater,
          ));
}
