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

class FinancialProfileInvestibleLiquidAssetChanged
    extends FinancialProfileEvent {
  final String investibleLiquidAssets;

  const FinancialProfileInvestibleLiquidAssetChanged(
      this.investibleLiquidAssets)
      : super();

  @override
  List<Object> get props => [investibleLiquidAssets];
}

class FinancialProfileFundingSourceChanged extends FinancialProfileEvent {
  final FundingSource fundingSource;

  const FinancialProfileFundingSourceChanged(this.fundingSource) : super();

  @override
  List<Object> get props => [fundingSource];
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
