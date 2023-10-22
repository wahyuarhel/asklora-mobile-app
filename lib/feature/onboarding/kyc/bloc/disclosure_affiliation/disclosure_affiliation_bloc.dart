import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/upgrade_account/affiliated_person.dart';

part 'disclosure_affiliation_event.dart';

part 'disclosure_affiliation_state.dart';

class DisclosureAffiliationBloc
    extends Bloc<DisclosuresAffiliationEvent, DisclosureAffiliationState> {
  DisclosureAffiliationBloc() : super(const DisclosureAffiliationState()) {
    on<AffiliatedPersonChanged>(_onAffiliatedPersonChanged);
    on<ResetAffiliatedAnswer>(_onResetAffiliatedPersonAnswer);
    on<AffiliatedAssociatesChanged>(_onAffiliateAssociatesChanged);
    on<AffiliatedCommissionChanged>(_onAffiliateCommissionChanged);
    on<AffiliatePersonFirstNameChanged>(_onAffiliatePersonFirstNameChanged);
    on<AffiliatePersonLastNameChanged>(_onAffiliatePersonLastNameChanged);
    on<AffiliateAssociatesFirstNameChanged>(
        _onAffiliateAssociatesFirstNameChanged);
    on<AffiliateAssociatesLastNameChanged>(
        _onAffiliateAssociatesLastNameChanged);
    on<AffiliateAssociatesReset>(_onAffiliateAssociatesReset);
    on<InitiateDisclosureAffiliation>(_onInitiateDisclosureAffiliation);
  }

  _onInitiateDisclosureAffiliation(InitiateDisclosureAffiliation event,
      Emitter<DisclosureAffiliationState> emit) {
    emit(state.copyWith(
        isAffiliatedPerson: () => event.immediateFamilyAffiliation,
        isAffiliatedAssociates: event.associatesAffiliation,
        affiliatedPersonFirstName: event.affiliatedPerson?.firstName,
        affiliatedPersonLastName: event.affiliatedPerson?.lastName));
  }

  _onAffiliatedPersonChanged(
      AffiliatedPersonChanged event, Emitter<DisclosureAffiliationState> emit) {
    emit(state.copyWith(isAffiliatedPerson: () => event.isAffiliatedPerson));
  }

  _onResetAffiliatedPersonAnswer(
      ResetAffiliatedAnswer event, Emitter<DisclosureAffiliationState> emit) {
    emit(state.copyWith(isAffiliatedPerson: () => null));
  }

  _onAffiliateAssociatesChanged(AffiliatedAssociatesChanged event,
      Emitter<DisclosureAffiliationState> emit) {
    emit(state.copyWith(isAffiliatedAssociates: event.isAffiliatedAssociates));
  }

  _onAffiliateCommissionChanged(AffiliatedCommissionChanged event,
      Emitter<DisclosureAffiliationState> emit) {
    emit(state.copyWith(isAffiliatedCommission: event.isAffiliatedCommission));
  }

  _onAffiliatePersonFirstNameChanged(AffiliatePersonFirstNameChanged event,
      Emitter<DisclosureAffiliationState> emit) {
    emit(state.copyWith(affiliatedPersonFirstName: event.firstName));
  }

  _onAffiliatePersonLastNameChanged(AffiliatePersonLastNameChanged event,
      Emitter<DisclosureAffiliationState> emit) {
    emit(state.copyWith(affiliatedPersonLastName: event.lastName));
  }

  _onAffiliateAssociatesFirstNameChanged(
      AffiliateAssociatesFirstNameChanged event,
      Emitter<DisclosureAffiliationState> emit) {
    emit(state.copyWith(affiliatedAssociatesFirstName: event.firstName));
  }

  _onAffiliateAssociatesLastNameChanged(
      AffiliateAssociatesLastNameChanged event,
      Emitter<DisclosureAffiliationState> emit) {
    emit(state.copyWith(affiliatedAssociatesLastName: event.lastName));
  }

  _onAffiliateAssociatesReset(AffiliateAssociatesReset event,
      Emitter<DisclosureAffiliationState> emit) {
    emit(state.copyWith(
      affiliatedPersonFirstName: '',
      affiliatedPersonLastName: '',
    ));
  }
}
