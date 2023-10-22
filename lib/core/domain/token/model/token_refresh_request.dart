import 'package:json_annotation/json_annotation.dart';

part 'token_refresh_request.g.dart';

@JsonSerializable()
class TokenRefreshRequest {
  final String refresh;

  TokenRefreshRequest(this.refresh);

  factory TokenRefreshRequest.fromJson(Map<String, dynamic> json) =>
      _$TokenRefreshRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TokenRefreshRequestToJson(this);
}
