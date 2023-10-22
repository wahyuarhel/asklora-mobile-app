import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/remote/base_api_client.dart';
import '../../../../core/domain/validation_enum.dart';
import '../../../../core/domain/base_response.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/storage/shared_preference.dart';
import '../../../../core/utils/storage/storage_keys.dart';
import '../repository/sign_up_repository.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(
      {required SignUpRepository signUpRepository,
      required SharedPreference sharedPreference})
      : _signUpRepository = signUpRepository,
        _sharedPreference = sharedPreference,
        super(const SignUpState()) {
    on<SignUpUsernameChanged>(_onUsernameChanged);
    on<SignUpPasswordChanged>(_onPasswordChanged);
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  final SignUpRepository _signUpRepository;
  final SharedPreference _sharedPreference;

  void _onUsernameChanged(
    SignUpUsernameChanged event,
    Emitter<SignUpState> emit,
  ) {
    emit(
      state.copyWith(
          response: BaseResponse.unknown(),
          username: event.username,
          isEmailValid: event.username.isValidEmail(),
          userNameValidation:
              (event.username.isValidEmail() || event.username.isEmpty)
                  ? ValidationCode.empty
                  : ValidationCode.enterValidEmail),
    );
  }

  void _onPasswordChanged(
    SignUpPasswordChanged event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(
        response: BaseResponse.unknown(),
        password: event.password,
        passwordValidation:
            (event.password.isValidPassword() || event.password.isEmpty)
                ? ValidationCode.empty
                : ValidationCode.enterValidPassword,
        isPasswordValid: event.password.isValidPassword()));
  }

  void _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    try {
      emit(state.copyWith(response: BaseResponse.loading()));

      final tempName =
          await _sharedPreference.readData(StorageKeys.sfKeyPpiAccountId);

      final data = await _signUpRepository.signUp(
          email: state.username, password: state.password, username: tempName!);

      await _sharedPreference.writeData(StorageKeys.sfKeyEmail, state.username);
      await _sharedPreference.writeBoolData(StorageKeys.sfFreshInstall, false);

      emit(state.copyWith(response: data));
    } on AskloraApiClientException catch (e) {
      emit(state.copyWith(
          response: BaseResponse.error(validationCode: e.askloraError.type)));
    } catch (e) {
      emit(state.copyWith(response: BaseResponse.error()));
    }
  }
}
