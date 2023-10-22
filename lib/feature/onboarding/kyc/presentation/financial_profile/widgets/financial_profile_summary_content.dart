import 'package:flutter/material.dart';

import '../../../../../../core/presentation/custom_text_new.dart';
import '../../../../../../core/styles/asklora_colors.dart';
import '../../../../../../core/styles/asklora_text_styles.dart';
import '../../../../../../core/utils/feature_flags.dart';
import '../../../../../../generated/l10n.dart';
import '../../../bloc/disclosure_affiliation/disclosure_affiliation_bloc.dart';
import '../../../bloc/financial_profile/financial_profile_bloc.dart';
import '../../../bloc/source_of_wealth/source_of_wealth_bloc.dart';
import '../../../utils/kyc_dropdown_enum.dart';
import '../../widgets/kyc_sub_title.dart';
import '../../widgets/summary_text_info.dart';
import 'dot_text.dart';

class FinancialProfileSummaryContent extends StatelessWidget {
  final String title;
  final DisclosureAffiliationState disclosureAffiliationState;
  final FinancialProfileState financialProfileState;
  final SourceOfWealthState sourceOfWealthState;

  const FinancialProfileSummaryContent(
      {Key? key,
      required this.disclosureAffiliationState,
      required this.financialProfileState,
      required this.sourceOfWealthState,
      required this.title})
      : super(key: key);
  static const double _spaceHeightDouble = 20;
  final SizedBox _spaceHeight = const SizedBox(height: _spaceHeightDouble);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KycSubTitle(
          subTitle: title,
        ),
        _spaceHeight,
        SummaryTextInfo(
            titleWidget: _affiliatedQuestionWidget(context),
            subTitle: disclosureAffiliationState.isAffiliatedPerson != null
                ? disclosureAffiliationState.isAffiliatedPerson!
                    ? 'Yes'
                    : 'No'
                : 'Unknown'),

        /// TODO: Confirm with James if we want to show the source of wealth and employment or not.
        /// Disabling the source of wealth and employment as there are few demo with potential investors.
        if (!FeatureFlags.isDemoEnable)
          ..._getEmploymentDetailsAndSourceOfWealthSummary(context)
      ],
    );
  }

  List<Widget> _getEmploymentDetailsAndSourceOfWealthSummary(
          BuildContext context) =>
      [
        ..._getEmploymentDetailsContent(context),
        _spaceHeight,
        ..._sourceOfWealthSummary(context),
        _spaceHeight,
      ];

  Widget get _spaceHeightAffiliated => const SizedBox(
        height: 10,
      );

  Widget _affiliatedQuestionWidget(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextNew(
            S.of(context).doAnyOfTheFollowingApply,
            style: AskLoraTextStyles.body2.copyWith(color: AskLoraColors.gray),
          ),
          _spaceHeightAffiliated,
          _dotText(
            S.of(context).iAmASeniorExecutive,
          ),
          _spaceHeightAffiliated,
          _dotText(S.of(context).iAmASeniorPolitical),
          _spaceHeightAffiliated,
          _dotText(S.of(context).iAmAFamily),
          _spaceHeightAffiliated,
          _dotText(S.of(context).iAmADirector),
        ],
      );

  Widget _dotText(String text) => DotText(
        text,
        style: AskLoraTextStyles.body2.copyWith(color: AskLoraColors.gray),
        color: AskLoraColors.gray,
      );

  List<Widget> _getAffiliatedPerson(BuildContext context) {
    return [
      SummaryTextInfo(
          title:
              'Are your immediate family or/and you affiliated with any director, office or employee if LORA Technologies Limited ot its associates?',
          subTitle: disclosureAffiliationState.isAffiliatedAssociates != null
              ? disclosureAffiliationState.isAffiliatedAssociates!
                  ? S.of(context).yes
                  : S.of(context).no
              : S.of(context).unknown),
      if (disclosureAffiliationState.affiliatedAssociatesFirstName.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(top: _spaceHeightDouble),
          child: SummaryTextInfo(
              title: 'Name of Affiliated Person',
              subTitle:
                  '${disclosureAffiliationState.affiliatedAssociatesFirstName} ${disclosureAffiliationState.affiliatedAssociatesLastName}'),
        ),
      if (disclosureAffiliationState.affiliatedPersonFirstName.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(top: _spaceHeightDouble),
          child: SummaryTextInfo(
              title: 'Name of Affiliated Person',
              subTitle:
                  '${disclosureAffiliationState.affiliatedPersonFirstName} ${disclosureAffiliationState.affiliatedPersonLastName}'),
        ),
    ];
  }

  List<Widget> _sourceOfWealthSummary(BuildContext context) {
    return [
      CustomTextNew(
        S.of(context).sourceOfWealth,
        style: AskLoraTextStyles.body2.copyWith(color: AskLoraColors.gray),
      ),
      const SizedBox(
        height: 10,
      ),
      ...sourceOfWealthState.sourceOfWealthAnswers.map((e) {
        if (e.amount == 0) {
          return const SizedBox();
        } else {
          return CustomTextNew(
            e.sourceOfWealthType.name == 'Other'
                ? '${e.sourceOfWealthType.name} : ${e.additionalSourceOfWealth}'
                : e.sourceOfWealthType.name,
            style: AskLoraTextStyles.subtitle2
                .copyWith(color: AskLoraColors.charcoal),
          );
        }
      }).toList()
    ];
  }

  List<Widget> _getEmploymentDetailsContent(BuildContext context) {
    return [
      _spaceHeight,
      SummaryTextInfo(
          title: S.of(context).employmentStatus,
          subTitle: financialProfileState.employmentStatus.name),
      if (financialProfileState.employmentStatus == EmploymentStatus.employed ||
          financialProfileState.employmentStatus ==
              EmploymentStatus.selfEmployed)
        _summaryTextInfoWithPadding(
            title: S.of(context).natureOfBusiness,
            subTitle:
                financialProfileState.natureOfBusiness != NatureOfBusiness.other
                    ? financialProfileState.natureOfBusiness?.value ?? ''
                    : financialProfileState.natureOfBusinessDescription),
      if (financialProfileState.employmentStatus == EmploymentStatus.employed ||
          financialProfileState.employmentStatus ==
              EmploymentStatus.selfEmployed)
        _summaryTextInfoWithPadding(
            title: 'Occupation',
            subTitle: financialProfileState.occupation != Occupations.other
                ? financialProfileState.occupation?.value ?? ''
                : financialProfileState.otherOccupation),
      if (financialProfileState.employmentStatus == EmploymentStatus.employed ||
          financialProfileState.employmentStatus ==
              EmploymentStatus.selfEmployed)
        _summaryTextInfoWithPadding(
            title: 'Employer', subTitle: financialProfileState.employer),
      if (financialProfileState.employmentStatus == EmploymentStatus.employed ||
          financialProfileState.employmentStatus ==
              EmploymentStatus.selfEmployed)
        _summaryTextInfoWithPadding(
            title: 'Employer/ Company Address',
            subTitle: financialProfileState.employerAddress),
      if (financialProfileState.employmentStatus == EmploymentStatus.employed ||
          financialProfileState.employmentStatus ==
              EmploymentStatus.selfEmployed)
        _summaryTextInfoWithPadding(
            title: 'Country of Employment',
            subTitle: financialProfileState.countryName),
      if (financialProfileState.country != 'HKG')
        _summaryTextInfoWithPadding(
            title:
                'Why is your country of employment different from your country of residence?',
            subTitle: financialProfileState.detailInformationOfCountry),
    ];
  }

  Widget _summaryTextInfoWithPadding(
          {required String title, required String subTitle}) =>
      Padding(
        padding: const EdgeInsets.only(top: _spaceHeightDouble),
        child: SummaryTextInfo(title: title, subTitle: subTitle),
      );
}
