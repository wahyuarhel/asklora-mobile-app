import 'package:asklora_mobile_app/feature/onboarding/kyc/bloc/signing_agreement/signing_agreement_bloc.dart';
import 'package:asklora_mobile_app/feature/onboarding/kyc/repository/signing_broker_agreement_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'personal_info_bloc_test.dart';

@GenerateMocks([SigningBrokerAgreementRepository])
void main() async {
  group('*Signing Agreement Tax Bloc Test*', () {
    late SigningAgreementBloc signingAgreementBloc;

    SigningAgreementState signingAgreementState = const SigningAgreementState();

    setUp(() async {
      signingAgreementBloc = SigningAgreementBloc(
          signingBrokerAgreementRepository: SigningBrokerAgreementRepository(),
          personalInfoBloc: MockPersonalInfoBloc());
    });

    test('init state data should be "false"', () {
      expect(signingAgreementBloc.state, signingAgreementState);
    });

    blocTest<SigningAgreementBloc, SigningAgreementState>(
        'emits "isAskloraClientAgreementOpened = true" WHEN open asklora client agreement',
        build: () => signingAgreementBloc,
        act: (bloc) {
          bloc.add(const AskLoraClientAgreementOpened());
        },
        expect: () => {
              signingAgreementState.copyWith(
                  isAskLoraClientAgreementOpened: true)
            });

    blocTest<SigningAgreementBloc, SigningAgreementState>(
        'emits "isBoundByAskloraAgreementChecked = true" WHEN open check on the agreement',
        build: () => signingAgreementBloc,
        act: (bloc) {
          bloc.add(const BoundByAskloraAgreementChecked(true));
        },
        expect: () => {
              signingAgreementState.copyWith(
                  isBoundByAskloraAgreementChecked: true)
            });

    blocTest<SigningAgreementBloc, SigningAgreementState>(
        'emits "isUnderstandOnTheAgreementChecked = true" WHEN open check on the agreement',
        build: () => signingAgreementBloc,
        act: (bloc) {
          bloc.add(const UnderstandOnTheAgreementChecked(true));
        },
        expect: () => {
              signingAgreementState.copyWith(
                  isUnderstandOnTheAgreementChecked: true)
            });

    blocTest<SigningAgreementBloc, SigningAgreementState>(
        'emits "isRiskDisclosureAgreementChecked = true" WHEN open check on the agreement',
        build: () => signingAgreementBloc,
        act: (bloc) {
          bloc.add(const RiskDisclosureAgreementChecked(true));
        },
        expect: () => {
              signingAgreementState.copyWith(
                  isRiskDisclosureAgreementChecked: true)
            });

    tearDown(() => signingAgreementBloc.close());
  });
}
