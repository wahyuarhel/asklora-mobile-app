part of 'tutorial_bloc.dart';

class TutorialState extends Equatable {
  const TutorialState({
    this.isBotDetailsTutorial = false,
    this.isBotRecommendationTutorial = false,
    this.isTradeSummaryTutorial = false,
  });

  final bool isBotDetailsTutorial;
  final bool isBotRecommendationTutorial;
  final bool isTradeSummaryTutorial;

  @override
  List<Object?> get props {
    return [
      isBotDetailsTutorial,
      isBotRecommendationTutorial,
      isTradeSummaryTutorial,
    ];
  }

  TutorialState copyWith({
    bool? isBotDetailsTutorial,
    bool? isBotRecommendationTutorial,
    bool? isTradeSummaryTutorial,
  }) {
    return TutorialState(
      isBotDetailsTutorial: isBotDetailsTutorial ?? this.isBotDetailsTutorial,
      isBotRecommendationTutorial:
          isBotRecommendationTutorial ?? this.isBotRecommendationTutorial,
      isTradeSummaryTutorial:
          isTradeSummaryTutorial ?? this.isTradeSummaryTutorial,
    );
  }
}
