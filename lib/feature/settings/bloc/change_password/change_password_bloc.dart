import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/base_response.dart';
import '../../../../core/utils/extensions.dart';
import '../../../auth/repository/auth_repository.dart';
import '../../util/setting_utils.dart';

part 'change_password_event.dart';

part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final AuthRepository _authRepository;

  ChangePasswordBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const ChangePasswordState()) {
    on<PasswordChanged>(_onPasswordChanged);
    on<NewPasswordChanged>(_onNewPasswordChanged);
    on<ConfirmNewPasswordChanged>(_onConfirmNewPasswordChanged);
    on<ChangePasswordSubmitted>(_onChangePasswordSubmitted);
  }

  _onPasswordChanged(PasswordChanged event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(
        password: event.password,
        newPasswordErrorType:
            event.password == state.newPassword && state.newPassword.isNotEmpty
                ? PasswordErrorType.oldPasswordSameWithNewPassword
                : PasswordErrorType.validPassword));
  }

  _onNewPasswordChanged(
      NewPasswordChanged event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(
        newPassword: event.newPassword,
        newPasswordErrorType:
            (!event.newPassword.isValidPassword() || event.newPassword.isEmpty)
                ? PasswordErrorType.invalidPassword
                : event.newPassword == state.password
                    ? PasswordErrorType.oldPasswordSameWithNewPassword
                    : PasswordErrorType.validPassword,
        confirmNewPasswordErrorType:
            event.newPassword != state.confirmNewPassword &&
                    state.confirmNewPassword.isNotEmpty
                ? PasswordErrorType.doesNotMatch
                : PasswordErrorType.validPassword));
  }

  _onConfirmNewPasswordChanged(
      ConfirmNewPasswordChanged event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(
      confirmNewPassword: event.confirmNewPassword,
      confirmNewPasswordErrorType: event.confirmNewPassword != state.newPassword
          ? PasswordErrorType.doesNotMatch
          : PasswordErrorType.validPassword,
    ));
  }

  _onChangePasswordSubmitted(
      ChangePasswordSubmitted event, Emitter<ChangePasswordState> emit) async {
    emit(state.copyWith(response: BaseResponse.loading()));
    var response = await _authRepository.changePassword(
        password: state.password,
        newPassword: state.newPassword,
        confirmNewPassword: state.confirmNewPassword);

    emit(state.copyWith(response: response));
  }
}
