part of 'navigation_bloc.dart';

abstract class NavigationEvent<T> extends Equatable {
  const NavigationEvent() : super();

  @override
  List<Object?> get props => [];
}

class PageChanged<T> extends NavigationEvent<T> {
  final T page;
  final dynamic arguments;

  const PageChanged(this.page, {this.arguments}) : super();

  @override
  List<Object?> get props => [page];
}

class PageChangedReplacement<T> extends NavigationEvent<T> {
  final T page;

  const PageChangedReplacement(this.page) : super();

  @override
  List<Object?> get props => [page];
}

class PageChangedRemoveUntil<T> extends NavigationEvent<T> {
  final T page;
  final T removeUntil;

  const PageChangedRemoveUntil(this.page, this.removeUntil) : super();

  @override
  List<Object?> get props => [page, removeUntil];
}

class PageChangedRemoveAllRoute<T> extends NavigationEvent<T> {
  final T page;

  const PageChangedRemoveAllRoute(this.page) : super();

  @override
  List<Object?> get props => [page];
}

class PagePop<T> extends NavigationEvent<T> {
  const PagePop() : super();

  @override
  List<Object?> get props => [];
}
