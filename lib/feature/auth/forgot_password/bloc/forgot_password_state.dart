part of 'forgot_password_bloc.dart';

enum DeeplinkStatus { inProgress, success, failed }

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState(
      {this.response = const BaseResponse(),
      this.deeplinkStatus = DeeplinkStatus.inProgress,
      this.email = '',
      this.emailValidation = ValidationCode.empty,
      this.resetPasswordToken = ''})
      : super();

  final BaseResponse response;
  final DeeplinkStatus deeplinkStatus;
  final String email;
  final ValidationCode emailValidation;
  final String resetPasswordToken;

  ForgotPasswordState copyWith(
      {BaseResponse? response,
      DeeplinkStatus? deeplinkStatus,
      String? email,
      ValidationCode? emailValidation,
      String? resetPasswordToken}) {
    return ForgotPasswordState(
      response: response ?? this.response,
      deeplinkStatus: deeplinkStatus ?? this.deeplinkStatus,
      email: email ?? this.email,
      emailValidation: emailValidation ?? this.emailValidation,
      resetPasswordToken: resetPasswordToken ?? this.resetPasswordToken,
    );
  }

  @override
  List<Object> get props {
    return [
      response,
      deeplinkStatus,
      email,
      // emailErrorText,
      resetPasswordToken
    ];
  }
}
