import 'package:asklora_mobile_app/app/bloc/app_bloc.dart';
import 'package:asklora_mobile_app/app/repository/user_journey_repository.dart';
import 'package:asklora_mobile_app/core/domain/token/repository/token_repository.dart';
import 'package:asklora_mobile_app/core/domain/token/token_api_client.dart';
import 'package:asklora_mobile_app/core/presentation/we_create/localization_toggle_button/localization_toggle_button.dart';
import 'package:asklora_mobile_app/core/utils/build_configs/build_config.dart';
import 'package:asklora_mobile_app/core/utils/storage/storage_keys.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../sign_out/sign_out_bloc_test.mocks.dart';
import 'app_bloc_test.mocks.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {}

@GenerateMocks([TokenRepository])
@GenerateMocks([UserJourneyRepository])
@GenerateMocks([TokenApiClient])
// @GenerateMocks([SecureStorage])
void main() async {
  group('App Bloc Tests', () {
    late AppBloc appBloc;
    late MockTokenRepository tokenRepository;
    late MockSharedPreference sharedPreference;
    late MockSecureStorage secureStorage;
    late MockUserJourneyRepository userJourneyRepository;

    setUpAll(() async {
      tokenRepository = MockTokenRepository();
      sharedPreference = MockSharedPreference();
      secureStorage = MockSecureStorage();
      userJourneyRepository = MockUserJourneyRepository();
    });

    setUp(() async {
      /// Skip the Backdoor block
      Environment().config = StagingConfig();

      appBloc = AppBloc(
          tokenRepository: tokenRepository,
          userJourneyRepository: userJourneyRepository,
          secureStorage: secureStorage,
          sharedPreference: sharedPreference);
    });

    test('App Bloc init state is should be `unknown`', () {
      expect(appBloc.state, const AppState.unknown());
    });

    blocTest<AppBloc, AppState>(
      'emits `AppState.authenticated` and User Journey = kyc WHEN'
      'Token is valid and User Journey = kyc',
      build: () {
        when(sharedPreference.readBoolData(StorageKeys.sfFreshInstall))
            .thenAnswer((_) => Future.value(false));
        when(tokenRepository.isTokenValid())
            .thenAnswer((_) => Future.value(true));
        when(userJourneyRepository.getUserJourney())
            .thenAnswer((_) => Future.value(UserJourney.kyc));
        when(sharedPreference.readData(StorageKeys.sfKeyLocalisationData))
            .thenAnswer((_) => Future.value('eng'));
        return appBloc;
      },
      act: (bloc) => bloc.add(AppLaunched()),
      expect: () => {
        AppState.authenticated(
            userJourney: UserJourney.kyc,
            localeType: LocaleType.findByLanguageCode('eng'))
      },
    );

    blocTest<AppBloc, AppState>(
      'emits `AppState.unauthenticated` WHEN '
      'Token is not valid or expired',
      build: () {
        when(secureStorage.readBoolData(StorageKeys.sfFreshInstall))
            .thenAnswer((_) => Future.value(true));
        when(tokenRepository.isTokenValid())
            .thenAnswer((_) => Future.value(false));
        when(userJourneyRepository.getUserJourney())
            .thenAnswer((_) => Future.value(UserJourney.privacy));
        when(sharedPreference.readData(StorageKeys.sfKeyLocalisationData))
            .thenAnswer((_) => Future.value('eng'));
        return appBloc;
      },
      act: (bloc) => bloc.add(AppLaunched()),
      expect: () => {
        AppState.unauthenticated(
            userJourney: UserJourney.privacy,
            localeType: LocaleType.findByLanguageCode('eng'))
      },
    );

    tearDown(() => {appBloc.close()});
  });
}
