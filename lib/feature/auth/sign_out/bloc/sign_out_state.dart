part of 'sign_out_bloc.dart';

class SignOutState extends Equatable {
  final BaseResponse response;

  const SignOutState({this.response = const BaseResponse()}) : super();

  @override
  List<Object> get props => [response];

  SignOutState copyWith({
    BaseResponse? response,
  }) {
    return SignOutState(response: response ?? this.response);
  }
}
