import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_links/uni_links.dart';

import '../../../../core/data/remote/base_api_client.dart';
import '../../../../core/domain/validation_enum.dart';
import '../../../../core/domain/base_response.dart';
import '../../../../core/utils/extensions.dart';
import '../../repository/auth_repository.dart';

part 'forgot_password_event.dart';

part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const ForgotPasswordState()) {
    on<ForgotPasswordEmailChanged>(_onEmailChanged);
    on<ForgotPasswordSubmitted>(_onForgotPasswordSubmitted);
    on<StartListenOnDeeplink>(_onStartListenOnDeeplink);
    on<DeepLinkValidateSuccess>(_onDeepLinkValidateSuccess);
  }

  final AuthRepository _authRepository;
  StreamSubscription? _streamSubscription;

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  void _onEmailChanged(
    ForgotPasswordEmailChanged event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(state.copyWith(
        email: event.email,
        emailValidation: (event.email.isValidEmail() || event.email.isEmpty)
            ? ValidationCode.empty
            : ValidationCode.enterValidEmail));
  }

  void _onForgotPasswordSubmitted(
      ForgotPasswordSubmitted event, Emitter<ForgotPasswordState> emit) async {
    try {
      emit(state.copyWith(response: BaseResponse.loading()));
      var data = await _authRepository.forgotPassword(email: state.email);

      data.copyWith(message: ValidationCode.linkPasswordResetIsSent.code);

      emit(state.copyWith(response: data));
    } on AskloraApiClientException catch (e) {
      emit(state.copyWith(
          response: BaseResponse.error(validationCode: e.askloraError.type)));
    } catch (e) {
      state.copyWith(response: BaseResponse.error());
    }
  }

  void _onStartListenOnDeeplink(
    StartListenOnDeeplink event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    try {
      _streamSubscription = uriLinkStream.listen((Uri? uri) {
        if (uri != null &&
            uri.queryParameters['state'] == 'ok' &&
            uri.queryParameters['token'] != null) {
          add(DeepLinkValidateSuccess(uri));
        } else {
          add(const DeepLinkValidateFailed());
        }
      }, onError: (Object err) {
        add(const DeepLinkValidateFailed());
      });
    } catch (e) {
      add(const DeepLinkValidateFailed());
    }
  }

  void _onDeepLinkValidateSuccess(
    DeepLinkValidateSuccess event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(state.copyWith(response: BaseResponse.loading()));
    await Future.delayed(const Duration(milliseconds: 1500));
    emit(
      state.copyWith(
          response: BaseResponse.complete('Successfully get token'),
          deeplinkStatus: DeeplinkStatus.success,
          resetPasswordToken: event.uri.queryParameters['token']!),
    );
  }
}
