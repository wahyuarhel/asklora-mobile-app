part of 'sign_out_bloc.dart';

abstract class SignOutEvent extends Equatable {
  const SignOutEvent() : super();

  @override
  List<Object?> get props => [];
}

class SignOutSubmitted extends SignOutEvent {
  const SignOutSubmitted() : super();

  @override
  List<Object> get props => [];
}
