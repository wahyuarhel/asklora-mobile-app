part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent() : super();

  @override
  List<Object> get props => [];
}

class ForgotPasswordEmailChanged extends ForgotPasswordEvent {
  const ForgotPasswordEmailChanged(this.email) : super();

  final String email;

  @override
  List<Object> get props => [email];
}

class ForgotPasswordSubmitted extends ForgotPasswordEvent {
  const ForgotPasswordSubmitted();

  @override
  List<Object> get props => [];
}

class StartListenOnDeeplink extends ForgotPasswordEvent {
  const StartListenOnDeeplink();

  @override
  List<Object> get props => [];
}

class DeepLinkValidateSuccess extends ForgotPasswordEvent {
  final Uri uri;

  const DeepLinkValidateSuccess(this.uri);

  @override
  List<Object> get props => [uri];
}

class DeepLinkValidateFailed extends ForgotPasswordEvent {
  const DeepLinkValidateFailed();

  @override
  List<Object> get props => [];
}
