part of 'change_password_bloc.dart';

class ChangePasswordState extends Equatable {
  final BaseResponse response;
  final String password;
  final String newPassword;
  final PasswordErrorType newPasswordErrorType;
  final String confirmNewPassword;
  final PasswordErrorType confirmNewPasswordErrorType;

  const ChangePasswordState({
    this.response = const BaseResponse(),
    this.password = '',
    this.newPassword = '',
    this.newPasswordErrorType = PasswordErrorType.validPassword,
    this.confirmNewPassword = '',
    this.confirmNewPasswordErrorType = PasswordErrorType.validPassword,
  }) : super();

  ChangePasswordState copyWith({
    BaseResponse? response,
    String? password,
    String? newPassword,
    PasswordErrorType? newPasswordErrorType,
    String? confirmNewPassword,
    PasswordErrorType? confirmNewPasswordErrorType,
  }) {
    return ChangePasswordState(
      response: response ?? this.response,
      password: password ?? this.password,
      newPassword: newPassword ?? this.newPassword,
      newPasswordErrorType: newPasswordErrorType ?? this.newPasswordErrorType,
      confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
      confirmNewPasswordErrorType:
          confirmNewPasswordErrorType ?? this.confirmNewPasswordErrorType,
    );
  }

  @override
  List<Object> get props => [
        response,
        password,
        newPassword,
        newPasswordErrorType,
        confirmNewPassword,
        confirmNewPasswordErrorType,
      ];

  bool disabledSaveButton() {
    if (password.isNotEmpty &&
        newPasswordErrorType == PasswordErrorType.validPassword &&
        confirmNewPasswordErrorType == PasswordErrorType.validPassword &&
        newPassword.isValidPassword() &&
        confirmNewPassword.isValidPassword() &&
        newPassword == confirmNewPassword) {
      return false;
    } else {
      return true;
    }
  }
}
