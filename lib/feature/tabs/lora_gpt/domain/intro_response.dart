import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'intro_response.g.dart';

@JsonSerializable()
class IntroResponse extends Equatable {
  final dynamic result;
  final String type;

  const IntroResponse(this.result, this.type);

  factory IntroResponse.fromJson(Map<String, dynamic> json) =>
      _$IntroResponseFromJson(json);

  Map<String, dynamic> toJson() => _$IntroResponseToJson(this);

  String getResult() {
    if (result != null) {
      if (result is List<String>) {
        return (result as List<String>).join('\n');
      } else if (result is List<dynamic>) {
        return List<String>.from(result).join('\n');
      } else {
        return result;
      }
    } else {
      return '';
    }
  }

  @override
  List<Object?> get props => [result, type];
}
