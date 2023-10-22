import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/remote/base_api_client.dart';
import '../../../../core/domain/validation_enum.dart';
import '../../../../core/domain/base_response.dart';
import '../../../../core/domain/otp/get_otp_request.dart';
import '../../../../core/domain/otp/get_sms_otp_request.dart';
import '../../../../core/domain/otp/verify_otp_request.dart';
import '../repository/otp_repository.dart';

part 'otp_event.dart';

part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final OtpRepository _otpRepository;
  final int _resetTime = 60;
  StreamSubscription? resetTimeStreamSubscription;

  OtpBloc({
    required OtpRepository otpRepository,
  })  : _otpRepository = otpRepository,
        super(const OtpState()) {
    on<OtpSubmitted>(_onOtpSubmitted);
    on<OtpRequested>(_onOtpRequested);
    on<OtpTimeResetUpdate>(_onOtpTimeResetUpdate);
    on<OtpTyped>(_onOtpTyped);
    on<SmsOtpRequested>(_onSmsOtpRequested);
  }

  void _onOtpRequested(OtpRequested event, Emitter<OtpState> emit) async {
    try {
      emit(state.copyWith(response: BaseResponse.loading()));
      var data = await _otpRepository.getOtp(
          getOtpRequest: GetOtpRequest(event.email, OtpType.register.value));

      data.copyWith(message: ValidationCode.otpSentToYourEmail.code);
      emit(state.copyWith(
          response: data, disableRequest: true, resetTime: _resetTime));

      resetTimeStreamSubscription = ticker().listen((_) {
        add(const OtpTimeResetUpdate());
      });
    } on AskloraApiClientException catch (e) {
      emit(state.copyWith(
          response: BaseResponse.error(validationCode: e.askloraError.type)));
    } catch (e) {
      emit(state.copyWith(response: BaseResponse.error(message: e.toString())));
    }
  }

  void _onSmsOtpRequested(SmsOtpRequested event, Emitter<OtpState> emit) async {
    try {
      emit(state.copyWith(response: BaseResponse.loading()));
      var data = await _otpRepository.getSmsOtp(
          getSmsOtpRequest: GetSmsOtpRequest(event.email));

      data.copyWith(message: ValidationCode.otpSentToYourPhone.code);
      emit(state.copyWith(
        response: data,
        disableRequest: true,
        resetTime: _resetTime,
        phoneNumber: data.data?.phoneNumber,
      ));

      resetTimeStreamSubscription = ticker().listen((_) {
        add(const OtpTimeResetUpdate());
      });
    } on AskloraApiClientException catch (e) {
      emit(state.copyWith(
          response: BaseResponse.error(validationCode: e.askloraError.type)));
    } catch (e) {
      emit(state.copyWith(response: BaseResponse.error(message: e.toString())));
    }
  }

  void _onOtpTimeResetUpdate(OtpTimeResetUpdate event, Emitter<OtpState> emit) {
    emit(state.copyWith(
        disableRequest: state.resetTime == 1 ? false : true,
        resetTime: state.resetTime - 1,
        response: BaseResponse.unknown()));
  }

  void _onOtpTyped(OtpTyped event, Emitter<OtpState> emit) {
    emit(state.copyWith(otp: event.otp, otpError: false));
  }

  void _onOtpSubmitted(
    OtpSubmitted event,
    Emitter<OtpState> emit,
  ) async {
    try {
      emit(state.copyWith(response: BaseResponse.loading()));
      var data = await _otpRepository.verifyOtp(
          verifyOtpRequest: event.verifyOtpRequest);
      cancelStreamSubscription();
      data.copyWith(message: ValidationCode.verifyOtpSuccess.code);
      emit(state.copyWith(response: data));
    } on AskloraApiClientException catch (e) {
      emit(state.copyWith(
          response: BaseResponse.error(
            validationCode: e.askloraError.type,
          ),
          otpError: e.askloraError.type == ValidationCode.otpInvalid));
    } catch (e) {
      emit(state.copyWith(response: BaseResponse.error(message: e.toString())));
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
