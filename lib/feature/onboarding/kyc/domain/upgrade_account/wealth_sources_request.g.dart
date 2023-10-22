// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wealth_sources_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WealthSourcesRequest _$WealthSourcesRequestFromJson(
        Map<String, dynamic> json) =>
    WealthSourcesRequest(
      wealthSource: json['wealth_source'] as String?,
      percentage: json['percentage'] as int?,
    );

Map<String, dynamic> _$WealthSourcesRequestToJson(
    WealthSourcesRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('wealth_source', instance.wealthSource);
  writeNotNull('percentage', instance.percentage);
  return val;
}
