import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/data/remote/base_api_client.dart';
import '../../../../../../../core/domain/base_response.dart';
import '../../../../../../../core/domain/otp/get_sms_otp_request.dart';
import '../../../../../../../core/domain/otp/validate_phone_request.dart';
import '../../../../../../../core/domain/validation_enum.dart';
import '../../../../../../../core/utils/storage/shared_preference.dart';
import '../../../../../../../core/utils/storage/storage_keys.dart';
import '../../../../../../auth/otp/repository/otp_repository.dart';

part 'otp_event.dart';

part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final OtpRepository _otpRepository;
  final SharedPreference _sharedPreference;
  final int _resetTime = 60;
  StreamSubscription? resetTimeStreamSubscription;

  OtpBloc(
      {required OtpRepository otpRepository,
      required SharedPreference sharedPreference})
      : _otpRepository = otpRepository,
        _sharedPreference = sharedPreference,
        super(const OtpState()) {
    on<OtpSubmitted>(_onOtpSubmitted);
    on<OtpRequested>(_onOtpRequested);
    on<OtpTimeResetUpdate>(_onOtpTimeResetUpdate);
    on<Reset>(_onOtpReset);
    on<InValidOtpEvent>(_onInvalidOtpEvent);
  }

  void _onOtpRequested(OtpRequested event, Emitter<OtpState> emit) async {
    try {
      emit(state.copyWith(response: BaseResponse.loading()));
      final email = await _sharedPreference.readData(StorageKeys.sfKeyEmail);
      var data = await _otpRepository.getSmsOtp(
          getSmsOtpRequest: GetSmsOtpRequest(email ?? ''));
      emit(state.copyWith(
          response: data.copyWith(
              validationCode: ValidationCode.otpSentToYourPhone,
              state: ResponseState.success),
          disableRequest: true,
          resetTime: _resetTime));

      resetTimeStreamSubscription = ticker().listen((_) {
        add(const OtpTimeResetUpdate());
      });
    } on AskloraApiClientException catch (e) {
      emit(state.copyWith(
          response: BaseResponse.error(validationCode: e.askloraError.type)));
    } catch (e) {
      emit(state.copyWith(response: BaseResponse.error()));
    }
  }

  void _onOtpTimeResetUpdate(OtpTimeResetUpdate event, Emitter<OtpState> emit) {
    emit(state.copyWith(
        disableRequest: state.resetTime == 1 ? false : true,
        resetTime: state.resetTime - 1,
        response: BaseResponse.unknown()));
  }

  void _onOtpReset(Reset event, Emitter<OtpState> emit) =>
      emit(state.copyWith(response: BaseResponse.unknown(), otpError: ''));

  void _onInvalidOtpEvent(InValidOtpEvent event, Emitter<OtpState> emit) {
    emit(state.copyWith(
        response: BaseResponse.unknown(), otpError: 'The OTP is incorrect'));
  }

  void _onOtpSubmitted(
    OtpSubmitted event,
    Emitter<OtpState> emit,
  ) async {
    try {
      emit(state.copyWith(response: BaseResponse.loading()));
      var data = await _otpRepository.validatePhone(
          validatePhoneRequest: ValidatePhoneRequest(event.otp));
      cancelStreamSubscription();
      data.copyWith(message: 'Verify OTP Success');
      emit(OtpValidationSuccess());
    } on AskloraApiClientException catch (e) {
      emit(state.copyWith(
          response: BaseResponse.error(validationCode: e.askloraError.type),
          otp: 'The OTP is incorrect'));
    } catch (e) {
      emit(state.copyWith(response: BaseResponse.error()));
    }
  }

  Stream<int> ticker() {
    return Stream<int>.periodic(
        const Duration(seconds: 1), (x) => _resetTime - x).take(_resetTime);
  }

  void cancelStreamSubscription() {
    if (resetTimeStreamSubscription != null) {
      resetTimeStreamSubscription!.cancel();
    }
  }

  @override
  Future<void> close() {
    cancelStreamSubscription();
    return super.close();
  }
}
