part of 'reset_password_bloc.dart';

enum PasswordValidationError {
  passwordValidationError,
  passwordDoesNotMatchError,
  none
}

class ResetPasswordState extends Equatable {
  const ResetPasswordState({
    this.response = const BaseResponse(),
    this.password = '',
    this.confirmPassword = '',
    this.passwordValidationError = PasswordValidationError.none,
    this.confirmPasswordError = PasswordValidationError.none,
  }) : super();

  final BaseResponse<ResetPasswordResponse> response;
  final String password;
  final String confirmPassword;
  final PasswordValidationError passwordValidationError;
  final PasswordValidationError confirmPasswordError;

  ResetPasswordState copyWith({
    BaseResponse<ResetPasswordResponse>? response,
    String? token,
    String? password,
    String? confirmPassword,
    bool? isPasswordValid,
    bool? isConfirmPasswordValid,
    PasswordValidationError? passwordValidationError,
    PasswordValidationError? confirmPasswordError,
  }) {
    return ResetPasswordState(
      response: response ?? this.response,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      passwordValidationError:
          passwordValidationError ?? this.passwordValidationError,
      confirmPasswordError: confirmPasswordError ?? this.confirmPasswordError,
    );
  }

  @override
  List<Object> get props {
    return [
      response,
      password,
      confirmPassword,
      passwordValidationError,
      confirmPasswordError
    ];
  }

  bool disableSubmitButton() =>
      !(confirmPasswordError == PasswordValidationError.none &&
          passwordValidationError == PasswordValidationError.none &&
          password.isValidPassword() &&
          confirmPassword.isValidPassword());
}
