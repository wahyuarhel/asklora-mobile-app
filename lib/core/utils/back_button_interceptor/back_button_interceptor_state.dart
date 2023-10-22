part of 'back_button_interceptor_bloc.dart';

abstract class BackButtonInterceptorState extends Equatable {
  const BackButtonInterceptorState();
}

class BackButtonInterceptorInitial extends BackButtonInterceptorState {
  @override
  List<Object> get props => [];
}

class OnPressedBack extends BackButtonInterceptorState {
  @override
  List<Object> get props => [];
}
