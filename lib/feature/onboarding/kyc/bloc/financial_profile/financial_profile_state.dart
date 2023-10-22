part of 'financial_profile_bloc.dart';

class FinancialProfileState extends Equatable {
  final EmploymentStatus employmentStatus;
  final NatureOfBusiness? natureOfBusiness;
  final String natureOfBusinessDescription;
  final Occupations? occupation;
  final String otherOccupation;
  final String employer;
  final String employerAddress;
  final String employerAddressTwo;
  final District? district;
  final Region? region;
  final String country;
  final String countryName;
  final String detailInformationOfCountry;

  const FinancialProfileState(
      {this.employmentStatus = EmploymentStatus.unknown,
      this.natureOfBusiness,
      this.natureOfBusinessDescription = '',
      this.occupation,
      this.otherOccupation = '',
      this.employer = '',
      this.employerAddress = '',
      this.employerAddressTwo = '',
      this.district,
      this.region,
      this.country = '',
      this.countryName = '',
      this.detailInformationOfCountry = ''});

  FinancialProfileState copyWith({
    String? annualHouseholdIncome,
    String? investibleLiquidAssets,
    FundingSource? fundingSource,
    EmploymentStatus? employmentStatus,
    NatureOfBusiness? natureOfBusiness,
    String? natureOfBusinessDescription,
    Occupations? occupation,
    String? otherOccupation,
    String? employer,
    String? employerAddress,
    String? employerAddressTwo,
    District? district,
    Region? region,
    String? country,
    String? countryName,
    String? detailInformationOfCountry,
  }) {
    return FinancialProfileState(
        employmentStatus: employmentStatus ?? this.employmentStatus,
        natureOfBusiness: natureOfBusiness ?? this.natureOfBusiness,
        natureOfBusinessDescription:
            natureOfBusinessDescription ?? this.natureOfBusinessDescription,
        occupation: occupation ?? this.occupation,
        otherOccupation: otherOccupation ?? this.otherOccupation,
        employer: employer ?? this.employer,
        employerAddress: employerAddress ?? this.employerAddress,
        employerAddressTwo: employerAddressTwo ?? this.employerAddressTwo,
        district: district ?? this.district,
        region: region ?? this.region,
        country: country ?? this.country,
        countryName: countryName ?? this.countryName,
        detailInformationOfCountry:
            detailInformationOfCountry ?? this.detailInformationOfCountry);
  }

  @override
  List<Object> get props {
    return [
      employmentStatus,
      natureOfBusiness ?? '',
      natureOfBusinessDescription,
      occupation ?? '',
      otherOccupation,
      employer,
      employerAddress,
      employerAddressTwo,
      district ?? '',
      region ?? '',
      country,
      countryName,
      detailInformationOfCountry
    ];
  }

  bool enableNextButton() {
    if (employmentStatus != EmploymentStatus.unknown &&
        employmentStatus != EmploymentStatus.employed &&
        employmentStatus != EmploymentStatus.selfEmployed) {
      return true;
    } else {
      if (natureOfBusiness != null &&
          natureOfBusiness != NatureOfBusiness.other &&
          occupation != null &&
          occupation != Occupations.other &&
          employer.isNotEmpty &&
          employerAddress.isNotEmpty &&
          district != null &&
          region != null &&
          country.isNotEmpty &&
          country == 'HKG') {
        return true;
      } else {
        if ((natureOfBusiness == NatureOfBusiness.other &&
                natureOfBusinessDescription.isEmpty) ||
            (occupation == Occupations.other && otherOccupation.isEmpty) ||
            (country != 'HKG' && detailInformationOfCountry.isEmpty)) {
          return false;
        } else {
          if (employer.isEmpty || employerAddress.isEmpty || district == null) {
            return false;
          }
          return true;
        }
      }
    }
  }
}
