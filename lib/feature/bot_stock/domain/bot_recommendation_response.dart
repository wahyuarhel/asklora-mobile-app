import 'package:json_annotation/json_annotation.dart';

import '../../../core/utils/date_utils.dart';
import 'bot_recommendation_model.dart';

part 'bot_recommendation_response.g.dart';

@JsonSerializable()
class BotRecommendationResponse {
  final List<BotRecommendationModel> data;
  final String updated;

  BotRecommendationResponse({this.data = const [], this.updated = ''});

  String get updatedFormatted {
    DateTime localTime = formatDateTimeToLocal(updated);
    return '${formatLocalDateTimeToString(updated, dateFormat: 'HH:mm')} ${localTime.timeZoneName} ${formatLocalDateTimeToString(updated, dateFormat: 'dd/MM/yy')}';
  }

  factory BotRecommendationResponse.fromJson(Map<String, dynamic> json) =>
      _$BotRecommendationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BotRecommendationResponseToJson(this);
}
