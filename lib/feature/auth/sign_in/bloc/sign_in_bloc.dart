import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/bloc/app_bloc.dart';
import '../../../../app/repository/user_journey_repository.dart';
import '../../../../core/data/remote/base_api_client.dart';
import '../../../../core/domain/base_response.dart';
import '../../../../core/domain/validation_enum.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/storage/shared_preference.dart';
import '../../../../core/utils/storage/storage_keys.dart';
import '../../../onboarding/kyc/domain/get_account/get_account_response.dart';
import '../../../onboarding/kyc/repository/account_repository.dart';
import '../../../onboarding/ppi/domain/ppi_user_response.dart';
import '../../../onboarding/ppi/repository/ppi_response_repository.dart';
import '../../repository/auth_repository.dart';
import '../domain/sign_in_response.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({
    required AuthRepository authRepository,
    required UserJourneyRepository userJourneyRepository,
    required SharedPreference sharedPreference,
    required AccountRepository accountRepository,
    required PpiResponseRepository ppiResponseRepository,
  })  : _authRepository = authRepository,
        _userJourneyRepository = userJourneyRepository,
        _sharedPreference = sharedPreference,
        _accountRepository = accountRepository,
        _ppiResponseRepository = ppiResponseRepository,
        super(const SignInState()) {
    on<SignInEmailChanged>(_onEmailChanged);
    on<SignInPasswordChanged>(_onPasswordChanged);
    on<SignInSubmitted>(_onSignInSubmitted);
    on<SignInWithOtp>(_onSignInWithOtp);
  }

  final AuthRepository _authRepository;
  final AccountRepository _accountRepository;
  final UserJourneyRepository _userJourneyRepository;
  final PpiResponseRepository _ppiResponseRepository;
  final SharedPreference _sharedPreference;

  void _onEmailChanged(SignInEmailChanged event, Emitter<SignInState> emit) {
    emit(state.copyWith(
        response: BaseResponse.unknown(),
        emailAddress: event.emailAddress,
        isEmailValid: event.emailAddress.isValidEmail(),
        emailAddressValidation:
            (event.emailAddress.toLowerCase().isValidEmail() ||
                    event.emailAddress.isEmpty)
                ? ValidationCode.empty
                : ValidationCode.enterValidEmail));
  }

  void _onPasswordChanged(
    SignInPasswordChanged event,
    Emitter<SignInState> emit,
  ) {
    emit(state.copyWith(
      response: BaseResponse.unknown(),
      password: event.password,
    ));
  }

  void _onSignInSubmitted(
    SignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    try {
      emit(state.copyWith(response: BaseResponse.loading()));
      var data = await _authRepository.signIn(
          email: state.emailAddress, password: state.password);

      UserJourney? userJourney;
      final isOtpRequired = data.statusCode == 202;
      if (!isOtpRequired) {
        userJourney = await _userJourneyRepository.getUserJourney();

        GetAccountResponse? getAccountResponse = await _fetchUserProfile();
        if (getAccountResponse != null) {
          var snapshot = await _getUserSnapshot(getAccountResponse.username);
          if (snapshot.state == ResponseState.success) {
            if (userJourney == null) {
              ///user journey null means user activate from different devices
              await _ppiResponseRepository.linkUser(snapshot.data!.id);
              await _userJourneyRepository.saveUserJourney(
                  userJourney: UserJourney.investmentStyle);
              emit(state.copyWith(
                  response: BaseResponse.complete(data.copyWith(
                      userJourney: UserJourney.investmentStyle))));
            } else {
              ///this is normal sign in flow
              await _sharedPreference.writeBoolData(
                  StorageKeys.sfFreshInstall, false);
              emit(state.copyWith(
                  response: BaseResponse.complete(
                      data.copyWith(userJourney: userJourney))));
            }
          } else {
            ///snapshot error should remove storage and emit error
            _authRepository.removeStorageOnSignInFailed();
            emit(state.copyWith(response: BaseResponse.error()));
          }
        } else {
          ///user profile error should remove storage and emit error
          _authRepository.removeStorageOnSignInFailed();
          emit(state.copyWith(response: BaseResponse.error()));
        }
      } else {
        ///this is when user need to input otp
        emit(state.copyWith(
            isOtpRequired: isOtpRequired,
            response: BaseResponse.complete(
                data.copyWith(userJourney: userJourney))));
      }
    } on AskloraApiClientException catch (e) {
      emit(state.copyWith(
          response: BaseResponse.error(validationCode: e.askloraError.type)));
    } catch (e) {
      _authRepository.removeStorageOnSignInFailed();
      emit(state.copyWith(response: BaseResponse.error()));
    }
  }

  void _onSignInWithOtp(
    SignInWithOtp event,
    Emitter<SignInState> emit,
  ) async {
    try {
      emit(state.copyWith(response: BaseResponse.loading()));
      var data = await _authRepository.signInWithOtp(
          otp: event.otp, email: event.email, password: event.password);
      UserJourney? userJourney = await _userJourneyRepository.getUserJourney();

      GetAccountResponse? getAccountResponse = await _fetchUserProfile();
      if (getAccountResponse != null) {
        var snapshot = await _getUserSnapshot(getAccountResponse.username);
        if (snapshot.state == ResponseState.success) {
          await _sharedPreference.writeBoolData(
              StorageKeys.sfFreshInstall, false);
          emit(state.copyWith(
              response: BaseResponse.complete(data.copyWith(
                  userJourney: userJourney ?? UserJourney.investmentStyle))));
        } else {
          ///snapshot error should remove storage and emit error
          _authRepository.removeStorageOnSignInFailed();
          emit(state.copyWith(response: BaseResponse.error()));
        }
      } else {
        ///user profile error should remove storage and emit error
        _authRepository.removeStorageOnSignInFailed();
        emit(state.copyWith(response: BaseResponse.error()));
      }
    } on AskloraApiClientException catch (e) {
      emit(state.copyWith(
          response: BaseResponse.error(validationCode: e.askloraError.type)));
    } catch (e) {
      _authRepository.removeStorageOnSignInFailed();
      emit(state.copyWith(response: BaseResponse.error()));
    }
  }

  Future<GetAccountResponse?> _fetchUserProfile() async {
    final accountInfo = await _accountRepository.getAccount();
    if (accountInfo.state == ResponseState.success) {
      _sharedPreference.writeData(
          StorageKeys.sfKeyEmail, accountInfo.data!.email);
      _sharedPreference.writeData(
          StorageKeys.sfKeyPpiUsername, accountInfo.data!.username);
      return accountInfo.data;
    }
    return null;
  }

  Future<BaseResponse<SnapShot>> _getUserSnapshot(String username) async =>
      await _ppiResponseRepository.getUserSnapShotUserId(username);
}
