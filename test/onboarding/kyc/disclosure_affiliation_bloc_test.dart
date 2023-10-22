import 'package:asklora_mobile_app/feature/onboarding/kyc/bloc/disclosure_affiliation/disclosure_affiliation_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  group('*Disclosure & AFfiliation Bloc Test*', () {
    late DisclosureAffiliationBloc disclosureAffiliationBloc;

    setUp(() async {
      disclosureAffiliationBloc = DisclosureAffiliationBloc();
    });

    test(
        'init state data should be "null" on all question and "empty string" on optional text input',
        () {
      expect(
          disclosureAffiliationBloc.state, const DisclosureAffiliationState());
    });
    blocTest<DisclosureAffiliationBloc, DisclosureAffiliationState>(
        'affiliated person = "Yes"',
        build: () => disclosureAffiliationBloc,
        act: (bloc) => {
              bloc.add(const AffiliatedPersonChanged(true)),
            },
        expect: () => {
              const DisclosureAffiliationState(
                isAffiliatedPerson: true,
              ),
            });
    blocTest<DisclosureAffiliationBloc, DisclosureAffiliationState>(
        'affiliated commission = "Yes"',
        build: () => disclosureAffiliationBloc,
        act: (bloc) => {
              bloc.add(const AffiliatedCommissionChanged(true)),
            },
        expect: () => {
              const DisclosureAffiliationState(
                isAffiliatedCommission: true,
              ),
            });
    blocTest<DisclosureAffiliationBloc, DisclosureAffiliationState>(
        'affiliated associates = "Yes"',
        build: () => disclosureAffiliationBloc,
        act: (bloc) => {
              bloc.add(const AffiliatedAssociatesChanged(true)),
            },
        expect: () => {
              const DisclosureAffiliationState(
                isAffiliatedAssociates: true,
              ),
            });

    blocTest<DisclosureAffiliationBloc, DisclosureAffiliationState>(
        'affiliated person first name = "Richard"',
        build: () => disclosureAffiliationBloc,
        act: (bloc) => {
              bloc.add(const AffiliatePersonFirstNameChanged('Richard')),
            },
        expect: () => {
              const DisclosureAffiliationState(
                affiliatedPersonFirstName: 'Richard',
              ),
            });

    blocTest<DisclosureAffiliationBloc, DisclosureAffiliationState>(
        'affiliated person last name = "Lincoln"',
        build: () => disclosureAffiliationBloc,
        act: (bloc) => {
              bloc.add(const AffiliatePersonLastNameChanged('Lincoln')),
            },
        expect: () => {
              const DisclosureAffiliationState(
                affiliatedPersonLastName: 'Lincoln',
              ),
            });

    blocTest<DisclosureAffiliationBloc, DisclosureAffiliationState>(
        'affiliated associates first name = "Lincoln"',
        build: () => disclosureAffiliationBloc,
        act: (bloc) => {
              bloc.add(const AffiliateAssociatesFirstNameChanged('Richard')),
            },
        expect: () => {
              const DisclosureAffiliationState(
                affiliatedAssociatesFirstName: 'Richard',
              ),
            });

    blocTest<DisclosureAffiliationBloc, DisclosureAffiliationState>(
        'affiliated associates last name = "Lincoln"',
        build: () => disclosureAffiliationBloc,
        act: (bloc) => {
              bloc.add(const AffiliateAssociatesLastNameChanged('Lincoln')),
            },
        expect: () => {
              const DisclosureAffiliationState(
                affiliatedAssociatesLastName: 'Lincoln',
              ),
            });

    tearDown(() => {disclosureAffiliationBloc.close()});
  });
}
