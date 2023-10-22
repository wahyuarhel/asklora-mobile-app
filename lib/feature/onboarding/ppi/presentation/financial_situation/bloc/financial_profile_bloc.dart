import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'financial_profile_event.dart';

part 'financial_profile_state.dart';

class FinancialProfileBloc
    extends Bloc<FinancialProfileEvent, FinancialProfileState> {
  FinancialProfileBloc() : super(const FinancialProfileState()) {
    on<FinancialProfileAnnualHouseholdIncomeChanged>(
        _onFinancialProfileAnnualHouseholdIncomeChanged);
    on<FinancialProfileInvestibleLiquidAssetChanged>(
        _onFinancialProfileInvestibleLiquidAssetChanged);
    on<FinancialProfileFundingSourceChanged>(
        _onFinancialProfileFundingSourceChanged);
    on<FinancialProfileEmploymentStatusChanged>(
        _onFinancialProfileEmploymentStatusChanged);
    on<FinancialProfileOccupationChanged>(_onFinancialProfileOccupationChanged);
    on<FinancialProfileOtherOccupationChanged>(
        _onFinancialProfileOtherOccupationChanged);
    on<FinancialProfileEmployerChanged>(_onFinancialProfileEmployerChanged);
    on<FinancialProfileEmployerAddressChanged>(
        _onFinancialProfileEmployerAddressChanged);
    on<FinancialProfileEmployerAddressTwoChanged>(
        _onFinancialProfileEmployerAddressTwoChanged);
  }

  _onFinancialProfileAnnualHouseholdIncomeChanged(
      FinancialProfileAnnualHouseholdIncomeChanged event,
      Emitter<FinancialProfileState> emit) {
    emit(state.copyWith(annualHouseholdIncome: event.annualHouseholdIncome));
  }

  _onFinancialProfileInvestibleLiquidAssetChanged(
      FinancialProfileInvestibleLiquidAssetChanged event,
      Emitter<FinancialProfileState> emit) {
    emit(state.copyWith(investibleLiquidAssets: event.investibleLiquidAssets));
  }

  _onFinancialProfileFundingSourceChanged(
      FinancialProfileFundingSourceChanged event,
      Emitter<FinancialProfileState> emit) {
    emit(state.copyWith(fundingSource: event.fundingSource));
  }

  _onFinancialProfileEmploymentStatusChanged(
      FinancialProfileEmploymentStatusChanged event,
      Emitter<FinancialProfileState> emit) {
    emit(state.copyWith(employmentStatus: event.employmentStatus));
  }

  _onFinancialProfileOccupationChanged(FinancialProfileOccupationChanged event,
      Emitter<FinancialProfileState> emit) {
    emit(state.copyWith(occupation: event.occupation));
  }

  _onFinancialProfileOtherOccupationChanged(
      FinancialProfileOtherOccupationChanged event,
      Emitter<FinancialProfileState> emit) {
    emit(state.copyWith(otherOccupation: event.otherOccupation));
  }

  _onFinancialProfileEmployerChanged(FinancialProfileEmployerChanged event,
      Emitter<FinancialProfileState> emit) {
    emit(state.copyWith(employer: event.employer));
  }

  _onFinancialProfileEmployerAddressChanged(
      FinancialProfileEmployerAddressChanged event,
      Emitter<FinancialProfileState> emit) {
    emit(state.copyWith(employerAddress: event.employerAddress));
  }

  _onFinancialProfileEmployerAddressTwoChanged(
      FinancialProfileEmployerAddressTwoChanged event,
      Emitter<FinancialProfileState> emit) {
    emit(state.copyWith(employerAddressTwo: event.employerAddressTwo));
  }
}
