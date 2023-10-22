import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/domain/base_response.dart';
import '../../../../core/domain/otp/get_otp_request.dart';
import '../../../core/data/remote/base_api_client.dart';
import '../../../core/domain/token/repository/repository.dart';
import '../../backdoor/domain/backdoor_repository.dart';
import '../../settings/domain/change_password/change_password_request.dart';
import '../../settings/domain/change_password/change_password_response.dart';
import '../domain/auth_api_client.dart';
import '../forgot_password/domain/forgot_password_request.dart';
import '../forgot_password/domain/forgot_password_response.dart';
import '../reset_password/domain/reset_password_request.dart';
import '../reset_password/domain/reset_password_response.dart';
import '../sign_in/domain/sign_in_request.dart';
import '../sign_in/domain/sign_in_response.dart';
import '../sign_in/domain/sign_in_with_otp_request.dart';
import '../sign_out/domain/sign_out_request.dart';
import '../sign_up/domain/response.dart';
import '../sign_up/domain/sign_up_request.dart';

class AuthRepository {
  final AuthApiClient _authApiClient = AuthApiClient();
  final Repository _storage;
  final BackdoorRepository _backdoorRepository;

  AuthRepository(this._storage, this._backdoorRepository);

  Future<BaseResponse<SignUpResponse>> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    var response =
        await _authApiClient.signUp(SignUpRequest(email, password, username));
    return BaseResponse.complete(SignUpResponse.fromJson(response.data));
  }

  Future<BaseResponse<GetOtpResponse>> getVerificationEmail({
    required GetOtpRequest getVerificationEmailRequest,
  }) async {
    var response =
        await _authApiClient.getActivationEmail(getVerificationEmailRequest);
    return BaseResponse.complete(GetOtpResponse.fromJson(response.data));
  }

  Future<bool> signOut(String? token) async {
    var response = await _authApiClient.signOut(SignOutRequest(token));
    return response.statusCode == HttpStatus.resetContent;
  }

  Future<SignInResponse> signIn({
    required String email,
    required String password,
  }) async {
    final isOtpLoginDisabled = await _backdoorRepository.isOtpLoginDisabled();

    Response response;
    if (isOtpLoginDisabled) {
      response = await _authApiClient.signInV1(SignInRequest(email, password));
    } else {
      response = await _authApiClient.signIn(SignInRequest(email, password));
    }

    var signInResponse = SignInResponse.fromJson(response.data);
    if (response.statusCode == 200) {
      await _storage.saveAccessToken(signInResponse.access!);
      await _storage.saveRefreshToken(signInResponse.refresh!);
    }
    return signInResponse.copyWith(statusCode: response.statusCode);
  }

  Future<SignInResponse> signInWithOtp({
    required String otp,
    required String email,
    required String password,
  }) async {
    var response = await _authApiClient
        .signInWithOtp(SignInWithOtpRequest(otp, email, password));
    var signInResponse = SignInResponse.fromJson(response.data);

    if (response.statusCode == 200) {
      await _storage.saveAccessToken(signInResponse.access!);
      await _storage.saveRefreshToken(signInResponse.refresh!);
    }
    return signInResponse.copyWith(statusCode: response.statusCode);
  }

  void removeStorageOnSignInFailed() async {
    await _storage.deleteAll();
  }

  Future<BaseResponse<ResetPasswordResponse>> resetPassword(
      {required String token,
      required String password,
      required String confirmPassword}) async {
    try {
      var response = await _authApiClient.resetPassword(
        ResetPasswordRequest(token, password, confirmPassword),
      );
      return BaseResponse.complete(
          ResetPasswordResponse.fromJson(response.data));
    } on AskloraApiClientException catch (e) {
      return BaseResponse.error(validationCode: e.askloraError.type);
    } catch (_) {
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<ForgotPasswordResponse>> forgotPassword(
      {required String email}) async {
    try {
      var response = await _authApiClient.forgotPassword(
        ForgotPasswordRequest(email),
      );

      return BaseResponse.complete(
          ForgotPasswordResponse.fromJson(response.data));
    } on AskloraApiClientException catch (e) {
      return BaseResponse.error(validationCode: e.askloraError.type);
    } catch (_) {
      return BaseResponse.error();
    }
  }

  Future<BaseResponse<ChangePasswordResponse>> changePassword({
    required String password,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      var response = await _authApiClient.changePassword(
          ChangePasswordRequest(password, newPassword, confirmNewPassword));
      return BaseResponse.complete(
          ChangePasswordResponse.fromJson(response.data));
    } on AskloraApiClientException catch (e) {
      return BaseResponse.error(validationCode: e.askloraError.type);
    } catch (_) {
      return BaseResponse.error();
    }
  }
}
