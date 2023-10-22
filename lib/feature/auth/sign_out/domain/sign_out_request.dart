import 'package:json_annotation/json_annotation.dart';

part 'sign_out_request.g.dart';

@JsonSerializable()
class SignOutRequest {
  final String? token;

  SignOutRequest(this.token);

  factory SignOutRequest.fromJson(Map<String, dynamic> json) =>
      _$SignOutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignOutRequestToJson(this);
}
