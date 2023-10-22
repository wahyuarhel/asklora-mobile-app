import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/core/domain/otp/get_otp_request.dart';
import 'package:asklora_mobile_app/core/domain/validation_enum.dart';
import 'package:asklora_mobile_app/core/utils/storage/shared_preference.dart';
import 'package:asklora_mobile_app/core/utils/storage/storage_keys.dart';
import 'package:asklora_mobile_app/feature/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:asklora_mobile_app/feature/auth/sign_up/domain/response.dart';
import 'package:asklora_mobile_app/feature/auth/sign_up/domain/sign_up_api_client.dart';
import 'package:asklora_mobile_app/feature/auth/sign_up/repository/sign_up_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_up_bloc_test.mocks.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

class MockCounterBloc extends MockBloc<SignUpEvent, SignUpState>
    implements SignUpBloc {}

@GenerateMocks([SignUpRepository])
@GenerateMocks([SignUpApiClient])
@GenerateMocks([SharedPreference])
void main() async {
  group('Sign Up Screen Bloc Tests', () {
    late MockSignUpRepository signUpRepository;
    late SharedPreference sharedPreference;
    late SignUpBloc signUpBloc;

    setUpAll(() async {
      signUpRepository = MockSignUpRepository();
      sharedPreference = MockSharedPreference();

      when(sharedPreference.writeBoolData(StorageKeys.sfFreshInstall, false))
          .thenAnswer((_) async => true);
    });

    setUp(() async {
      signUpBloc = SignUpBloc(
          signUpRepository: signUpRepository,
          sharedPreference: sharedPreference);
    });

    test('Sign Up Bloc init state is should be `unknown`', () {
      expect(
          signUpBloc.state,
          const SignUpState(
              response: BaseResponse(),
              isEmailValid: false,
              isPasswordValid: false,
              username: '',
              userNameValidation: ValidationCode.empty,
              password: '',
              passwordValidation: ValidationCode.empty));
    });

    blocTest<SignUpBloc, SignUpState>(
        'emits `SignUpStatus.unknown` and `isEmailValid = false` WHEN '
        'entered an invalid email',
        build: () => signUpBloc,
        act: (bloc) => bloc.add(const SignUpUsernameChanged('kkkkkk')),
        expect: () => {
              SignUpState(
                  response: BaseResponse.unknown(),
                  isEmailValid: false,
                  isPasswordValid: false,
                  username: 'kkkkkk',
                  userNameValidation: ValidationCode.enterValidEmail,
                  password: '',
                  passwordValidation: ValidationCode.empty)
            });

    blocTest<SignUpBloc, SignUpState>(
        'emits `SignUpStatus.unknown` and `isEmailValid = false` WHEN '
        'entered an invalid email',
        build: () => signUpBloc,
        act: (bloc) => bloc.add(const SignUpUsernameChanged('test@test.c@')),
        expect: () => {
              SignUpState(
                  response: BaseResponse.unknown(),
                  isEmailValid: false,
                  isPasswordValid: false,
                  username: 'test@test.c@',
                  userNameValidation: ValidationCode.enterValidEmail,
                  password: '',
                  passwordValidation: ValidationCode.empty)
            });

    blocTest<SignUpBloc, SignUpState>(
        'emits `SignUpStatus.unknown` and `isEmailValid = true` WHEN '
        'entered an valid email',
        build: () => signUpBloc,
        act: (bloc) => bloc.add(const SignUpUsernameChanged('test@test.com')),
        expect: () => {
              SignUpState(
                  response: BaseResponse.unknown(),
                  isEmailValid: true,
                  isPasswordValid: false,
                  username: 'test@test.com',
                  userNameValidation: ValidationCode.empty,
                  password: '',
                  passwordValidation: ValidationCode.empty)
            });

    blocTest<SignUpBloc, SignUpState>(
        'emits `SignUpStatus.unknown` and `isPasswordValid = false` WHEN '
        'entered less than 8 chars of password',
        build: () => signUpBloc,
        act: (bloc) => bloc.add(const SignUpPasswordChanged('abcde')),
        expect: () => {
              SignUpState(
                  response: BaseResponse.unknown(),
                  isEmailValid: false,
                  isPasswordValid: false,
                  username: '',
                  userNameValidation: ValidationCode.empty,
                  password: 'abcde',
                  passwordValidation: ValidationCode.enterValidPassword)
            });

    blocTest<SignUpBloc, SignUpState>(
        'emits `SignUpStatus.unknown` and `isPasswordValid = false` WHEN '
        'entered chars of password without numbers',
        build: () => signUpBloc,
        act: (bloc) => bloc.add(const SignUpPasswordChanged('abcdefge')),
        expect: () => {
              SignUpState(
                  response: BaseResponse.unknown(),
                  isEmailValid: false,
                  isPasswordValid: false,
                  username: '',
                  userNameValidation: ValidationCode.empty,
                  password: 'abcdefge',
                  passwordValidation: ValidationCode.enterValidPassword)
            });

    blocTest<SignUpBloc, SignUpState>(
        'emits `SignUpStatus.unknown` and `isPasswordValid = true` WHEN '
        'entered correct password',
        build: () => signUpBloc,
        act: (bloc) => bloc.add(const SignUpPasswordChanged('Password1')),
        expect: () => {
              SignUpState(
                response: BaseResponse.unknown(),
                isEmailValid: false,
                isPasswordValid: true,
                username: '',
                userNameValidation: ValidationCode.empty,
                password: 'Password1',
                passwordValidation: ValidationCode.empty,
              )
            });

    blocTest<SignUpBloc, SignUpState>(
        'emits `SignUpStatus.unknown` and `isPasswordValid = false` and `isEmailValid = false` WHEN '
        'entered invalid password and invalid email',
        build: () => signUpBloc,
        act: (bloc) => {
              bloc.add(const SignUpUsernameChanged('abcd')),
              bloc.add(const SignUpPasswordChanged('pass')),
            },
        expect: () => {
              SignUpState(
                  response: BaseResponse.unknown(),
                  isEmailValid: false,
                  isPasswordValid: false,
                  username: 'abcd',
                  userNameValidation: ValidationCode.enterValidEmail,
                  password: '',
                  passwordValidation: ValidationCode.empty),
              SignUpState(
                  response: BaseResponse.unknown(),
                  isEmailValid: false,
                  isPasswordValid: false,
                  username: 'abcd',
                  userNameValidation: ValidationCode.enterValidEmail,
                  password: 'pass',
                  passwordValidation: ValidationCode.enterValidPassword)
            });

    blocTest<SignUpBloc, SignUpState>(
        'emits `SignUpStatus.unknown` and `isPasswordValid = true` and `isEmailValid = true` WHEN '
        'entered correct password and correct email',
        build: () => signUpBloc,
        act: (bloc) => {
              bloc.add(const SignUpUsernameChanged('kk@test.com')),
              bloc.add(const SignUpPasswordChanged('Password1')),
            },
        expect: () => {
              SignUpState(
                  response: BaseResponse.unknown(),
                  isEmailValid: true,
                  isPasswordValid: false,
                  username: 'kk@test.com',
                  userNameValidation: ValidationCode.empty,
                  password: '',
                  passwordValidation: ValidationCode.empty),
              SignUpState(
                  response: BaseResponse.unknown(),
                  isEmailValid: true,
                  isPasswordValid: true,
                  username: 'kk@test.com',
                  userNameValidation: ValidationCode.empty,
                  password: 'Password1',
                  passwordValidation: ValidationCode.empty)
            });

    blocTest<SignUpBloc, SignUpState>(
        'emits `SignUpStatus.success` WHEN '
        'entered correct password and correct email WHEN '
        'pressed `Submit` button',
        build: () {
          when(sharedPreference.writeData(
                  StorageKeys.sfKeyEmail, 'kk@test.com'))
              .thenAnswer((_) => Future.value(true));

          when(sharedPreference.readData(StorageKeys.sfKeyPpiAccountId))
              .thenAnswer((_) => Future.value('AAAA|BBBB|CCCC'));

          when(sharedPreference.readIntData(StorageKeys.sfKeyPpiUserId))
              .thenAnswer((_) => Future.value(101));

          when(signUpRepository.signUp(
                  email: 'kk@test.com',
                  password: 'Password1',
                  username: 'AAAA|BBBB|CCCC'))
              .thenAnswer((_) => Future.value(
                  const BaseResponse<SignUpResponse>(
                      data: SignUpResponse('Sign Up Successful'),
                      state: ResponseState.success)));

          when(signUpRepository.getVerificationEmail(
                  getVerificationEmailRequest:
                      GetOtpRequest('kk@test.com', OtpType.register.value)))
              .thenAnswer((_) => Future.value(
                  const BaseResponse<GetOtpResponse>(
                      data: GetOtpResponse('Success', ''),
                      state: ResponseState.success)));
          return signUpBloc;
        },
        act: (bloc) => {
              bloc.add(const SignUpUsernameChanged('kk@test.com')),
              bloc.add(const SignUpPasswordChanged('Password1')),
              bloc.add(const SignUpSubmitted()),
            },
        expect: () => {
              SignUpState(
                response: BaseResponse.unknown(),
                isEmailValid: true,
                username: 'kk@test.com',
              ),
              SignUpState(
                response: BaseResponse.unknown(),
                isEmailValid: true,
                isPasswordValid: true,
                username: 'kk@test.com',
                password: 'Password1',
              ),
              SignUpState(
                  response: BaseResponse.loading(),
                  isEmailValid: true,
                  isPasswordValid: true,
                  username: 'kk@test.com',
                  userNameValidation: ValidationCode.empty,
                  password: 'Password1',
                  passwordValidation: ValidationCode.empty),
              const SignUpState(
                  response: BaseResponse<SignUpResponse>(
                      data: SignUpResponse('Sign Up Successful'),
                      state: ResponseState.success),
                  isEmailValid: true,
                  isPasswordValid: true,
                  username: 'kk@test.com',
                  userNameValidation: ValidationCode.empty,
                  password: 'Password1',
                  passwordValidation: ValidationCode.empty)
            });

    tearDown(() => {signUpBloc.close()});
  });
}
