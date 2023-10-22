part of 'home_screen_bloc.dart';

class HomeScreenState extends Equatable {
  final BaseResponse<SnapShot> response;
  const HomeScreenState({
    this.response = const BaseResponse(),
  });

  @override
  List<Object> get props => [response];

  HomeScreenState copyWith({
    BaseResponse<SnapShot>? response,
  }) {
    return HomeScreenState(
      response: response ?? this.response,
    );
  }
}
