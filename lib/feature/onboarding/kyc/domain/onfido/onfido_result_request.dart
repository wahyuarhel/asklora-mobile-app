import 'package:json_annotation/json_annotation.dart';

part 'onfido_result_request.g.dart';

enum Reason { notStarted, userExited, sdkError, userCompleted }

extension Type on Reason {
  String get value {
    switch (this) {
      case Reason.notStarted:
        return 'NOT_STARTED';
      case Reason.userExited:
        return 'USER_EXITED';
      case Reason.sdkError:
        return 'SDK_ERROR';
      case Reason.userCompleted:
        return 'USER_COMPLETED';
      default:
        return '';
    }
  }
}

@JsonSerializable()
class OnfidoResultRequest {
  final String token;
  final String reason;
  final String outcome;

  OnfidoResultRequest(this.token, this.reason, this.outcome);

  Map<String, dynamic> toJson() => _$OnfidoResultRequestToJson(this);
}
