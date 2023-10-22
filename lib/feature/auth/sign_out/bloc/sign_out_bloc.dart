import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/base_response.dart';
import '../../../../core/domain/token/repository/repository.dart';
import '../../../../core/utils/storage/secure_storage.dart';
import '../../../../core/utils/storage/shared_preference.dart';
import '../../../../core/utils/storage/storage_keys.dart';
import '../../repository/auth_repository.dart';

part 'sign_out_event.dart';

part 'sign_out_state.dart';

class SignOutBloc extends Bloc<SignOutEvent, SignOutState> {
  SignOutBloc({
    required Repository tokenRepository,
    required AuthRepository authRepository,
    required SharedPreference sharedPreference,
    required SecureStorage secureStorage,
  })  : _tokenRepository = tokenRepository,
        _authRepository = authRepository,
        _sharedPreference = sharedPreference,
        _secureStorage = secureStorage,
        super(const SignOutState()) {
    on<SignOutSubmitted>(_onSignOutSubmitted);
  }

  final Repository _tokenRepository;
  final AuthRepository _authRepository;
  final SharedPreference _sharedPreference;
  final SecureStorage _secureStorage;

  void _onSignOutSubmitted(
    SignOutSubmitted event,
    Emitter<SignOutState> emit,
  ) async {
    try {
      emit(state.copyWith(response: BaseResponse.loading()));
      var isSignedOut = await _authRepository
          .signOut(await _tokenRepository.getRefreshToken());
      if (isSignedOut) {
        await _tokenRepository.deleteAll();
        await _sharedPreference.deleteAllDataExcept([
          StorageKeys.sfKeyLocalisationData,
          StorageKeys.sfKeyInvestmentStyleState,
          StorageKeys.sfKeyBotDetailsTutorial,
          StorageKeys.sfKeyBotRecommendationTutorial,
          StorageKeys.sfKeyTradeSummaryTutorial
        ]);

        await _secureStorage.deleteAllData();
        emit(state.copyWith(
            response: BaseResponse.complete('Sign Out Success')));
      } else {
        emit(state.copyWith(
            response: BaseResponse.error(message: 'Not able to sign-out!')));
      }
    } catch (e) {
      emit(state.copyWith(response: BaseResponse.error()));
    }
  }
}
