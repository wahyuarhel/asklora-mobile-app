part of 'otp_bloc.dart';

class OtpState extends Equatable {
  final BaseResponse response;
  final String otp;
  final int resetTime;
  final bool disableRequest;
  final bool otpError;
  final String phoneNumber;

  const OtpState({
    this.disableRequest = false,
    this.response = const BaseResponse(),
    this.otp = '',
    this.resetTime = 0,
    this.otpError = false,
    this.phoneNumber = '',
  }) : super();

  @override
  List<Object> get props => [
        disableRequest,
        response,
        otp,
        resetTime,
        otpError,
        phoneNumber,
      ];

  OtpState copyWith({
    BaseResponse? response,
    String? otp,
    bool? disableRequest,
    int? resetTime,
    bool? otpError,
    String? phoneNumber,
  }) {
    return OtpState(
      response: response ?? this.response,
      otp: otp ?? this.otp,
      disableRequest: disableRequest ?? this.disableRequest,
      resetTime: resetTime ?? this.resetTime,
      otpError: otpError ?? this.otpError,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
