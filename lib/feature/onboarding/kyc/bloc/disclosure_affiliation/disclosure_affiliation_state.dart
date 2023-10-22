part of 'disclosure_affiliation_bloc.dart';

class DisclosureAffiliationState extends Equatable {
  final bool? isAffiliatedPerson;
  final bool? isAffiliatedAssociates;
  final bool? isAffiliatedCommission;
  final String affiliatedPersonFirstName;
  final String affiliatedPersonLastName;
  final String affiliatedAssociatesFirstName;
  final String affiliatedAssociatesLastName;

  const DisclosureAffiliationState({
    this.isAffiliatedPerson,
    this.isAffiliatedAssociates,
    this.isAffiliatedCommission,
    this.affiliatedPersonFirstName = '',
    this.affiliatedPersonLastName = '',
    this.affiliatedAssociatesFirstName = '',
    this.affiliatedAssociatesLastName = '',
  });

  DisclosureAffiliationState copyWith({
    ValueGetter<bool?>? isAffiliatedPerson,
    bool? isAffiliatedAssociates,
    bool? isAffiliatedCommission,
    String? affiliatedPersonFirstName,
    String? affiliatedPersonLastName,
    String? affiliatedAssociatesFirstName,
    String? affiliatedAssociatesLastName,
  }) {
    return DisclosureAffiliationState(
      isAffiliatedPerson: isAffiliatedPerson != null
          ? isAffiliatedPerson()
          : this.isAffiliatedPerson,
      isAffiliatedAssociates:
          isAffiliatedAssociates ?? this.isAffiliatedAssociates,
      isAffiliatedCommission:
          isAffiliatedCommission ?? this.isAffiliatedCommission,
      affiliatedPersonFirstName:
          affiliatedPersonFirstName ?? this.affiliatedPersonFirstName,
      affiliatedPersonLastName:
          affiliatedPersonLastName ?? this.affiliatedPersonLastName,
      affiliatedAssociatesFirstName:
          affiliatedAssociatesFirstName ?? this.affiliatedAssociatesFirstName,
      affiliatedAssociatesLastName:
          affiliatedAssociatesLastName ?? this.affiliatedAssociatesLastName,
    );
  }

  @override
  List<Object?> get props => [
        isAffiliatedPerson,
        isAffiliatedAssociates,
        isAffiliatedCommission,
        affiliatedPersonFirstName,
        affiliatedPersonLastName,
        affiliatedAssociatesFirstName,
        affiliatedAssociatesLastName
      ];
}
