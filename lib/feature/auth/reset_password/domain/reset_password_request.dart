import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request.g.dart';

@JsonSerializable()
class ResetPasswordRequest {
  final String token;
  final String password;
  @JsonKey(name: 'confirm_password')
  final String confirmPassword;

  ResetPasswordRequest(this.token, this.password, this.confirmPassword);

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);

  ResetPasswordRequest copyWith({
    String? token,
    String? password,
    String? confirmPassword,
  }) {
    return ResetPasswordRequest(
      token ?? this.token,
      password ?? this.password,
      confirmPassword ?? this.confirmPassword,
    );
  }
}
