import 'package:json_annotation/json_annotation.dart';
part 'change_password_request.g.dart';

@JsonSerializable()
class ChangePasswordRequest {
  final String password;
  @JsonKey(name: 'new_password')
  final String newPassword;
  @JsonKey(name: 'confirm_password')
  final String confirmNewPassword;

  ChangePasswordRequest(
      this.password, this.newPassword, this.confirmNewPassword);

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);

  ChangePasswordRequest copyWith({
    String? password,
    String? newPassword,
    String? confirmNewPassword,
  }) {
    return ChangePasswordRequest(
      password ?? this.password,
      newPassword ?? this.newPassword,
      confirmNewPassword ?? this.confirmNewPassword,
    );
  }
}
