import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'agreement.g.dart';

@JsonSerializable()
class Agreement extends Equatable {
  final String? agreement;

  const Agreement({
    required this.agreement,
  });

  factory Agreement.fromJson(Map<String, dynamic> json) =>
      _$AgreementFromJson(json);

  Map<String, dynamic> toJson() => _$AgreementToJson(this);

  @override
  List<Object> get props => [agreement ?? ''];
}
