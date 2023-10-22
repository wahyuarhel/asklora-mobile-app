import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/data/remote/asklora_api_client.dart';
import '../../../../core/domain/endpoints.dart';
import '../../../../core/domain/otp/get_otp_request.dart';
import '../../settings/domain/change_password/change_password_request.dart';
import '../forgot_password/domain/forgot_password_request.dart';
import '../reset_password/domain/reset_password_request.dart';
import '../sign_in/domain/sign_in_request.dart';
import '../sign_in/domain/sign_in_with_otp_request.dart';
import '../sign_out/domain/sign_out_request.dart';
import '../sign_up/domain/sign_up_request.dart';

class AuthApiClient {
  Future<Response> signUp(SignUpRequest request) async =>
      await AskloraApiClient().post(
          endpoint: endpointSignUp, payload: json.encode(request.toJson()));

  Future<Response> getActivationEmail(GetOtpRequest getOtpRequest) async {
    var response = await AskloraApiClient().post(
        endpoint: endpointValidateEmail,
        payload: json.encode(getOtpRequest.toJson()));
    return response;
  }

  Future<Response> signOut(SignOutRequest request) async =>
      await AskloraApiClient().post(
          endpoint: endpointSignOut, payload: jsonEncode(request.toJson()));

  Future<Response> signInV1(SignInRequest request) async =>
      await AskloraApiClient().post(
          endpoint: endpointSignInV1, payload: jsonEncode(request.toJson()));

  Future<Response> signIn(SignInRequest request) async {
    return await AskloraApiClient()
        .post(endpoint: endpointSignIn, payload: jsonEncode(request.toJson()));
  }

  Future<Response> signInWithOtp(SignInWithOtpRequest request) async =>
      await AskloraApiClient().post(
          endpoint: endpointSignIn, payload: jsonEncode(request.toJson()));

  Future<Response> resetPassword(ResetPasswordRequest request) async {
    var response = await AskloraApiClient().post(
      endpoint: endpointConfirmPassword,
      payload: json.encode(
        request.toJson(),
      ),
    );
    return response;
  }

  Future<Response> forgotPassword(ForgotPasswordRequest request) async {
    var response = await AskloraApiClient().post(
      endpoint: endpointForgotPassword,
      payload: json.encode(
        request.toJson(),
      ),
    );
    return response;
  }

  Future<Response> changePassword(ChangePasswordRequest request) async {
    var response = await AskloraApiClient().post(
        endpoint: endpointChangePassword,
        payload: json.encode(request.toJson()));
    return response;
  }
}
