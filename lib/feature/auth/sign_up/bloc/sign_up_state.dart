part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState(
      {this.response = const BaseResponse(),
      this.username = '',
      this.password = '',
      this.isEmailValid = false,
      this.userNameValidation = ValidationCode.empty,
      this.passwordValidation = ValidationCode.empty,
      this.isPasswordValid = false})
      : super();

  final BaseResponse response;
  final String username;
  final String password;
  final ValidationCode userNameValidation;
  final bool isPasswordValid;
  final ValidationCode passwordValidation;
  final bool isEmailValid;

  SignUpState copyWith({
    BaseResponse? response,
    String? username,
    String? password,
    ValidationCode? userNameValidation,
    ValidationCode? passwordValidation,
    bool? isEmailValid,
    bool? isPasswordValid,
  }) {
    return SignUpState(
      response: response ?? this.response,
      username: username ?? this.username,
      password: password ?? this.password,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      userNameValidation: userNameValidation ?? this.userNameValidation,
      passwordValidation: passwordValidation ?? this.passwordValidation,
    );
  }

  @override
  List<Object> get props => [
        response,
        username,
        password,
        isEmailValid,
        isPasswordValid,
        userNameValidation,
        passwordValidation,
      ];
}
