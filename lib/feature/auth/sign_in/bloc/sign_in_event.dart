part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent() : super();

  @override
  List<Object?> get props => [];
}

class SignInEmailChanged extends SignInEvent {
  final String emailAddress;
  const SignInEmailChanged(this.emailAddress) : super();

  @override
  List<Object> get props => [emailAddress];
}

class SignInPasswordChanged extends SignInEvent {
  final String password;
  const SignInPasswordChanged(this.password) : super();

  @override
  List<Object> get props => [password];
}

class SignInSubmitted extends SignInEvent {
  const SignInSubmitted() : super();

  @override
  List<Object> get props => [];
}

class SignInWithOtp extends SignInEvent {
  final String otp;
  final String email;
  final String password;
  const SignInWithOtp(this.otp, this.email, this.password) : super();

  @override
  List<Object> get props => [otp, email, password];
}
