part of 'isq_onboarding_bloc.dart';

abstract class IsqOnBoardingEvent extends Equatable {
  const IsqOnBoardingEvent() : super();

  @override
  List<Object?> get props => [];
}

class GetAiWelcomeScreenStatus extends IsqOnBoardingEvent {
  const GetAiWelcomeScreenStatus();
}

class UpdateAiWelcomeScreenStatus extends IsqOnBoardingEvent {
  final bool aiWelcomeScreenStatus;
  const UpdateAiWelcomeScreenStatus(this.aiWelcomeScreenStatus);
}

class BackButtonClicked extends IsqOnBoardingEvent {}
