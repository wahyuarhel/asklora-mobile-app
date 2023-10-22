import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/feature/tabs/for_you/bloc/for_you_bloc.dart';
import 'package:asklora_mobile_app/feature/tabs/for_you/repository/for_you_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'for_you_bloc_test.mocks.dart';

@GenerateMocks([ForYouRepository])
void main() async {
  group('For You Bloc Tests', () {
    late MockForYouRepository forYouRepository;
    late ForYouBloc forYouBloc;

    final BaseResponse<bool> response = BaseResponse.complete(true);

    setUpAll(() async {
      forYouRepository = MockForYouRepository();
    });

    setUp(() async {
      forYouBloc = ForYouBloc(forYouRepository: forYouRepository);
    });

    test('For You Bloc init state response should be default one', () {
      expect(forYouBloc.state, const ForYouState());
    });

    blocTest<ForYouBloc, ForYouState>(
        'emits `BaseResponse.complete` WHEN '
        'get investment style answer',
        build: () {
          when(forYouRepository.getInvestmentStyleState())
              .thenAnswer((_) => Future.value(response));
          return forYouBloc;
        },
        act: (bloc) => bloc.add(GetInvestmentStyleState()),
        expect: () => {
              ForYouState(response: BaseResponse.loading()),
              ForYouState(response: response)
            });

    blocTest<ForYouBloc, ForYouState>(
        'emits `BaseResponse.complete` WHEN '
        'get investment style answer',
        build: () {
          when(forYouRepository.getInvestmentStyleState())
              .thenAnswer((_) => Future.value(response));
          return forYouBloc;
        },
        act: (bloc) => bloc.add(GetInvestmentStyleState()),
        expect: () => {
              ForYouState(response: BaseResponse.loading()),
              ForYouState(response: response)
            });

    tearDown(() => {forYouBloc.close()});
  });
}
