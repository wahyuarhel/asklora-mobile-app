part of 'email_activation_bloc.dart';

enum DeeplinkStatus { inProgress, success, failed }

class EmailActivationState extends Equatable {
  final BaseResponse response;
  final DeeplinkStatus deeplinkStatus;

  const EmailActivationState(
      {this.response = const BaseResponse(),
      this.deeplinkStatus = DeeplinkStatus.inProgress});

  @override
  List<Object?> get props => [response];

  EmailActivationState copyWith({
    BaseResponse? response,
    DeeplinkStatus? deeplinkStatus,
  }) {
    return EmailActivationState(
      response: response ?? this.response,
      deeplinkStatus: deeplinkStatus ?? this.deeplinkStatus,
    );
  }
}
