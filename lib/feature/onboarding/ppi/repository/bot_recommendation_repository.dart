import '../domain/ppi_user_response.dart';

class BotRecommendationRepository {
  static BotRecommendationRepository? _instance;

  factory BotRecommendationRepository() =>
      _instance ??= BotRecommendationRepository._();

  BotRecommendationRepository._();

  List<RecommendedBot> recommendedBots = [];

  set setRecommendedBots(List<RecommendedBot> recommendedBots) {
    this.recommendedBots = recommendedBots;
  }

  List<RecommendedBot> get getRecommendedBots {
    return recommendedBots;
  }
}
