import 'package:asklora_mobile_app/core/domain/base_response.dart';
import 'package:asklora_mobile_app/core/domain/otp/get_otp_client.dart';
import 'package:asklora_mobile_app/core/domain/otp/get_otp_request.dart';
import 'package:asklora_mobile_app/core/domain/otp/verify_otp_request.dart';
import 'package:asklora_mobile_app/feature/auth/otp/bloc/otp_bloc.dart';
import 'package:asklora_mobile_app/feature/auth/otp/repository/otp_repository.dart';
import 'package:asklora_mobile_app/feature/auth/sign_up/domain/response.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'otp_bloc_test.mocks.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

class MockCounterBloc extends MockBloc<OtpEvent, OtpState> implements OtpBloc {}

@GenerateMocks([OtpRepository])
@GenerateMocks([GetOtpClient])
void main() async {
  group('Otp Screen Bloc Tests', () {
    late MockOtpRepository otpRepository;
    late OtpBloc otpBloc;

    setUpAll(() async {
      otpRepository = MockOtpRepository();
    });

    setUp(() async {
      otpBloc = OtpBloc(otpRepository: otpRepository);
    });

    test('Otp Bloc init state is should be `unknown`', () {
      expect(otpBloc.state,
          const OtpState(response: BaseResponse(), otp: '', resetTime: 0));
    });

    blocTest<OtpBloc, OtpState>(
        'emits `OtpStatus.failure` and `resetTime` = 180` WHEN '
        'Tap request otp code using wrong email',
        build: () {
          when(otpRepository.getOtp(
                  getOtpRequest: GetOtpRequest(
                      'test321@example.com', OtpType.register.value)))
              .thenThrow('User does not exist with the given email');
          return otpBloc;
        },
        act: (bloc) => bloc.add(const OtpRequested('test321@example.com')),
        expect: () => {
              OtpState(response: BaseResponse.loading()),
              OtpState(
                  response: BaseResponse.error(
                      message: 'User does not exist with the given email'))
            });

    blocTest<OtpBloc, OtpState>(
        'emits `OtpStatus.unknown` and `resetTime` = 180` WHEN '
        'Tap request otp code using correct email',
        build: () {
          when(otpRepository.getOtp(
                  getOtpRequest: GetOtpRequest(
                      'test123@example.com', OtpType.register.value)))
              .thenAnswer((_) => Future.value(BaseResponse.complete(
                  const GetOtpResponse('OTP code sent to your email', ''))));
          return otpBloc;
        },
        act: (bloc) => bloc.add(const OtpRequested('test123@example.com')),
        expect: () => {
              OtpState(response: BaseResponse.loading()),
              const OtpState(
                response: BaseResponse<GetOtpResponse>(
                    data: GetOtpResponse('OTP code sent to your email', ''),
                    state: ResponseState.success),
                resetTime: 60,
                disableRequest: true,
              ),
            });

    blocTest<OtpBloc, OtpState>(
        'emits `OtpStatus.failure` and `responseMessage` = Invalid OTP` WHEN '
        'Submit the wrong Otp',
        build: () {
          when(otpRepository.verifyOtp(
                  verifyOtpRequest:
                      const VerifyOtpRequest('test123@example.com', '112233')))
              .thenThrow('Invalid OTP');
          return otpBloc;
        },
        act: (bloc) => bloc.add(const OtpSubmitted(
            VerifyOtpRequest('test123@example.com', '112233'))),
        expect: () => {
              OtpState(response: BaseResponse.loading()),
              OtpState(response: BaseResponse.error(message: 'Invalid OTP'))
            });

    blocTest<OtpBloc, OtpState>(
        'emits `OtpStatus.success` and `responseMessage` = Verify OTP Success` WHEN '
        'Submit the correct Otp',
        build: () {
          when(otpRepository.verifyOtp(
                  verifyOtpRequest:
                      const VerifyOtpRequest('test123@example.com', '112233')))
              .thenAnswer((_) => Future.value(BaseResponse.complete(
                  const GetOtpResponse('Verify OTP Success', '112233'))));
          return otpBloc;
        },
        act: (bloc) => bloc.add(const OtpSubmitted(
            VerifyOtpRequest('test123@example.com', '112233'))),
        expect: () => {
              OtpState(response: BaseResponse.loading()),
              const OtpState(
                  response: BaseResponse<GetOtpResponse>(
                      data: GetOtpResponse('Verify OTP Success', '112233'),
                      state: ResponseState.success))
            });

    tearDown(() => {otpBloc.close()});
  });
}
