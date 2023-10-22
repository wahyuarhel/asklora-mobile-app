import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/base_response.dart';
import '../../../../core/utils/extensions.dart';
import '../../repository/auth_repository.dart';
import '../domain/reset_password_response.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const ResetPasswordState()) {
    on<ResetPasswordPasswordChanged>(_onPasswordChanged);
    on<ResetPasswordConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<ResetPasswordSubmitted>(_onResetPasswordSubmitted);
  }

  final AuthRepository _authRepository;

  void _onPasswordChanged(
    ResetPasswordPasswordChanged event,
    Emitter<ResetPasswordState> emit,
  ) {
    emit(
      state.copyWith(
          password: event.password,
          passwordValidationError:
              (event.password.isValidPassword() || event.password.isEmpty)
                  ? PasswordValidationError.none
                  : PasswordValidationError.passwordValidationError,
          confirmPasswordError: (state.confirmPassword.isValidPassword() &&
                  state.confirmPassword != event.password)
              ? PasswordValidationError.passwordDoesNotMatchError
              : PasswordValidationError.none),
    );
  }

  void _onConfirmPasswordChanged(
    ResetPasswordConfirmPasswordChanged event,
    Emitter<ResetPasswordState> emit,
  ) {
    emit(
      state.copyWith(
        confirmPassword: event.confirmPassword,
        confirmPasswordError: ((event.confirmPassword.isValidPassword() &&
                    state.password == event.confirmPassword) ||
                event.confirmPassword.isEmpty)
            ? PasswordValidationError.none
            : event.confirmPassword != state.password
                ? PasswordValidationError.passwordDoesNotMatchError
                : PasswordValidationError.none,
      ),
    );
  }

  void _onResetPasswordSubmitted(
      ResetPasswordSubmitted event, Emitter<ResetPasswordState> emit) async {
    emit(state.copyWith(response: BaseResponse.loading()));
    var data = await _authRepository.resetPassword(
        token: event.resetPasswordToken,
        password: state.password,
        confirmPassword: state.confirmPassword);

    emit(state.copyWith(response: data));
  }
}
