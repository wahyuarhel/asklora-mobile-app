import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_user_request.g.dart';

@JsonSerializable()
class AddUserRequest extends Equatable {
  final String name;

  @JsonKey(name: 'account_id')
  final String? accountId;

  @JsonKey(name: 'device_id')
  final String deviceId;

  const AddUserRequest(
      {required this.name, this.accountId, required this.deviceId});

  Map<String, dynamic> toJson() => _$AddUserRequestToJson(this);

  factory AddUserRequest.fromJson(Map<String, dynamic> json) =>
      _$AddUserRequestFromJson(json);

  @override
  List<Object> get props => [name, accountId ?? 'accountId', deviceId];
}
