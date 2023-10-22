import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_otp_request.g.dart';

enum OtpType { password, register }

extension Type on OtpType {
  String get value {
    switch (this) {
      case OtpType.register:
        return 'REGISTER';
      case OtpType.password:
        return 'PASSWORD';
      default:
        return '';
    }
  }
}

@JsonSerializable()
class GetOtpRequest extends Equatable {
  final String email;

  @JsonKey(name: 'otp_type')
  final String otpType;

  const GetOtpRequest(this.email, this.otpType);

  factory GetOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$GetOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetOtpRequestToJson(this);

  @override
  List<Object?> get props => [email, otpType];
}
