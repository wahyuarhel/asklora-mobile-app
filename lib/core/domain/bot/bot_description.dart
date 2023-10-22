import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bot_description.g.dart';

@JsonSerializable()
class BotDescriptionModel extends Equatable {
  final String detail;
  final String suited;
  final String works;

  const BotDescriptionModel(this.detail, this.suited, this.works);

  factory BotDescriptionModel.fromJson(Map<String, dynamic> json) =>
      _$BotDescriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$BotDescriptionModelToJson(this);

  @override
  List<Object?> get props => [detail, suited, works];
}
