part of 'financial_profile_bloc.dart';

const incomeRangeItems = [
  '0 - 200,000',
  '200,001 - 400,000',
  '400,001 - 600,000',
  '600,000 - 800,000',
  '800,001 - 1,000,000+',
];

enum Occupations {
  healthCare('Healthcare'),
  education('Education'),
  legal('Legal'),
  business('Business'),
  finance('Finance'),
  it('IT'),
  other('Other');

  final String value;

  const Occupations(this.value);
}

enum FundingSource {
  employmentIncome('Employment Income'),
  investments('Investments'),
  inheritance('Inheritance'),
  businessIncome('Business Income'),
  savings('Savings'),
  family('Family'),
  unknown('Unknown');

  final String value;

  const FundingSource(this.value);
}

enum EmploymentStatus {
  unemployed('Unemployed'),
  employed('Employed'),
  student('Student'),
  retired('Retired'),
  unknown('Unknown');

  final String value;

  const EmploymentStatus(this.value);
}

class FinancialProfileState extends Equatable {
  final String annualHouseholdIncome;
  final String investibleLiquidAssets;
  final FundingSource fundingSource;
  final EmploymentStatus employmentStatus;
  final Occupations? occupation;
  final String? otherOccupation;
  final String? employer;
  final String? employerAddress;
  final String? employerAddressTwo;

  const FinancialProfileState({
    this.annualHouseholdIncome = '',
    this.investibleLiquidAssets = '',
    this.fundingSource = FundingSource.unknown,
    this.employmentStatus = EmploymentStatus.unknown,
    this.occupation,
    this.otherOccupation = '',
    this.employer = '',
    this.employerAddress = '',
    this.employerAddressTwo = '',
  });

  FinancialProfileState copyWith({
    String? annualHouseholdIncome,
    String? investibleLiquidAssets,
    FundingSource? fundingSource,
    EmploymentStatus? employmentStatus,
    Occupations? occupation,
    String? otherOccupation,
    String? employer,
    String? employerAddress,
    String? employerAddressTwo,
  }) {
    return FinancialProfileState(
      annualHouseholdIncome:
          annualHouseholdIncome ?? this.annualHouseholdIncome,
      investibleLiquidAssets:
          investibleLiquidAssets ?? this.investibleLiquidAssets,
      fundingSource: fundingSource ?? this.fundingSource,
      employmentStatus: employmentStatus ?? this.employmentStatus,
      occupation: occupation ?? this.occupation,
      otherOccupation: otherOccupation ?? this.otherOccupation,
      employer: employer ?? this.employer,
      employerAddress: employerAddress ?? this.employerAddress,
      employerAddressTwo: employerAddressTwo ?? this.employerAddressTwo,
    );
  }

  @override
  List<Object> get props {
    return [
      annualHouseholdIncome,
      investibleLiquidAssets,
      fundingSource,
      employmentStatus,
      occupation ?? '',
      otherOccupation ?? '',
      employer ?? '',
      employerAddress ?? '',
      employerAddressTwo ?? '',
    ];
  }

  bool enableNextButton() {
    if (investibleLiquidAssets.isNotEmpty &&
        fundingSource != FundingSource.unknown &&
        employmentStatus != EmploymentStatus.unknown &&
        employmentStatus != EmploymentStatus.employed) {
      return true;
    } else if (employmentStatus == EmploymentStatus.employed &&
        occupation != null &&
        occupation != Occupations.other) {
      return true;
    } else if (occupation == Occupations.other &&
        otherOccupation != null &&
        otherOccupation!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
