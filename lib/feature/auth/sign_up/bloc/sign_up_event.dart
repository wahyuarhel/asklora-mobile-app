part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent() : super();

  @override
  List<Object> get props => [];
}

class SignUpUsernameChanged extends SignUpEvent {
  const SignUpUsernameChanged(this.username) : super();

  final String username;

  @override
  List<Object> get props => [username];
}

class SignUpPasswordChanged extends SignUpEvent {
  const SignUpPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class SignUpSubmitted extends SignUpEvent {
  const SignUpSubmitted();

  @override
  List<Object> get props => [];
}
