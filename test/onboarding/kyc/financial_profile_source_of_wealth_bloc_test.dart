import 'package:asklora_mobile_app/feature/onboarding/kyc/bloc/source_of_wealth/source_of_wealth_bloc.dart';
import 'package:asklora_mobile_app/feature/onboarding/kyc/utils/source_of_wealth_enum.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  group('Source of Wealth Bloc Test', () {
    late SourceOfWealthBloc sourceOfWealthBloc;

    setUp(() async {
      sourceOfWealthBloc = SourceOfWealthBloc();
    });

    test('initial state data should be []', () {
      expect(
        sourceOfWealthBloc.state,
        const SourceOfWealthState(
          sourceOfWealthAnswers: [],
          totalAmount: 0,
          errorMessage: '',
        ),
      );
    });

    blocTest<SourceOfWealthBloc, SourceOfWealthState>(
        'chosen user source of wealth',
        build: () => sourceOfWealthBloc,
        act: (bloc) => {
              bloc.add(const SourceOfWealthSelected(
                  SourceOfWealthType.incomeFromEmployment)),
              bloc.add(
                  const SourceOfWealthSelected(SourceOfWealthType.inheritance)),
              bloc.add(const SourceOfWealthAmountChanged(
                  '100', SourceOfWealthType.inheritance)),
            },
        expect: () => {
              const SourceOfWealthState(sourceOfWealthAnswers: [
                SourceOfWealthModel(
                  sourceOfWealthType: SourceOfWealthType.incomeFromEmployment,
                  amount: 100,
                  isActive: true,
                  additionalSourceOfWealth: null,
                ),
              ], totalAmount: 0),
              const SourceOfWealthState(sourceOfWealthAnswers: [
                SourceOfWealthModel(
                  sourceOfWealthType: SourceOfWealthType.incomeFromEmployment,
                  amount: 100,
                  isActive: true,
                  additionalSourceOfWealth: null,
                ),
                SourceOfWealthModel(
                  sourceOfWealthType: SourceOfWealthType.inheritance,
                  amount: 100,
                  isActive: true,
                  additionalSourceOfWealth: null,
                ),
              ], totalAmount: 0),
              const SourceOfWealthState(sourceOfWealthAnswers: [
                SourceOfWealthModel(
                  sourceOfWealthType: SourceOfWealthType.incomeFromEmployment,
                  amount: 100,
                  isActive: true,
                  additionalSourceOfWealth: null,
                ),
                SourceOfWealthModel(
                  sourceOfWealthType: SourceOfWealthType.inheritance,
                  amount: 100,
                  isActive: true,
                  additionalSourceOfWealth: null,
                ),
              ], totalAmount: 200),
            });
    tearDown(() => sourceOfWealthBloc.close());
  });
}
