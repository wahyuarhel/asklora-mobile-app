import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'bot_description.dart';
part 'bot_info.g.dart';

@JsonSerializable()
class BotInfo extends Equatable {
  @JsonKey(name: 'bot_type')
  final String botType;
  @JsonKey(name: 'bot_name')
  final String botName;
  @JsonKey(name: 'bot_description')
  final BotDescriptionModel botDescription;

  const BotInfo(this.botType, this.botName, this.botDescription);

  factory BotInfo.fromJson(Map<String, dynamic> json) =>
      _$BotInfoFromJson(json);

  Map<String, dynamic> toJson() => _$BotInfoToJson(this);

  @override
  List<Object?> get props => [botDescription, botType, botName];
}
