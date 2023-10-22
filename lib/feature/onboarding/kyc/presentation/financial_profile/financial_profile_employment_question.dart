import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/presentation/custom_country_picker.dart';
import '../../../../../../core/presentation/custom_text.dart';
import '../../../../../../core/presentation/text_fields/custom_dropdown.dart';
import '../../../../../../core/presentation/text_fields/master_text_field.dart';
import '../../../../../core/presentation/buttons/button_pair.dart';
import '../../../../../core/presentation/navigation/bloc/navigation_bloc.dart';
import '../../../../../generated/l10n.dart';
import '../../bloc/financial_profile/financial_profile_bloc.dart';
import '../../bloc/kyc_bloc.dart';
import '../../domain/upgrade_account/save_kyc_request.dart';
import '../../utils/kyc_dropdown_enum.dart';
import '../widgets/kyc_base_form.dart';

class FinancialProfileEmploymentQuestion extends StatelessWidget {
  final double progress;

  const FinancialProfileEmploymentQuestion({required this.progress, Key? key})
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
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            S.of(context).employment,
            fontWeight: FontWeight.bold,
            type: FontType.h2,
            margin: const EdgeInsets.only(bottom: 30, left: 0),
          ),
          _employmentStatusDropdown,
          _spaceHeight,
          _getNatureOfBusinessDropdown,
          _otherNatureOfBusinessDescriptionInput,
          _spaceHeight,
          _occupationDropdown,
          _otherOccupationInput,
          _spaceHeight,
          _employerInput,
          _spaceHeight,
          _districtDropdown,
          _spaceHeight,
          _regionDropdown,
          _spaceHeight,
          _countryDropdown,
          _spaceHeight,
          _detailInformationOfCountryInput,
        ],
      ),
      bottomButton: _bottomButton,
    );
  }

  Widget get _employmentStatusDropdown {
    return BlocBuilder<FinancialProfileBloc, FinancialProfileState>(
        buildWhen: (previous, current) =>
            previous.employmentStatus != current.employmentStatus,
        builder: (context, state) => CustomDropdown(
            key: const Key('account_employment_status_select'),
            labelText: '${S.of(context).employmentStatus}*',
            hintText: S.of(context).pleaseSelect,
            itemsList: EmploymentStatus.values
                .map((e) =>
                    EmploymentStatus.findByStringName(e.name).text(context))
                .toList()
              ..remove(EmploymentStatus.unknown.name),
            initialValue: state.employmentStatus != EmploymentStatus.unknown
                ? EmploymentStatus.findByStringName(state.employmentStatus.name)
                    .text(context)
                : '',
            onChanged: (value) => context.read<FinancialProfileBloc>().add(
                FinancialProfileEmploymentStatusChanged(
                    EmploymentStatus.values.firstWhere((element) => EmploymentStatus.findByStringName(element.name).text(context) == value)))));
  }

  Widget get _getNatureOfBusinessDropdown {
    return BlocBuilder<FinancialProfileBloc, FinancialProfileState>(
        buildWhen: (previous, current) =>
            previous.employmentStatus != current.employmentStatus ||
            previous.natureOfBusiness != current.natureOfBusiness,
        builder: (context, state) {
          if (state.employmentStatus == EmploymentStatus.employed ||
              state.employmentStatus == EmploymentStatus.selfEmployed) {
            return CustomDropdown(
                key: const Key('account_nature_of_business_select'),
                labelText: S.of(context).natureOfBusiness,
                hintText: S.of(context).pleaseSelect,
                initialValue: state.natureOfBusiness?.value ?? '',
                itemsList: NatureOfBusiness.values
                    .map((e) => NatureOfBusiness.findByStringValue(e.value)
                        .text(context))
                    .toList(),
                onChanged: (value) => context.read<FinancialProfileBloc>().add(
                    FinancialProfileNatureOfBusinessChanged(
                        NatureOfBusiness.values.firstWhere((element) =>
                            NatureOfBusiness.findByStringValue(element.value)
                                .text(context) ==
                            value))));
          } else {
            return const SizedBox.shrink();
          }
        });
  }

  Widget get _otherNatureOfBusinessDescriptionInput {
    return BlocBuilder<FinancialProfileBloc, FinancialProfileState>(
        buildWhen: ((previous, current) =>
            previous.employmentStatus != current.employmentStatus ||
            previous.natureOfBusiness != current.natureOfBusiness ||
            previous.natureOfBusinessDescription !=
                current.natureOfBusinessDescription),
        builder: (context, state) {
          if ((state.employmentStatus == EmploymentStatus.employed ||
                  state.employmentStatus == EmploymentStatus.selfEmployed) &&
              state.natureOfBusiness == NatureOfBusiness.other) {
            return Padding(
              padding: const EdgeInsets.only(top: _spaceHeightDouble),
              child: MasterTextField(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                initialValue: state.natureOfBusinessDescription,
                key: const Key('account_other_nature_of_business_desc_input'),
                onChanged: (value) => context.read<FinancialProfileBloc>().add(
                    FinancialProfileNatureOfBusinessDescriptionChanged(value)),
                hintText: S.of(context).natureOfBusinessDesc,
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }

  Widget get _occupationDropdown {
    return BlocBuilder<FinancialProfileBloc, FinancialProfileState>(
      buildWhen: (previous, current) =>
          previous.employmentStatus != current.employmentStatus ||
          previous.occupation != current.occupation,
      builder: (context, state) {
        if (state.employmentStatus == EmploymentStatus.employed ||
            state.employmentStatus == EmploymentStatus.selfEmployed) {
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
            if ((state.employmentStatus == EmploymentStatus.employed ||
                    state.employmentStatus == EmploymentStatus.selfEmployed) &&
                state.occupation == Occupations.other) {
              return Padding(
                padding: const EdgeInsets.only(top: _spaceHeightDouble),
                child: MasterTextField(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  initialValue: state.otherOccupation,
                  key: const Key('account_other_occupation_input'),
                  labelText: 'Other Occupation*',
                  onChanged: (value) => context
                      .read<FinancialProfileBloc>()
                      .add(FinancialProfileOtherOccupationChanged(value)),
                  hintText: 'Occupation',
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
          if (state.employmentStatus == EmploymentStatus.employed ||
              state.employmentStatus == EmploymentStatus.selfEmployed) {
            return Column(
              children: [
                MasterTextField(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    initialValue: state.employer,
                    key: const Key('account_employer_input'),
                    labelText: 'Employer*',
                    onChanged: (value) => context
                        .read<FinancialProfileBloc>()
                        .add(FinancialProfileEmployerChanged(value)),
                    hintText: 'Company Name'),
                _spaceHeight,
                MasterTextField(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  initialValue: state.employerAddress,
                  key: const Key('account_employer_address_input'),
                  labelText: 'Employer/Company Address*',
                  onChanged: (value) => context
                      .read<FinancialProfileBloc>()
                      .add(FinancialProfileEmployerAddressChanged(value)),
                  hintText: 'Address Line 1',
                ),
                const SizedBox(
                  height: _spaceHeightDouble,
                ),
                MasterTextField(
                  initialValue: state.employerAddress,
                  key: const Key('account_employer_address_two_input'),
                  onChanged: (value) => context
                      .read<FinancialProfileBloc>()
                      .add(FinancialProfileEmployerAddressTwoChanged(value)),
                  hintText: 'Address Line 2',
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );

  Widget get _districtDropdown {
    return BlocBuilder<FinancialProfileBloc, FinancialProfileState>(
        buildWhen: (previous, current) =>
            previous.employmentStatus != current.employmentStatus ||
            previous.district != current.district,
        builder: (context, state) {
          if (state.employmentStatus == EmploymentStatus.employed ||
              state.employmentStatus == EmploymentStatus.selfEmployed) {
            return CustomDropdown(
                key: const Key('account_district_select'),
                labelText: 'District*',
                hintText: 'Please select',
                itemsList: District.values.map((e) => e.value).toList(),
                initialValue: state.district?.value ?? '',
                onChanged: (value) => context.read<FinancialProfileBloc>().add(
                    FinancialProfileDistrictChanged(District.values
                        .firstWhere((element) => element.value == value))));
          } else {
            return const SizedBox.shrink();
          }
        });
  }

  Widget get _regionDropdown {
    return BlocBuilder<FinancialProfileBloc, FinancialProfileState>(
        buildWhen: (previous, current) =>
            previous.employmentStatus != current.employmentStatus ||
            previous.region != current.region,
        builder: (context, state) {
          if (state.employmentStatus == EmploymentStatus.employed ||
              state.employmentStatus == EmploymentStatus.selfEmployed) {
            return CustomDropdown(
                key: const Key('account_region_select'),
                labelText: 'Region*',
                hintText: 'Please select',
                itemsList: Region.values.map((e) => e.value).toList(),
                initialValue: state.region?.value ?? '',
                onChanged: (value) => context.read<FinancialProfileBloc>().add(
                    FinancialProfileRegionChanged(Region.values
                        .firstWhere((element) => element.value == value))));
          } else {
            return const SizedBox.shrink();
          }
        });
  }

  Widget get _countryDropdown => Padding(
        padding: const EdgeInsets.only(top: 0),
        child: BlocBuilder<FinancialProfileBloc, FinancialProfileState>(
            buildWhen: (previous, current) =>
                previous.employmentStatus != current.employmentStatus ||
                previous.country != current.country,
            builder: (context, state) {
              if (state.employmentStatus == EmploymentStatus.employed ||
                  state.employmentStatus == EmploymentStatus.selfEmployed) {
                return CustomCountryPicker(
                    key: const Key('account_country_select'),
                    label: 'Country*',
                    initialValue: state.countryName,
                    onSelect: (Country country) => context
                        .read<FinancialProfileBloc>()
                        .add(FinancialProfileCountryChanged(
                            country.countryCodeIso3, country.name)));
              } else {
                return const SizedBox.shrink();
              }
            }),
      );

  Widget get _detailInformationOfCountryInput {
    return BlocBuilder<FinancialProfileBloc, FinancialProfileState>(
        buildWhen: (previous, current) =>
            previous.employmentStatus != current.employmentStatus ||
            previous.country != current.country ||
            previous.detailInformationOfCountry !=
                current.detailInformationOfCountry,
        builder: (context, state) {
          if (state.country != '' &&
              state.country != 'HKG' &&
              (state.employmentStatus == EmploymentStatus.employed ||
                  state.employmentStatus == EmploymentStatus.selfEmployed)) {
            return Padding(
              padding: const EdgeInsets.only(top: 0),
              child: MasterTextField(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                initialValue: state.detailInformationOfCountry,
                key: const Key('account_detail_information_of_country_input'),
                labelText:
                    'Why is your country of employment different from your country of \n residence?*',
                onChanged: (value) => context.read<FinancialProfileBloc>().add(
                    FinancialProfileDetailInformationOfCountryChanged(value)),
                hintText:
                    'Use this space to provide more detailed \n information',
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }

  Widget get _bottomButton =>
      BlocBuilder<FinancialProfileBloc, FinancialProfileState>(
          buildWhen: (previous, current) =>
              previous.enableNextButton() != current.enableNextButton(),
          builder: (context, state) => ButtonPair(
                disablePrimaryButton: !state.enableNextButton(),
                primaryButtonOnClick: () => context
                    .read<NavigationBloc<KycPageStep>>()
                    .add(const PageChanged(
                        KycPageStep.financialProfileSourceOfWealth)),
                secondaryButtonOnClick: () => context.read<KycBloc>().add(
                    SaveKyc(SaveKycRequest.getRequestForSavingKyc(context))),
                primaryButtonLabel: S.of(context).buttonNext,
                secondaryButtonLabel: S.of(context).saveForLater,
              ));
}
