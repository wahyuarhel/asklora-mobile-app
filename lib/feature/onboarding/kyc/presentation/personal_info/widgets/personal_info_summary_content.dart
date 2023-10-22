import 'package:flutter/material.dart';

import '../../../../../../core/presentation/custom_image_picker.dart';
import '../../../../../../core/styles/asklora_colors.dart';
import '../../../../../../generated/l10n.dart';
import '../../../bloc/address_proof/address_proof_bloc.dart';
import '../../../bloc/personal_info/personal_info_bloc.dart';
import '../../widgets/kyc_sub_title.dart';
import '../../widgets/summary_text_info.dart';

class PersonalInfoSummaryContent extends StatelessWidget {
  final String title;
  final PersonalInfoState personalInfoState;
  final AddressProofState addressProofState;

  const PersonalInfoSummaryContent(
      {Key? key,
      required this.personalInfoState,
      required this.addressProofState,
      required this.title})
      : super(key: key);

  static const double _spaceHeightDouble = 20;
  final SizedBox _spaceHeight = const SizedBox(height: _spaceHeightDouble);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KycSubTitle(
            subTitle: title,
          ),
          _spaceHeight,
          SummaryTextInfo(
              title: S.of(context).usResidentQuestion,
              subTitle: personalInfoState.isUnitedStateResident != null
                  ? personalInfoState.isUnitedStateResident!
                      ? S.of(context).yes
                      : S.of(context).no
                  : 'Unknown'),
          _spaceHeight,
          SummaryTextInfo(
              title: S.of(context).hkResidentQuestion,
              subTitle: personalInfoState.isHongKongPermanentResident != null
                  ? personalInfoState.isHongKongPermanentResident!
                      ? S.of(context).yes
                      : S.of(context).no
                  : 'Unknown'),
          _spaceHeight,
          SummaryTextInfo(
              title: S.of(context).legalFirstName,
              subTitle: personalInfoState.firstName),
          _spaceHeight,
          SummaryTextInfo(
              title: S.of(context).legalLastName,
              subTitle: personalInfoState.lastName),
          _spaceHeight,
          SummaryTextInfo(title: 'Gender', subTitle: personalInfoState.gender),
          _spaceHeight,
          SummaryTextInfo(
              title: S.of(context).hkIdNumber,
              subTitle: personalInfoState.hkIdNumber),
          _spaceHeight,
          SummaryTextInfo(
              title: S.of(context).nationality,
              subTitle: personalInfoState.nationalityName),
          _spaceHeight,
          SummaryTextInfo(
              title: S.of(context).dateOfBirth,
              subTitle: personalInfoState.dateOfBirth.replaceAll('-', '/')),
          _spaceHeight,
          SummaryTextInfo(
              title: S.of(context).countryOfBirth,
              subTitle: personalInfoState.countryNameOfBirth),
          _spaceHeight,
          SummaryTextInfo(
              title: S.of(context).hkPhoneNo,
              subTitle:
                  '+${personalInfoState.phoneCountryCode} ${personalInfoState.phoneNumber}'),
          _spaceHeight,
          SummaryTextInfo(
              title: S.of(context).addressProof,
              subTitle: addressProofState.addressLine1),
          if (addressProofState.addressLine2.isNotEmpty)
            SummaryTextInfo(
                title: null, subTitle: addressProofState.addressLine2),
          if (addressProofState.region != null)
            SummaryTextInfo(
                title: null, subTitle: addressProofState.region!.value),
          if (addressProofState.district != null)
            SummaryTextInfo(
                title: null, subTitle: addressProofState.district!.value),
          _spaceHeight,
          CustomImagePicker(
            initialValue: addressProofState.addressProofImages,
            title: S.of(context).addressProof,
            titleColor: AskLoraColors.gray,
            disabled: true,
          ),
        ],
      );
}
