import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/feature/auth/repository/auth_repository.dart';
import 'package:asklora_mobile_app/feature/auth/reset_password/bloc/reset_password_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_bloc_test.mocks.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

class MockForgotPasswordBloc
    extends MockBloc<ResetPasswordEvent, ResetPasswordState>
    implements ResetPasswordBloc {}

@GenerateMocks([AuthRepository])
void main() {
  group(
    'Reset Password Screen Bloc Test',
    () {
      late MockAuthRepository authRepository;
      late ResetPasswordBloc resetPasswordBloc;

      setUpAll(
        () async {
          authRepository = MockAuthRepository();
        },
      );

      setUp(
        () async {
          resetPasswordBloc = ResetPasswordBloc(authRepository: authRepository);
        },
      );
      test(
        'Reset Password init state is should be unknown',
        () {
          expect(
              resetPasswordBloc.state,
              const ResetPasswordState(
                  response: BaseResponse(),
                  password: '',
                  confirmPassword: '',
                  confirmPasswordError: PasswordValidationError.none,
                  passwordValidationError: PasswordValidationError.none));
        },
      );

      blocTest<ResetPasswordBloc, ResetPasswordState>(
        'emits "ResetPasswordStatus.unknown" and "isPasswordValid = false" and "isConfirmPasswordValid = false" WHEN entered an invalid password.',
        build: () => resetPasswordBloc,
        act: (bloc) {
          bloc.add(const ResetPasswordPasswordChanged('aaaBBB'));
          bloc.add(const ResetPasswordConfirmPasswordChanged('12345'));
        },
        expect: () => {
          const ResetPasswordState(
            response: BaseResponse(),
            password: 'aaaBBB',
            confirmPassword: '',
            passwordValidationError:
                PasswordValidationError.passwordValidationError,
            confirmPasswordError: PasswordValidationError.none,
          ),
          const ResetPasswordState(
            response: BaseResponse(),
            password: 'aaaBBB',
            confirmPassword: '12345',
            passwordValidationError:
                PasswordValidationError.passwordValidationError,
            confirmPasswordError:
                PasswordValidationError.passwordDoesNotMatchError,
          ),
        },
      );

      blocTest<ResetPasswordBloc, ResetPasswordState>(
        'emits "ResetPasswordStatus.unknown" and "isPasswordValid = false" and "isConfirmPasswordValid = false" and "passwordErrorText= Your password does not match."  and "confirmPasswordErrorText= Your password does not match."WHEN entered an valid password and confirmPassword but different value.',
        build: () => resetPasswordBloc,
        act: (bloc) {
          bloc.add(const ResetPasswordPasswordChanged('Aa1234567'));
          bloc.add(const ResetPasswordConfirmPasswordChanged('aA1234567'));
        },
        expect: () => {
          const ResetPasswordState(
            response: BaseResponse(),
            password: 'Aa1234567',
            confirmPassword: '',
            passwordValidationError: PasswordValidationError.none,
            confirmPasswordError: PasswordValidationError.none,
          ),
          const ResetPasswordState(
            response: BaseResponse(),
            password: 'Aa1234567',
            confirmPassword: 'aA1234567',
            passwordValidationError: PasswordValidationError.none,
            confirmPasswordError:
                PasswordValidationError.passwordDoesNotMatchError,
          ),
        },
      );

      blocTest<ResetPasswordBloc, ResetPasswordState>(
        'emits "ResetPasswordStatus.unknown" and "isPasswordValid = true" and "isConfirmPasswordValid = true" and "passwordErrorText='
        '"  and "confirmPasswordErrorText='
        ' "WHEN entered an valid password and confirmPassword with same value.',
        build: () => resetPasswordBloc,
        act: (bloc) {
          bloc.add(const ResetPasswordPasswordChanged('Aa1234567'));
          bloc.add(const ResetPasswordConfirmPasswordChanged('Aa1234567'));
        },
        expect: () => {
          const ResetPasswordState(
              response: BaseResponse(),
              password: 'Aa1234567',
              confirmPassword: '',
              passwordValidationError: PasswordValidationError.none,
              confirmPasswordError: PasswordValidationError.none),
          const ResetPasswordState(
            response: BaseResponse(),
            password: 'Aa1234567',
            confirmPassword: 'Aa1234567',
            passwordValidationError: PasswordValidationError.none,
            confirmPasswordError: PasswordValidationError.none,
          ),
        },
      );

      tearDown(() => resetPasswordBloc.close());
    },
  );
}
