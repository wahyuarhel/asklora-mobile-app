part of 'back_button_interceptor_bloc.dart';

abstract class BackButtonInterceptorEvent extends Equatable {
  const BackButtonInterceptorEvent();

  @override
  List<Object?> get props => [];
}

class InitiateInterceptor extends BackButtonInterceptorEvent {}

class OnPressedBackInterceptor extends BackButtonInterceptorEvent {}

class RemoveInterceptor extends BackButtonInterceptorEvent {}
