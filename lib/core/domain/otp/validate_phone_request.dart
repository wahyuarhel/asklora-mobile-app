import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'validate_phone_request.g.dart';

@JsonSerializable()
class ValidatePhoneRequest extends Equatable {
  final String otp;

  const ValidatePhoneRequest(this.otp);

  factory ValidatePhoneRequest.fromJson(Map<String, dynamic> json) =>
      _$ValidatePhoneRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ValidatePhoneRequestToJson(this);

  @override
  List<Object?> get props => [otp];
}
