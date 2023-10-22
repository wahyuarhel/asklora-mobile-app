import 'package:json_annotation/json_annotation.dart';

part 'user_journey_request.g.dart';

@JsonSerializable()
class UserJourneyRequest {
  @JsonKey(name: 'user_journey')
  final String userJourney;
  final String? data;

  const UserJourneyRequest({required this.userJourney, this.data});

  factory UserJourneyRequest.fromJson(Map<String, dynamic> json) =>
      _$UserJourneyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserJourneyRequestToJson(this);
}
