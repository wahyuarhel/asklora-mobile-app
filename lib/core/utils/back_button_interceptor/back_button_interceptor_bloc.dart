import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'back_button_interceptor_event.dart';

part 'back_button_interceptor_state.dart';

class BackButtonInterceptorBloc
    extends Bloc<BackButtonInterceptorEvent, BackButtonInterceptorState> {
  BackButtonInterceptorBloc() : super(BackButtonInterceptorInitial()) {
    on<InitiateInterceptor>(_onInitiateInterceptor);
    on<RemoveInterceptor>(_onRemoveInterceptor);
    on<OnPressedBackInterceptor>(_onPressedBackInterceptor);
  }

  void _onInitiateInterceptor(
      InitiateInterceptor event, Emitter<BackButtonInterceptorState> emit) {
    BackButtonInterceptor.add(interceptor);
  }

  void _onPressedBackInterceptor(OnPressedBackInterceptor event,
      Emitter<BackButtonInterceptorState> emit) {
    emit(OnPressedBack());
    emit(BackButtonInterceptorInitial());
  }

  void _onRemoveInterceptor(
      RemoveInterceptor event, Emitter<BackButtonInterceptorState> emit) {
    BackButtonInterceptor.removeAll();
  }

  bool interceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    ///this will check if some interceptor already triggered (last interceptor being added)
    ///then will stop this interceptor being called
    ///basically if this is not the latest interceptor then it will skip intercepting
    if (stopDefaultButtonEvent) {
      return false;
    } else {
      add(OnPressedBackInterceptor());
      return true;
    }
  }

  @override
  Future<void> close() {
    BackButtonInterceptor.remove(interceptor);
    return super.close();
  }
}
