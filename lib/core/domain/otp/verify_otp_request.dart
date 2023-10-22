import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_request.g.dart';

@JsonSerializable()
class VerifyOtpRequest extends Equatable {
  final String email;

  @JsonKey(name: 'otp_code')
  final String otpCode;

  const VerifyOtpRequest(this.email, this.otpCode);

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpRequestToJson(this);

  @override
  List<Object?> get props => [email, otpCode];
}
