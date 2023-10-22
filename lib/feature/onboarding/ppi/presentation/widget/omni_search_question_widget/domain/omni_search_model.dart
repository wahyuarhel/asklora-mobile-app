import 'package:json_annotation/json_annotation.dart';

part 'omni_search_model.g.dart';

@JsonSerializable()
class OmniSearchModel {
  final List<String> keywords;
  final List<String> keywordAnswers;

  OmniSearchModel({this.keywords = const [], this.keywordAnswers = const []});

  factory OmniSearchModel.fromJson(Map<String, dynamic> json) =>
      _$OmniSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$OmniSearchModelToJson(this);
}
