import 'package:json_annotation/json_annotation.dart';

part 'legs.g.dart';

@JsonSerializable()
class Legs {
  final String additionalProp1;
  final String? additionalProp2;
  final String? additionalProp3;

  Legs(
      {required this.additionalProp1,
      this.additionalProp2,
      this.additionalProp3});

  factory Legs.fromJson(Map<String, dynamic> json) => _$LegsFromJson(json);

  Map<String, dynamic> toJson() => _$LegsToJson(this);
}
