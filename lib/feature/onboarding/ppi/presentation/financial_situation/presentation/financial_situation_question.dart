import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/presentation/buttons/primary_button.dart';
import '../../../../../../core/presentation/text_fields/custom_dropdown.dart';
import '../../../../../../core/presentation/text_fields/master_text_field.dart';
import '../../../../../../generated/l10n.dart';
import '../../../domain/question.dart';
import '../../widget/header.dart';
import '../../widget/question_title.dart';
import '../bloc/financial_profile_bloc.dart';

class FinancialSituationQuestion extends StatelessWidget {
  final Function() onTapNext;
  final Function() onCancel;
  final Question question;

  const FinancialSituationQuestion(
      {required this.onTapNext,
      required this.onCancel,
      required this.question,
      Key? key})
      : super(key: key);
  static const double _spaceHeightDouble = 36;
  final SizedBox _spaceHeight = const SizedBox(height: _spaceHeightDouble);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionHeader(
          key: const Key('question_header'),
          onTapBack: onCancel,
          // questionText: questionCollection.questions!.question!,
        ),
        Expanded(child: LayoutBuilder(builder: (context, viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      QuestionTitle(
                        question: question.question!,
                      ),
                      _investibleLiquidAssetsDropdown,
                      _spaceHeight,
                      _fundingSourceDropdown,
                      _spaceHeight,
                      _employmentStatusDropdown,
                      _spaceHeight,
                      _occupationDropdown,
                      _otherOccupationInput,
                      _spaceHeight,
                      _employerInput,
                    ],
                  ),
                  _nextButton(),
                ],
              ),
            ),
          );
        })),
      ],
    );
  }

  Widget get _investibleLiquidAssetsDropdown {
    return BlocBuilder<FinancialProfileBloc, FinancialProfileState>(
      buildWhen: (previous, current) =>
          previous.investibleLiquidAssets != current.investibleLiquidAssets,
      builder: (context, state) {
        return CustomDropdown(
            key: const Key('account_investible_liquid_assets_select'),
            labelText: 'Investible Liquid Assets*',
            hintText: 'Please select',
            initialValue: state.investibleLiquidAssets,
            itemsList: incomeRangeItems,
            onChanged: (value) => context
                .read<FinancialProfileBloc>()
                .add(FinancialProfileInvestibleLiquidAssetChanged(value!)));
      },
    );
  }

  Widget get _fundingSourceDropdown {
    return BlocBuilder<FinancialProfileBloc, FinancialProfileState>(
      buildWhen: (previous, current) =>
          previous.fundingSource != current.fundingSource,
      builder: (context, state) {
        return CustomDropdown(
            key: const Key('account_funding_source_select'),
            labelText: 'Account Funding Source*',
            hintText: 'Please select',
            itemsList: FundingSource.values.map((e) => e.value).toList()
              ..remove(FundingSource.unknown.value),
            initialValue: state.fundingSource != FundingSource.unknown
                ? state.fundingSource.value
                : '',
            onChanged: (value) => context.read<FinancialProfileBloc>().add(
                FinancialProfileFundingSourceChanged(FundingSource.values
                    .firstWhere((element) => element.value == value))));
      },
    );
  }

  Widget get _employmentStatusDropdown {
    return BlocBuilder<FinancialProfileBloc, FinancialProfileState>(
        buildWhen: (previous, current) =>
            previous.employmentStatus != current.employmentStatus,
        builder: (context, state) => CustomDropdown(
            key: const Key('account_employment_status_select'),
            labelText: 'Employment Status*',
            hintText: 'Please select',
            itemsList: EmploymentStatus.values.map((e) => e.value).toList()
              ..remove(EmploymentStatus.unknown.value),
            initialValue: state.employmentStatus != EmploymentStatus.unknown
                ? state.employmentStatus.value
                : '',
            onChanged: (value) => context.read<FinancialProfileBloc>().add(
                FinancialProfileEmploymentStatusChanged(EmploymentStatus.values
                    .firstWhere((element) => element.value == value)))));
  }

  Widget get _occupationDropdown {
    return BlocBuilder<FinancialProfileBloc, FinancialProfileState>(
      buildWhen: (previous, current) =>
          previous.employmentStatus != current.employmentStatus ||
          previous.occupation != current.occupation,
      builder: (context, state) {
        if (state.employmentStatus == EmploymentStatus.employed) {
          return CustomDropdown(
            key: const Key('account_occupation_select'),
            labelText: 'Occupation*',
            itemsList: Occupations.values.map((e) => e.value).toList(),
            initialValue: state.occupation?.value ?? '',
            hintText: 'Please select',
            onChanged: (value) => context.read<FinancialProfileBloc>().add(
                FinancialProfileOccupationChanged(Occupations.values
                    .firstWhere((element) => element.value == value))),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget get _otherOccupationInput =>
      BlocBuilder<FinancialProfileBloc, FinancialProfileState>(
          buildWhen: (previous, current) =>
              previous.employmentStatus != current.employmentStatus ||
              previous.occupation != current.occupation,
          builder: (context, state) {
            if (state.employmentStatus == EmploymentStatus.employed &&
                state.occupation == Occupations.other) {
              return Padding(
                padding: const EdgeInsets.only(top: _spaceHeightDouble),
                child: MasterTextField(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  initialValue: state.otherOccupation ?? '',
                  key: const Key('account_other_occupation_input'),
                  labelText: 'Other Occupation*',
                  onChanged: (value) => context
                      .read<FinancialProfileBloc>()
                      .add(FinancialProfileOtherOccupationChanged(value)),
                  hintText: 'Other Occupation*',
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          });

  Widget get _employerInput =>
      BlocBuilder<FinancialProfileBloc, FinancialProfileState>(
        buildWhen: (previous, current) =>
            previous.employmentStatus != current.employmentStatus,
        builder: (context, state) {
          if (state.employmentStatus == EmploymentStatus.employed) {
            return Column(
              children: [
                MasterTextField(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    initialValue: state.employer ?? '',
                    key: const Key('account_employer_input'),
                    labelText: 'Employer',
                    onChanged: (value) => context
                        .read<FinancialProfileBloc>()
                        .add(FinancialProfileEmployerChanged(value)),
                    hintText: 'Employer e.g. Lawyer'),
                _spaceHeight,
                MasterTextField(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  initialValue: state.employerAddress ?? '',
                  key: const Key('account_employer_address_input'),
                  labelText: 'Employer/Company Address',
                  onChanged: (value) => context
                      .read<FinancialProfileBloc>()
                      .add(FinancialProfileEmployerAddressChanged(value)),
                  hintText: 'Employer Address 1',
                ),
                const SizedBox(
                  height: 8,
                ),
                MasterTextField(
                  initialValue: state.employerAddress ?? '',
                  key: const Key('account_employer_address_two_input'),
                  labelText: 'Employer Address 2',
                  onChanged: (value) => context
                      .read<FinancialProfileBloc>()
                      .add(FinancialProfileEmployerAddressTwoChanged(value)),
                  hintText: 'Employer Address 2',
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );

  Widget _nextButton() {
    return BlocBuilder<FinancialProfileBloc, FinancialProfileState>(
        buildWhen: (previous, current) =>
            previous.enableNextButton() != current.enableNextButton(),
        builder: (context, state) => Padding(
              padding: const EdgeInsets.only(bottom: 35.0, top: 52),
              child: PrimaryButton(
                label: S.of(context).buttonNext,
                buttonPrimaryType: ButtonPrimaryType.solidCharcoal,
                key: const Key('question_next_button'),
                disabled: !state.enableNextButton(),
                onTap: onTapNext,
              ),
            ));
  }
}
