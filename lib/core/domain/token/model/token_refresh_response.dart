import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_refresh_response.g.dart';

@JsonSerializable()
class TokenRefreshResponse extends Equatable {
  final String? access;

  const TokenRefreshResponse(
    this.access,
  );

  factory TokenRefreshResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenRefreshResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenRefreshResponseToJson(this);

  @override
  List<Object?> get props => [access];
}
