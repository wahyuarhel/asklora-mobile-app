part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent() : super();

  @override
  List<Object> get props => [];
}

class PasswordChanged extends ChangePasswordEvent {
  final String password;

  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class NewPasswordChanged extends ChangePasswordEvent {
  final String newPassword;

  const NewPasswordChanged(this.newPassword);

  @override
  List<Object> get props => [newPassword];
}

class ConfirmNewPasswordChanged extends ChangePasswordEvent {
  final String confirmNewPassword;

  const ConfirmNewPasswordChanged(this.confirmNewPassword);

  @override
  List<Object> get props => [confirmNewPassword];
}

class ChangePasswordSubmitted extends ChangePasswordEvent {}
