import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'affiliated_person.g.dart';

@JsonSerializable()
class AffiliatedPerson extends Equatable {
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;

  const AffiliatedPerson({
    this.firstName,
    this.lastName,
  });

  factory AffiliatedPerson.fromJson(Map<String, dynamic> json) =>
      _$AffiliatedPersonFromJson(json);

  Map<String, dynamic> toJson() => _$AffiliatedPersonToJson(this);

  @override
  List<Object> get props => [
        firstName ?? '',
        lastName ?? '',
      ];
}
