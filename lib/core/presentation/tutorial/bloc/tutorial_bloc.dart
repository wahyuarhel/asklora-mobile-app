import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repository/tutorial_repository.dart';

part 'tutorial_event.dart';

part 'tutorial_state.dart';

class TutorialBloc extends Bloc<TutorialEvent, TutorialState> {
  TutorialBloc({required TutorialRepository tutorialRepository})
      : _tutorialRepository = tutorialRepository,
        super(const TutorialState()) {
    on<InitiateBotDetailTutorial>(_onInitiateBotDetailTutorial);
    on<InitiateBotRecommendationTutorial>(_onInitiateBotRecommendationTutorial);
    on<InitiateTradeSummaryTutorial>(_onInitiateTradeSummaryTutorial);
    on<BotDetailTutorialFinished>(_onBotDetailTutorialFinished);
    on<BotRecommendationTutorialFinished>(_onBotRecommendationTutorialFinished);
    on<TradeSummaryTutorialFinished>(_onTradeSummaryTutorialFinished);
  }

  final TutorialRepository _tutorialRepository;

  _onInitiateBotDetailTutorial(
      InitiateBotDetailTutorial event, Emitter<TutorialState> emit) async {
    final bool isBotDetailsTutorial =
        await _tutorialRepository.fetchBotDetailTutorialState();
    emit(state.copyWith(isBotDetailsTutorial: isBotDetailsTutorial));
  }

  _onInitiateBotRecommendationTutorial(InitiateBotRecommendationTutorial event,
      Emitter<TutorialState> emit) async {
    final bool isBotRecommendationTutorial =
        await _tutorialRepository.fetchBotRecommendationTutorialState();
    emit(state.copyWith(
        isBotRecommendationTutorial: isBotRecommendationTutorial));
  }

  _onInitiateTradeSummaryTutorial(
      InitiateTradeSummaryTutorial event, Emitter<TutorialState> emit) async {
    final bool isTradeSummaryTutorial =
        await _tutorialRepository.fetchTradeSummaryTutorialState();
    emit(state.copyWith(isTradeSummaryTutorial: isTradeSummaryTutorial));
  }

  _onBotDetailTutorialFinished(
      BotDetailTutorialFinished event, Emitter<TutorialState> emit) async {
    final bool tutorialState =
        await _tutorialRepository.saveBotDetailTutorialState(false);
    emit(state.copyWith(isBotDetailsTutorial: tutorialState));
  }

  _onBotRecommendationTutorialFinished(BotRecommendationTutorialFinished event,
      Emitter<TutorialState> emit) async {
    final bool tutorialState =
        await _tutorialRepository.saveBotRecommendationTutorialState(false);
    emit(state.copyWith(isBotRecommendationTutorial: tutorialState));
  }

  _onTradeSummaryTutorialFinished(
      TradeSummaryTutorialFinished event, Emitter<TutorialState> emit) async {
    final bool tutorialState =
        await _tutorialRepository.saveTradeSummaryTutorialState(false);
    emit(state.copyWith(isTradeSummaryTutorial: tutorialState));
  }
}
