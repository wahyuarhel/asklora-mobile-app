import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/core/utils/storage/shared_preference.dart';
import 'package:asklora_mobile_app/core/utils/storage/storage_keys.dart';
import 'package:asklora_mobile_app/feature/onboarding/ppi/domain/fixture.dart';
import 'package:asklora_mobile_app/feature/onboarding/ppi/repository/ppi_question_repository.dart';
import 'package:asklora_mobile_app/feature/tabs/for_you/investment_style/bloc/for_you_question_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'for_you_question_bloc_test.mocks.dart';

@GenerateMocks([PpiQuestionRepository])
@GenerateMocks([SharedPreference])
void main() async {
  group('For You Question Bloc Tests', () {
    late MockPpiQuestionRepository ppiQuestionRepository;
    late MockSharedPreference sharedPreference;
    late ForYouQuestionBloc forYouQuestionBloc;

    setUpAll(() async {
      ppiQuestionRepository = MockPpiQuestionRepository();
      sharedPreference = MockSharedPreference();
    });

    setUp(() async {
      forYouQuestionBloc = ForYouQuestionBloc(
          ppiQuestionRepository: ppiQuestionRepository,
          sharedPreference: sharedPreference);
    });

    test('For You Question Bloc init state response should be default one', () {
      expect(forYouQuestionBloc.state, const ForYouQuestionState());
    });

    blocTest<ForYouQuestionBloc, ForYouQuestionState>(
        'emits `BaseResponse.error` WHEN '
        'get investment style answer but with empty data',
        build: () {
          when(sharedPreference.readData(StorageKeys.sfKeyPpiAccountId))
              .thenAnswer((realInvocation) => Future.value('abc'));
          when(ppiQuestionRepository.fetchInvestmentStyleQuestions('abc'))
              .thenAnswer((_) => Future.value(
                  Fixture.instance.fixInvestmentStyleQuestion([])));
          return forYouQuestionBloc;
        },
        act: (bloc) => bloc.add(LoadQuestion()),
        expect: () => {
              ForYouQuestionState(response: BaseResponse.loading()),
              ForYouQuestionState(response: BaseResponse.error())
            });

    tearDown(() => {forYouQuestionBloc.close()});
  });
}
