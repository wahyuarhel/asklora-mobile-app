import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_password_response.g.dart';

@JsonSerializable()
class ChangePasswordResponse extends Equatable {
  final String detail;

  const ChangePasswordResponse(
    this.detail,
  );

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordResponseToJson(this);

  @override
  List<Object?> get props => [detail];
}
