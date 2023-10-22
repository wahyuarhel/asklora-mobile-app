import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'user_journey_response.g.dart';

@JsonSerializable()
class UserJourneyResponse extends Equatable {
  final String? uid;
  final String? updated;
  @JsonKey(name: 'user_journey')
  final String? userJourney;
  final String? data;
  final int? user;
  final String? detail;

  const UserJourneyResponse(this.uid, this.updated, this.userJourney, this.data,
      this.user, this.detail);

  factory UserJourneyResponse.fromJson(Map<String, dynamic> json) =>
      _$UserJourneyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserJourneyResponseToJson(this);

  @override
  List<Object?> get props => [uid, updated, userJourney, data, user];
}
