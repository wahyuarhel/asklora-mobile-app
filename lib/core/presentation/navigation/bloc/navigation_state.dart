part of 'navigation_bloc.dart';

class NavigationState<T> extends Equatable {
  final T page;
  final bool? lastPage;
  final dynamic arguments;

  const NavigationState(
      {required this.page, this.lastPage = false, this.arguments})
      : super();

  @override
  List<Object?> get props => [page, lastPage, arguments];

  NavigationState<T> copyWith({
    T? page,
    bool? lastPage,
    dynamic arguments,
  }) {
    return NavigationState(
      page: page ?? this.page,
      lastPage: lastPage ?? this.lastPage,
      arguments: arguments ?? this.arguments,
    );
  }
}
