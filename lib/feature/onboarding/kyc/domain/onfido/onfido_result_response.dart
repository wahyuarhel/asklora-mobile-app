import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'onfido_result_response.g.dart';

@JsonSerializable()
class OnfidoResultResponse extends Equatable {
  final String detail;

  const OnfidoResultResponse(
    this.detail,
  );

  factory OnfidoResultResponse.fromJson(Map<String, dynamic> json) =>
      _$OnfidoResultResponseFromJson(json);

  @override
  List<Object?> get props => [];
}
