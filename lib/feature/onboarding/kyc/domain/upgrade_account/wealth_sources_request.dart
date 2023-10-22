import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wealth_sources_request.g.dart';

@JsonSerializable()
class WealthSourcesRequest extends Equatable {
  @JsonKey(name: 'wealth_source', includeIfNull: false)
  final String? wealthSource;
  @JsonKey(includeIfNull: false)
  final int? percentage;

  const WealthSourcesRequest({
    this.wealthSource,
    this.percentage,
  });

  factory WealthSourcesRequest.fromJson(Map<String, dynamic> json) =>
      _$WealthSourcesRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WealthSourcesRequestToJson(this);

  @override
  List<Object> get props => [
        wealthSource ?? '',
        percentage ?? 0,
      ];
}
