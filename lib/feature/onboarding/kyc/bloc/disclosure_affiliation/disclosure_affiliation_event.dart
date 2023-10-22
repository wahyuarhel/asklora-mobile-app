part of 'disclosure_affiliation_bloc.dart';

abstract class DisclosuresAffiliationEvent extends Equatable {
  const DisclosuresAffiliationEvent();

  @override
  List<Object> get props => [];
}

class AffiliatedPersonChanged extends DisclosuresAffiliationEvent {
  final bool isAffiliatedPerson;

  const AffiliatedPersonChanged(this.isAffiliatedPerson) : super();

  @override
  List<Object> get props => [isAffiliatedPerson];
}

class ResetAffiliatedAnswer extends DisclosuresAffiliationEvent {}

class AffiliatedCommissionChanged extends DisclosuresAffiliationEvent {
  final bool isAffiliatedCommission;

  const AffiliatedCommissionChanged(this.isAffiliatedCommission) : super();

  @override
  List<Object> get props => [isAffiliatedCommission];
}

class AffiliatedAssociatesChanged extends DisclosuresAffiliationEvent {
  final bool isAffiliatedAssociates;

  const AffiliatedAssociatesChanged(this.isAffiliatedAssociates) : super();

  @override
  List<Object> get props => [isAffiliatedAssociates];
}

class AffiliatePersonFirstNameChanged extends DisclosuresAffiliationEvent {
  final String firstName;

  const AffiliatePersonFirstNameChanged(this.firstName) : super();

  @override
  List<Object> get props => [firstName];
}

class AffiliatePersonLastNameChanged extends DisclosuresAffiliationEvent {
  final String lastName;

  const AffiliatePersonLastNameChanged(this.lastName) : super();

  @override
  List<Object> get props => [lastName];
}

class AffiliateAssociatesFirstNameChanged extends DisclosuresAffiliationEvent {
  final String firstName;

  const AffiliateAssociatesFirstNameChanged(this.firstName) : super();

  @override
  List<Object> get props => [firstName];
}

class AffiliateAssociatesLastNameChanged extends DisclosuresAffiliationEvent {
  final String lastName;

  const AffiliateAssociatesLastNameChanged(this.lastName) : super();

  @override
  List<Object> get props => [lastName];
}

class AffiliateAssociatesReset extends DisclosuresAffiliationEvent {
  const AffiliateAssociatesReset() : super();

  @override
  List<Object> get props => [];
}

class InitiateDisclosureAffiliation extends DisclosuresAffiliationEvent {
  final bool? immediateFamilyAffiliation;
  final bool? associatesAffiliation;
  final AffiliatedPerson? affiliatedPerson;

  const InitiateDisclosureAffiliation(this.immediateFamilyAffiliation,
      this.associatesAffiliation, this.affiliatedPerson);

  @override
  List<Object> get props => [immediateFamilyAffiliation ?? ''];
}
