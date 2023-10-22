import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_event.dart';

part 'navigation_state.dart';

class NavigationBloc<T> extends Bloc<NavigationEvent<T>, NavigationState<T>> {
  NavigationBloc(T initialPage)
      : _initialPage = initialPage,
        super(NavigationState(page: initialPage)) {
    on<PageChanged<T>>(_onPageChanged);
    on<PageChangedReplacement<T>>(_onPageChangedReplacement);
    on<PageChangedRemoveUntil<T>>(_onPageChangedRemoveUntil);
    on<PageChangedRemoveAllRoute<T>>(_onPageChangedRemoveAllRoute);
    on<PagePop<T>>(_onPagePop);
    _savedPages = [_initialPage];
  }

  final T _initialPage;
  late List<T> _savedPages;

  void _onPageChanged(PageChanged event, Emitter<NavigationState> emit) {
    _savedPages.add(event.page);
    emit(state.copyWith(page: event.page, arguments: event.arguments));
  }

  void _onPageChangedReplacement(
      PageChangedReplacement event, Emitter<NavigationState> emit) {
    _savedPages.removeLast();
    _savedPages.add(event.page);
    emit(state.copyWith(page: event.page));
  }

  void _onPageChangedRemoveUntil(
      PageChangedRemoveUntil event, Emitter<NavigationState> emit) {
    int index = _savedPages.lastIndexOf(event.removeUntil);
    if (index > -1) {
      _savedPages.removeRange(index + 1, _savedPages.length);
    } else {
      _savedPages.removeRange(0, _savedPages.length);
    }
    _savedPages.add(event.page);
    emit(state.copyWith(page: event.page));
  }

  void _onPageChangedRemoveAllRoute(
      PageChangedRemoveAllRoute event, Emitter<NavigationState> emit) {
    _savedPages.clear();
    _savedPages.add(event.page);
    emit(state.copyWith(page: event.page));
  }

  void _onPagePop(PagePop event, Emitter<NavigationState> emit) {
    _savedPages.removeLast();
    if (_savedPages.isNotEmpty) {
      emit(state.copyWith(page: _savedPages.last, lastPage: false));
    } else {
      emit(state.copyWith(lastPage: true));
    }
  }
}
