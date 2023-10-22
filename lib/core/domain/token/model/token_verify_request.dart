import 'package:json_annotation/json_annotation.dart';

part 'token_verify_request.g.dart';

@JsonSerializable()
class TokenVerifyRequest {
  final String token;

  TokenVerifyRequest(this.token);

  factory TokenVerifyRequest.fromJson(Map<String, dynamic> json) =>
      _$TokenVerifyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TokenVerifyRequestToJson(this);
}
