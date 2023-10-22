import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/core/domain/token/repository/repository.dart';
import 'package:asklora_mobile_app/core/utils/storage/secure_storage.dart';
import 'package:asklora_mobile_app/core/utils/storage/shared_preference.dart';
import 'package:asklora_mobile_app/feature/auth/repository/auth_repository.dart';
import 'package:asklora_mobile_app/feature/auth/sign_out/bloc/sign_out_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_out_bloc_test.mocks.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

@GenerateMocks([AuthRepository])
@GenerateMocks([Repository])
@GenerateMocks([SharedPreference])
@GenerateMocks([SecureStorage])
void main() async {
  group('Sign Up Screen Bloc Tests', () {
    late MockRepository tokenRepository;
    late SignOutBloc signOutBloc;
    late MockAuthRepository authRepository;
    late SharedPreference sharedPreference;
    late SecureStorage secureStorage;

    setUpAll(() async {
      authRepository = MockAuthRepository();
      tokenRepository = MockRepository();
      sharedPreference = MockSharedPreference();
      secureStorage = MockSecureStorage();
    });

    setUp(() async {
      signOutBloc = SignOutBloc(
          tokenRepository: tokenRepository,
          authRepository: authRepository,
          sharedPreference: sharedPreference,
          secureStorage: secureStorage);
    });

    test('Sign Out Bloc init state is should be `unknown`', () {
      expect(signOutBloc.state, const SignOutState(response: BaseResponse()));
    });

    blocTest<SignOutBloc, SignOutState>(
        'emits `SignOutStatus.success` and `responseMessage = Sign Out Success` WHEN '
        'press Sign Out Button',
        build: () {
          when(tokenRepository.getRefreshToken())
              .thenAnswer((realInvocation) => Future.value('refresh_token'));
          when(authRepository.signOut('refresh_token'))
              .thenAnswer((_) => Future.value(true));
          when(tokenRepository.deleteAll())
              .thenAnswer((realInvocation) => Future.value());

          return signOutBloc;
        },
        act: (bloc) => bloc.add(const SignOutSubmitted()),
        expect: () => {
              SignOutState(response: BaseResponse.loading()),
              SignOutState(response: BaseResponse.complete('Sign Out Success'))
            });

    tearDown(() => {signOutBloc.close()});
  });
}
