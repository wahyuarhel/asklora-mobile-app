part of 'email_activation_bloc.dart';

abstract class EmailActivationEvent extends Equatable {
  const EmailActivationEvent();
}

class ResendEmailActivationLink extends EmailActivationEvent {
  final String email;

  const ResendEmailActivationLink(this.email);

  @override
  List<Object> get props => [email];
}

class StartListenOnDeeplink extends EmailActivationEvent {
  const StartListenOnDeeplink();

  @override
  List<Object> get props => [];
}

class DeepLinkValidateSuccess extends EmailActivationEvent {
  final Uri uri;

  const DeepLinkValidateSuccess(this.uri);

  @override
  List<Object> get props => [uri];
}

class DeepLinkValidateFailed extends EmailActivationEvent {
  const DeepLinkValidateFailed();

  @override
  List<Object> get props => [];
}
