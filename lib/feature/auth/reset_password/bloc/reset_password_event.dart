part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent() : super();

  @override
  List<Object> get props => [];
}

class ResetPasswordPasswordChanged extends ResetPasswordEvent {
  const ResetPasswordPasswordChanged(this.password) : super();

  final String password;

  @override
  List<Object> get props => [password];
}

class ResetPasswordConfirmPasswordChanged extends ResetPasswordEvent {
  const ResetPasswordConfirmPasswordChanged(this.confirmPassword) : super();

  final String confirmPassword;

  @override
  List<Object> get props => [confirmPassword];
}

class ResetPasswordSubmitted extends ResetPasswordEvent {
  final String resetPasswordToken;
  const ResetPasswordSubmitted(this.resetPasswordToken) : super();

  @override
  List<Object> get props => [resetPasswordToken];
}
