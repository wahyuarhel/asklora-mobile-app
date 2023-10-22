import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'personal_info_response.g.dart';

@JsonSerializable()
class PersonalInfoResponse extends Equatable {
  final String? detail;

  const PersonalInfoResponse({
    this.detail,
  });

  factory PersonalInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$PersonalInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalInfoResponseToJson(this);

  @override
  List<Object?> get props => [detail ?? ''];
}
