import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_sms_otp_request.g.dart';

@JsonSerializable()
class GetSmsOtpRequest extends Equatable {
  final String email;

  const GetSmsOtpRequest(this.email);

  factory GetSmsOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$GetSmsOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetSmsOtpRequestToJson(this);

  @override
  List<Object?> get props => [email];
}
