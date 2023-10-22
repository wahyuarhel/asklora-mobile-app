part of 'isq_onboarding_bloc.dart';

enum IsqOnBoardingBackState { none, openConfirmation, delayed, closeApp }

class IsqOnBoardingState extends Equatable {
  final bool aiWelcomeScreenStatus;
  final ResponseState isqOnboardingResponseState;
  final IsqOnBoardingBackState isqOnBoardingBackState;

  const IsqOnBoardingState(
      {this.aiWelcomeScreenStatus = false,
      this.isqOnboardingResponseState = ResponseState.unknown,
      this.isqOnBoardingBackState = IsqOnBoardingBackState.none})
      : super();

  IsqOnBoardingState copyWith(
      {bool? aiWelcomeScreenStatus,
      ResponseState? isqOnboardingResponseState,
      IsqOnBoardingBackState? isqOnBoardingBackState}) {
    return IsqOnBoardingState(
        aiWelcomeScreenStatus:
            aiWelcomeScreenStatus ?? this.aiWelcomeScreenStatus,
        isqOnboardingResponseState:
            isqOnboardingResponseState ?? this.isqOnboardingResponseState,
        isqOnBoardingBackState:
            isqOnBoardingBackState ?? this.isqOnBoardingBackState);
  }

  @override
  List<Object> get props => [
        aiWelcomeScreenStatus,
        isqOnboardingResponseState,
        isqOnBoardingBackState
      ];
}
