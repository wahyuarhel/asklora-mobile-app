import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_verify_response.g.dart';

@JsonSerializable()
class TokenVerifyResponse extends Equatable {
  final String? detail;
  final String? code;

  const TokenVerifyResponse(
    this.detail,
    this.code,
  );

  factory TokenVerifyResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenVerifyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenVerifyResponseToJson(this);

  @override
  List<Object?> get props => [detail, code];
}
