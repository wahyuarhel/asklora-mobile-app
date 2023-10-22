import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/core/domain/triplet.dart';
import 'package:asklora_mobile_app/core/utils/storage/cache/json_cache_shared_preferences.dart';
import 'package:asklora_mobile_app/core/utils/storage/shared_preference.dart';
import 'package:asklora_mobile_app/feature/onboarding/ppi/bloc/response/user_response_bloc.dart';
import 'package:asklora_mobile_app/feature/onboarding/ppi/domain/ppi_user_response.dart';
import 'package:asklora_mobile_app/feature/onboarding/ppi/domain/ppi_user_response_request.dart';
import 'package:asklora_mobile_app/feature/onboarding/ppi/domain/question.dart';
import 'package:asklora_mobile_app/feature/onboarding/ppi/repository/ppi_response_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_response_bloc_test.mocks.dart';

@GenerateMocks(
    [PpiResponseRepository, SharedPreference, JsonCacheSharedPreferences])
void main() async {
  group('User Response Bloc Tests', () {
    late PpiResponseRepository ppiResponseRepository;
    late UserResponseBloc userResponseBloc;
    late SharedPreference sharedPreference;
    late JsonCacheSharedPreferences jsonCacheSharedPreferences;

    PpiSelectionRequest ppiUserResponseRequest =
        PpiSelectionRequest(questionId: 'quid0', answer: 'AAAA', userId: 101);
    PpiUserResponse ppiUserResponse =
        const PpiUserResponse(email: 'xx@gmail.com');

    BaseResponse<PpiUserResponse> response =
        BaseResponse.complete(ppiUserResponse);
    List<Triplet<String, Question, String>> a = [Triplet('', Question(), '')];

    setUpAll(() async {
      ppiResponseRepository = MockPpiResponseRepository();
      sharedPreference = MockSharedPreference();
      jsonCacheSharedPreferences = MockJsonCacheSharedPreferences();
    });

    setUp(() async {
      userResponseBloc = UserResponseBloc(
          ppiResponseRepository: ppiResponseRepository,
          sharedPreference: sharedPreference,
          jsonCacheSharedPreferences: jsonCacheSharedPreferences);
    });

    test('User Response Bloc init state is should be unknown', () {
      expect(userResponseBloc.state,
          const UserResponseState(responseState: ResponseState.unknown));
    });

    blocTest<UserResponseBloc, UserResponseState>(
        'emits ResponseState success and ppiUserResponse(email:xx@gmail.com) WHEN '
        'send answer',
        build: () {
          when(ppiResponseRepository.addAnswer(ppiUserResponseRequest))
              .thenAnswer((_) => Future.value(response));
          return userResponseBloc;
        },
        act: (bloc) => bloc.add(SendResponse(ppiUserResponseRequest)),
        expect: () => {
              const UserResponseState(
                responseState: ResponseState.loading,
              ),
              UserResponseState(
                  responseState: ResponseState.success, userResponse: a)
            });

    tearDown(() => {userResponseBloc.close()});
  });
}
