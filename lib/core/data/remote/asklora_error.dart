import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/validation_enum.dart';

part 'asklora_error.g.dart';

@JsonSerializable()
class AskloraError extends Equatable {
  final String detail;
  final String code;

  const AskloraError({this.detail = '', this.code = 'UNKNOWN'});

  AskloraError copyWith({
    String? detail,
    String? code,
  }) {
    return AskloraError(
      detail: detail ?? this.detail,
      code: code ?? this.code,
    );
  }

  ValidationCode get type => ValidationCode.getTypeByCode(code);

  factory AskloraError.fromJson(Map<String, dynamic> json) {
    try {
      return _$AskloraErrorFromJson(json);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Map<String, dynamic> toJson() => _$AskloraErrorToJson(this);

  @override
  List<Object?> get props => [detail, code];
}
