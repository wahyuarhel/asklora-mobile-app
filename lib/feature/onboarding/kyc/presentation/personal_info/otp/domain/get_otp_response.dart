import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_otp_response.g.dart';

@JsonSerializable()
class GetOtpResponse extends Equatable {
  final String detail;

  const GetOtpResponse(this.detail);

  factory GetOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$GetOtpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetOtpResponseToJson(this);

  @override
  List<Object?> get props => [detail];
}
