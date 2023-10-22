import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_out_response.g.dart';

@JsonSerializable()
class SignOutResponse extends Equatable {
  final String detail;

  const SignOutResponse(this.detail);

  factory SignOutResponse.fromJson(Map<String, dynamic> json) =>
      _$SignOutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignOutResponseToJson(this);

  @override
  List<Object?> get props => [detail];
}
