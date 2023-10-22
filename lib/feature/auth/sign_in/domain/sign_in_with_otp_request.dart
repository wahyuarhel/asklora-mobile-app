import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_in_with_otp_request.g.dart';

@JsonSerializable()
class SignInWithOtpRequest extends Equatable {
  final String otp;
  final String email;
  final String password;

  const SignInWithOtpRequest(this.otp, this.email, this.password);

  factory SignInWithOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$SignInWithOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignInWithOtpRequestToJson(this);

  @override
  List<Object?> get props => [otp, email, password];
}
