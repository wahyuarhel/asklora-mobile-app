part of 'tutorial_bloc.dart';

abstract class TutorialEvent extends Equatable {
  const TutorialEvent();

  @override
  List<Object> get props => [];
}

class InitiateBotDetailTutorial extends TutorialEvent {}

class InitiateBotRecommendationTutorial extends TutorialEvent {}

class InitiateTradeSummaryTutorial extends TutorialEvent {}

class BotDetailTutorialFinished extends TutorialEvent {}

class BotRecommendationTutorialFinished extends TutorialEvent {}

class TradeSummaryTutorialFinished extends TutorialEvent {}
