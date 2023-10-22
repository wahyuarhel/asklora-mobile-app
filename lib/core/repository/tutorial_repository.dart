import '../utils/storage/shared_preference.dart';
import '../utils/storage/storage_keys.dart';

class TutorialRepository {
  final SharedPreference _sharedPreference = SharedPreference();

  Future<bool> saveBotDetailTutorialState(bool tutorialState) async {
    await _sharedPreference.writeBoolData(
        StorageKeys.sfKeyBotDetailsTutorial, tutorialState);
    return tutorialState;
  }

  Future<bool> saveBotRecommendationTutorialState(bool tutorialState) async {
    await _sharedPreference.writeBoolData(
        StorageKeys.sfKeyBotRecommendationTutorial, tutorialState);
    return tutorialState;
  }

  Future<bool> saveTradeSummaryTutorialState(bool tutorialState) async {
    await _sharedPreference.writeBoolData(
        StorageKeys.sfKeyTradeSummaryTutorial, tutorialState);
    return tutorialState;
  }

  Future<bool> fetchBotDetailTutorialState() async {
    bool? response = await _sharedPreference
        .readBoolData(StorageKeys.sfKeyBotDetailsTutorial);
    return response ?? true;
  }

  Future<bool> fetchBotRecommendationTutorialState() async {
    bool? response = await _sharedPreference
        .readBoolData(StorageKeys.sfKeyBotRecommendationTutorial);
    return response ?? true;
  }

  Future<bool> fetchTradeSummaryTutorialState() async {
    bool? response = await _sharedPreference
        .readBoolData(StorageKeys.sfKeyTradeSummaryTutorial);
    return response ?? true;
  }

  Future<bool> setTradeSummaryTutorialFinished() async {
    bool response = await _sharedPreference.writeBoolData(
        StorageKeys.sfKeyTradeSummaryTutorial, false);
    return response;
  }
}
