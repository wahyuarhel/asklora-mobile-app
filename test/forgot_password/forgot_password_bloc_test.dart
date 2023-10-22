import 'package:asklora_mobile_app/core/domain/validation_enum.dart';
import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/feature/auth/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:asklora_mobile_app/feature/auth/forgot_password/domain/forgot_password_response.dart';
import 'package:asklora_mobile_app/feature/auth/repository/auth_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forgot_password_bloc_test.mocks.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

class MockForgotPasswordBloc
    extends MockBloc<ForgotPasswordEvent, ForgotPasswordState>
    implements ForgotPasswordBloc {}

@GenerateMocks([AuthRepository])
void main() {
  group(
    'Forgot Password Screen Bloc Test',
    () {
      late MockAuthRepository authRepository;
      late ForgotPasswordBloc forgotPasswordBloc;

      setUpAll(
        () async {
          authRepository = MockAuthRepository();
        },
      );

      setUp(
        () async {
          forgotPasswordBloc =
              ForgotPasswordBloc(authRepository: authRepository);
        },
      );
      test(
        'Forgot Password init state is should be unknown',
        () {
          expect(
              forgotPasswordBloc.state,
              const ForgotPasswordState(
                response: BaseResponse(),
                email: '',
                emailValidation: ValidationCode.empty,
              ));
        },
      );

      blocTest<ForgotPasswordBloc, ForgotPasswordState>(
        'emits "ForgotPasswordStatus.unknown" and "isEmailValid = false" WHEN entered an invalid email.',
        build: () => forgotPasswordBloc,
        act: (bloc) => bloc.add(const ForgotPasswordEmailChanged('sadfasdf')),
        expect: () => {
          const ForgotPasswordState(
            response: BaseResponse(),
            email: 'sadfasdf',
            emailValidation: ValidationCode.enterValidEmail,
          ),
        },
      );

      blocTest<ForgotPasswordBloc, ForgotPasswordState>(
        'emits "ForgotPasswordStatus.unknown" and "isEmailValid = true" WHEN entered an valid email.',
        build: () => forgotPasswordBloc,
        act: (bloc) => bloc.add(
          const ForgotPasswordEmailChanged('abc@abc.com'),
        ),
        expect: () => {
          const ForgotPasswordState(
            response: BaseResponse(),
            email: 'abc@abc.com',
            emailValidation: ValidationCode.empty,
          )
        },
      );

      blocTest<ForgotPasswordBloc, ForgotPasswordState>(
          'emits "ForgotPasswordStatus.success" WHEN entered valid email AND pressed "Submit" button.',
          build: () {
            when(authRepository.forgotPassword(email: 'abc@abc.com'))
                .thenAnswer((_) => Future.value(
                    const BaseResponse<ForgotPasswordResponse>(
                        data: ForgotPasswordResponse(
                            'Successfully sent new password!'),
                        state: ResponseState.success)));

            return forgotPasswordBloc;
          },
          act: (bloc) => {
                bloc.add(const ForgotPasswordEmailChanged('abc@abc.com')),
                bloc.add(const ForgotPasswordSubmitted())
              },
          expect: () => {
                const ForgotPasswordState(
                    response: BaseResponse(),
                    email: 'abc@abc.com',
                    emailValidation: ValidationCode.empty),
                ForgotPasswordState(
                  response: BaseResponse.loading(),
                  email: 'abc@abc.com',
                  emailValidation: ValidationCode.empty,
                ),
                const ForgotPasswordState(
                  response: BaseResponse<ForgotPasswordResponse>(
                      data: ForgotPasswordResponse(
                          'Successfully sent new password!'),
                      state: ResponseState.success),
                  email: 'abc@abc.com',
                  emailValidation: ValidationCode.empty,
                )
              });

      tearDown(() => forgotPasswordBloc.close());
    },
  );
}
