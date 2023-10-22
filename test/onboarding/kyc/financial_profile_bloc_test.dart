import 'package:asklora_mobile_app/feature/onboarding/kyc/bloc/financial_profile/financial_profile_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:asklora_mobile_app/feature/onboarding/kyc/utils/kyc_dropdown_enum.dart';

void main() async {
  group('Financial Profile Bloc Tests.', () {
    late FinancialProfileBloc financialProfileBloc;

    setUp(() async {
      financialProfileBloc = FinancialProfileBloc();
    });

    test(
        'Initial state data should be empty string when the type is String and null when the type is from enum except for "employmentStatus"',
        () {
      expect(
          financialProfileBloc.state,
          const FinancialProfileState(
              employmentStatus: EmploymentStatus.unknown,
              natureOfBusiness: null,
              natureOfBusinessDescription: '',
              occupation: null,
              otherOccupation: '',
              employer: '',
              employerAddress: '',
              employerAddressTwo: '',
              district: null,
              region: null,
              country: '',
              countryName: '',
              detailInformationOfCountry: ''));
    });

    blocTest<FinancialProfileBloc, FinancialProfileState>(
        'Input field on state',
        build: () => financialProfileBloc,
        act: (bloc) => {
              bloc.add(const FinancialProfileEmploymentStatusChanged(
                  EmploymentStatus.employed)),
              bloc.add(const FinancialProfileNatureOfBusinessChanged(
                  NatureOfBusiness.architectureEngineering)),
              bloc.add(const FinancialProfileNatureOfBusinessDescriptionChanged(
                  'Creative Industry')),
              bloc.add(const FinancialProfileOccupationChanged(
                  Occupations.accountant)),
              bloc.add(const FinancialProfileOtherOccupationChanged(
                  'Content Creator')),
              bloc.add(
                  const FinancialProfileEmployerChanged('Lora Technologis')),
              bloc.add(const FinancialProfileEmployerAddressChanged(
                  '128 Wellington St, Central, Hong Kong')),
              bloc.add(const FinancialProfileEmployerAddressTwoChanged(
                  '128 Wellington St, Central, Hong Kong')),
              bloc.add(const FinancialProfileDistrictChanged(
                  District.centralAndWestern)),
              bloc.add(
                  const FinancialProfileRegionChanged(Region.hongKongIsland)),
              bloc.add(
                  const FinancialProfileCountryChanged('USA', 'United States')),
              bloc.add(const FinancialProfileDetailInformationOfCountryChanged(
                  'Because of working remotely.'))
            },
        expect: () => {
              const FinancialProfileState(
                  employmentStatus: EmploymentStatus.employed,
                  natureOfBusiness: null,
                  natureOfBusinessDescription: '',
                  occupation: null,
                  otherOccupation: '',
                  employer: '',
                  employerAddress: '',
                  employerAddressTwo: '',
                  district: null,
                  region: null,
                  country: '',
                  countryName: '',
                  detailInformationOfCountry: ''),
              const FinancialProfileState(
                  employmentStatus: EmploymentStatus.employed,
                  natureOfBusiness: NatureOfBusiness.architectureEngineering,
                  natureOfBusinessDescription: '',
                  occupation: null,
                  otherOccupation: '',
                  employer: '',
                  employerAddress: '',
                  employerAddressTwo: '',
                  district: null,
                  region: null,
                  country: '',
                  countryName: '',
                  detailInformationOfCountry: ''),
              const FinancialProfileState(
                  employmentStatus: EmploymentStatus.employed,
                  natureOfBusiness: NatureOfBusiness.architectureEngineering,
                  natureOfBusinessDescription: 'Creative Industry',
                  occupation: null,
                  otherOccupation: '',
                  employer: '',
                  employerAddress: '',
                  employerAddressTwo: '',
                  district: null,
                  region: null,
                  country: '',
                  countryName: '',
                  detailInformationOfCountry: ''),
              const FinancialProfileState(
                  employmentStatus: EmploymentStatus.employed,
                  natureOfBusiness: NatureOfBusiness.architectureEngineering,
                  natureOfBusinessDescription: 'Creative Industry',
                  occupation: Occupations.accountant,
                  otherOccupation: '',
                  employer: '',
                  employerAddress: '',
                  employerAddressTwo: '',
                  district: null,
                  region: null,
                  country: '',
                  countryName: '',
                  detailInformationOfCountry: ''),
              const FinancialProfileState(
                  employmentStatus: EmploymentStatus.employed,
                  natureOfBusiness: NatureOfBusiness.architectureEngineering,
                  natureOfBusinessDescription: 'Creative Industry',
                  occupation: Occupations.accountant,
                  otherOccupation: 'Content Creator',
                  employer: '',
                  employerAddress: '',
                  employerAddressTwo: '',
                  district: null,
                  region: null,
                  country: '',
                  countryName: '',
                  detailInformationOfCountry: ''),
              const FinancialProfileState(
                  employmentStatus: EmploymentStatus.employed,
                  natureOfBusiness: NatureOfBusiness.architectureEngineering,
                  natureOfBusinessDescription: 'Creative Industry',
                  occupation: Occupations.accountant,
                  otherOccupation: 'Content Creator',
                  employer: 'Lora Technologis',
                  employerAddress: '',
                  employerAddressTwo: '',
                  district: null,
                  region: null,
                  country: '',
                  countryName: '',
                  detailInformationOfCountry: ''),
              const FinancialProfileState(
                  employmentStatus: EmploymentStatus.employed,
                  natureOfBusiness: NatureOfBusiness.architectureEngineering,
                  natureOfBusinessDescription: 'Creative Industry',
                  occupation: Occupations.accountant,
                  otherOccupation: 'Content Creator',
                  employer: 'Lora Technologis',
                  employerAddress: '128 Wellington St, Central, Hong Kong',
                  employerAddressTwo: '',
                  district: null,
                  region: null,
                  country: '',
                  countryName: '',
                  detailInformationOfCountry: ''),
              const FinancialProfileState(
                  employmentStatus: EmploymentStatus.employed,
                  natureOfBusiness: NatureOfBusiness.architectureEngineering,
                  natureOfBusinessDescription: 'Creative Industry',
                  occupation: Occupations.accountant,
                  otherOccupation: 'Content Creator',
                  employer: 'Lora Technologis',
                  employerAddress: '128 Wellington St, Central, Hong Kong',
                  employerAddressTwo: '128 Wellington St, Central, Hong Kong',
                  district: null,
                  region: null,
                  country: '',
                  countryName: '',
                  detailInformationOfCountry: ''),
              const FinancialProfileState(
                  employmentStatus: EmploymentStatus.employed,
                  natureOfBusiness: NatureOfBusiness.architectureEngineering,
                  natureOfBusinessDescription: 'Creative Industry',
                  occupation: Occupations.accountant,
                  otherOccupation: 'Content Creator',
                  employer: 'Lora Technologis',
                  employerAddress: '128 Wellington St, Central, Hong Kong',
                  employerAddressTwo: '128 Wellington St, Central, Hong Kong',
                  district: District.centralAndWestern,
                  region: null,
                  country: '',
                  countryName: '',
                  detailInformationOfCountry: ''),
              const FinancialProfileState(
                  employmentStatus: EmploymentStatus.employed,
                  natureOfBusiness: NatureOfBusiness.architectureEngineering,
                  natureOfBusinessDescription: 'Creative Industry',
                  occupation: Occupations.accountant,
                  otherOccupation: 'Content Creator',
                  employer: 'Lora Technologis',
                  employerAddress: '128 Wellington St, Central, Hong Kong',
                  employerAddressTwo: '128 Wellington St, Central, Hong Kong',
                  district: District.centralAndWestern,
                  region: Region.hongKongIsland,
                  country: '',
                  countryName: '',
                  detailInformationOfCountry: ''),
              const FinancialProfileState(
                  employmentStatus: EmploymentStatus.employed,
                  natureOfBusiness: NatureOfBusiness.architectureEngineering,
                  natureOfBusinessDescription: 'Creative Industry',
                  occupation: Occupations.accountant,
                  otherOccupation: 'Content Creator',
                  employer: 'Lora Technologis',
                  employerAddress: '128 Wellington St, Central, Hong Kong',
                  employerAddressTwo: '128 Wellington St, Central, Hong Kong',
                  district: District.centralAndWestern,
                  region: Region.hongKongIsland,
                  country: 'USA',
                  countryName: 'United States',
                  detailInformationOfCountry: ''),
              const FinancialProfileState(
                  employmentStatus: EmploymentStatus.employed,
                  natureOfBusiness: NatureOfBusiness.architectureEngineering,
                  natureOfBusinessDescription: 'Creative Industry',
                  occupation: Occupations.accountant,
                  otherOccupation: 'Content Creator',
                  employer: 'Lora Technologis',
                  employerAddress: '128 Wellington St, Central, Hong Kong',
                  employerAddressTwo: '128 Wellington St, Central, Hong Kong',
                  district: District.centralAndWestern,
                  region: Region.hongKongIsland,
                  country: 'USA',
                  countryName: 'United States',
                  detailInformationOfCountry: 'Because of working remotely.'),
            });
    tearDown(() => {financialProfileBloc.close()});
  });
}
