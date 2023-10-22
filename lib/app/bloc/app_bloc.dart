import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/domain/token/repository/token_repository.dart';
import '../../core/presentation/we_create/localization_toggle_button/localization_toggle_button.dart';
import '../../core/utils/build_configs/build_config.dart';
import '../../core/utils/storage/secure_storage.dart';
import '../../core/utils/storage/shared_preference.dart';
import '../../core/utils/storage/storage_keys.dart';
import '../../feature/backdoor/domain/backdoor_repository.dart';
import '../repository/user_journey_repository.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final TokenRepository _tokenRepository;
  final SharedPreference _sharedPreference;
  final SecureStorage _secureStorage;
  final UserJourneyRepository _userJourneyRepository;

  AppBloc(
      {required TokenRepository tokenRepository,
      required UserJourneyRepository userJourneyRepository,
      required SharedPreference sharedPreference,
      required SecureStorage secureStorage})
      : _tokenRepository = tokenRepository,
        _userJourneyRepository = userJourneyRepository,
        _sharedPreference = sharedPreference,
        _secureStorage = secureStorage,
        super(const AppState.unknown()) {
    on<AppLaunched>(_onAppLaunched);
    on<AppLanguageChangeEvent>(_onAppLanguageChangeEvent);
    on<SaveUserJourney>(_onSaveUserJourney);
    on<GetUserJourneyFromLocal>(_onGetUserJourneyFromLocal);
  }

  void _onAppLaunched(AppLaunched event, Emitter<AppState> emit) async {
    if (Environment().config is DevConfig) {
      final backDoorBaseUrl = await BackdoorRepository().getBaseUrl();
      var config = Environment().config;
      (config as DevConfig).backDoorBaseUrl =
          (backDoorBaseUrl == null || backDoorBaseUrl.isEmpty)
              ? null
              : backDoorBaseUrl;
    }

    final isAppFreshInstall =
        await _sharedPreference.readBoolData(StorageKeys.sfFreshInstall) ??
            true;
    if (isAppFreshInstall) {
      await _secureStorage.deleteAllData();
      await _tokenRepository.deleteAll();
      await _sharedPreference.writeBoolData(StorageKeys.sfFreshInstall, false);
      await _sharedPreference.writeBoolData(
          StorageKeys.sfAiWelcomeScreen, false);
    }

    bool isTokenValid = await _tokenRepository.isTokenValid();
    LocaleType localeType = LocaleType.findByLanguageCode(
        await _sharedPreference.readData(StorageKeys.sfKeyLocalisationData));
    if (isTokenValid) {
      var userJourney = await _userJourneyRepository.getUserJourney();
      emit(AppState.authenticated(
          userJourney: userJourney ?? UserJourney.investmentStyle,
          localeType: localeType));
    } else {
      await _tokenRepository.deleteAll();
      await _sharedPreference.deleteAllDataExcept([
        StorageKeys.sfKeyLocalisationData,
        StorageKeys.sfKeyInvestmentStyleState,
        StorageKeys.sfKeyBotDetailsTutorial,
        StorageKeys.sfKeyBotRecommendationTutorial,
        StorageKeys.sfKeyTradeSummaryTutorial,
      ]);
      await _secureStorage.deleteAllData();
      emit(AppState.unauthenticated(localeType: localeType));
    }
  }

  void _onAppLanguageChangeEvent(
      AppLanguageChangeEvent event, Emitter<AppState> emit) async {
    await _sharedPreference.writeData(
        StorageKeys.sfKeyLocalisationData, event.localeType.languageCode);
    emit(state.copyWith(
        locale: event.localeType, userJourney: state.userJourney));
  }

  void _onSaveUserJourney(SaveUserJourney event, Emitter<AppState> emit) async {
    emit(state.copyWith(userJourney: event.userJourney));
    await _userJourneyRepository.saveUserJourney(
        userJourney: event.userJourney, data: event.data);
  }

  void _onGetUserJourneyFromLocal(
      GetUserJourneyFromLocal event, Emitter<AppState> emit) async {
    final data = await _userJourneyRepository.getUserJourneyFromLocal();
    emit(state.copyWith(userJourney: data));
  }
}
