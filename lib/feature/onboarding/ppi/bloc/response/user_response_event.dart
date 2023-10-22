part of 'user_response_bloc.dart';

abstract class UserResponseEvent extends Equatable {
  const UserResponseEvent();
}

class InitiateUserResponse extends UserResponseEvent {
  @override
  List<Object?> get props => [];
}

class SendResponse extends UserResponseEvent {
  final PpiSelectionRequest ppiUserResponseRequest;

  @override
  List<Object?> get props => [ppiUserResponseRequest];

  const SendResponse(this.ppiUserResponseRequest);
}

class ReSendResponse extends UserResponseEvent {
  const ReSendResponse();

  @override
  List<Object?> get props => [];
}

class SaveUserResponse extends UserResponseEvent {
  final Question question;
  final String selectedAnswer;

  const SaveUserResponse(this.question, this.selectedAnswer);

  @override
  List<Object?> get props => [question, selectedAnswer];
}

class SaveOmniSearchResponse extends UserResponseEvent {
  final List<String> cachedSelectedChoices;
  final List<String> cachedDefaultChoices;

  const SaveOmniSearchResponse(
      this.cachedSelectedChoices, this.cachedDefaultChoices);

  @override
  List<Object?> get props => [cachedSelectedChoices, cachedDefaultChoices];
}

class SendBulkResponse extends UserResponseEvent {
  @override
  List<Object?> get props => [DateTime.now().millisecondsSinceEpoch];
}

class CalculateScore extends UserResponseEvent {
  @override
  List<Object?> get props => [DateTime.now().millisecondsSinceEpoch];
}

class SkipResponse extends UserResponseEvent {
  @override
  List<Object?> get props => [];

  const SkipResponse();
}

class UpdatePpiUserResponse extends UserResponseEvent {
  final PpiUserResponse ppiUserResponse;

  @override
  List<Object?> get props => [ppiUserResponse];

  const UpdatePpiUserResponse(this.ppiUserResponse);
}

class ResetState extends UserResponseEvent {
  final bool wholeState;

  @override
  List<Object?> get props => [];

  const ResetState({this.wholeState = true});
}
