part of 'financial_profile_bloc.dart';

abstract class FinancialProfileEvent extends Equatable {
  const FinancialProfileEvent();

  @override
  List<Object> get props => [];
}

class FinancialProfileAnnualHouseholdIncomeChanged
    extends FinancialProfileEvent {
  final String annualHouseholdIncome;

  const FinancialProfileAnnualHouseholdIncomeChanged(this.annualHouseholdIncome)
      : super();

  @override
  List<Object> get props => [annualHouseholdIncome];
}

class FinancialProfileEmploymentStatusChanged extends FinancialProfileEvent {
  final EmploymentStatus employmentStatus;

  const FinancialProfileEmploymentStatusChanged(this.employmentStatus)
      : super();

  @override
  List<Object> get props => [employmentStatus];
}

class FinancialProfileOccupationChanged extends FinancialProfileEvent {
  final Occupations occupation;

  const FinancialProfileOccupationChanged(this.occupation) : super();

  @override
  List<Object> get props => [occupation];
}

class FinancialProfileOtherOccupationChanged extends FinancialProfileEvent {
  final String otherOccupation;

  const FinancialProfileOtherOccupationChanged(this.otherOccupation) : super();

  @override
  List<Object> get props => [otherOccupation];
}

class FinancialProfileEmployerChanged extends FinancialProfileEvent {
  final String employer;

  const FinancialProfileEmployerChanged(this.employer) : super();

  @override
  List<Object> get props => [employer];
}

class FinancialProfileEmployerAddressChanged extends FinancialProfileEvent {
  final String employerAddress;

  const FinancialProfileEmployerAddressChanged(this.employerAddress) : super();

  @override
  List<Object> get props => [employerAddress];
}

class FinancialProfileEmployerAddressTwoChanged extends FinancialProfileEvent {
  final String employerAddressTwo;

  const FinancialProfileEmployerAddressTwoChanged(this.employerAddressTwo)
      : super();

  @override
  List<Object> get props => [employerAddressTwo];
}

class FinancialProfileNatureOfBusinessChanged extends FinancialProfileEvent {
  final NatureOfBusiness natureOfBusiness;

  const FinancialProfileNatureOfBusinessChanged(this.natureOfBusiness)
      : super();

  @override
  List<Object> get props => [natureOfBusiness];
}

class FinancialProfileNatureOfBusinessDescriptionChanged
    extends FinancialProfileEvent {
  final String natureOfBusinessDescription;

  const FinancialProfileNatureOfBusinessDescriptionChanged(
      this.natureOfBusinessDescription)
      : super();

  @override
  List<Object> get props => [natureOfBusinessDescription];
}

class FinancialProfileDistrictChanged extends FinancialProfileEvent {
  final District district;

  const FinancialProfileDistrictChanged(this.district) : super();

  @override
  List<Object> get props => [district];
}

class FinancialProfileRegionChanged extends FinancialProfileEvent {
  final Region region;

  const FinancialProfileRegionChanged(this.region) : super();

  @override
  List<Object> get props => [Region];
}

class FinancialProfileCountryChanged extends FinancialProfileEvent {
  final String country;
  final String countryName;

  const FinancialProfileCountryChanged(this.country, this.countryName)
      : super();

  @override
  List<Object> get props => [country, countryName];
}

class FinancialProfileDetailInformationOfCountryChanged
    extends FinancialProfileEvent {
  final String detailInformationOfCountry;

  const FinancialProfileDetailInformationOfCountryChanged(
      this.detailInformationOfCountry)
      : super();

  @override
  List<Object> get props => [detailInformationOfCountry];
}

class InitiateFinancialProfile extends FinancialProfileEvent {
  final EmploymentInfo? employmentInfo;

  const InitiateFinancialProfile(this.employmentInfo);

  @override
  List<Object> get props => [employmentInfo ?? ''];
}
