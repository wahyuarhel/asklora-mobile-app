import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'onfido_token_response.g.dart';

@JsonSerializable()
class OnfidoTokenResponse extends Equatable {
  final String token;

  const OnfidoTokenResponse(this.token);

  factory OnfidoTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$OnfidoTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OnfidoTokenResponseToJson(this);

  @override
  List<Object?> get props => [token];
}
