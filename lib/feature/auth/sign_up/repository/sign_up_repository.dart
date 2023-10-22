import 'dart:async';

import '../../../../core/domain/base_response.dart';
import '../../../../core/domain/otp/get_otp_request.dart';
import '../domain/response.dart';
import '../domain/sign_up_api_client.dart';
import '../domain/sign_up_request.dart';

class SignUpRepository {
  final SignUpApiClient _signUpApiClient = SignUpApiClient();

  Future<BaseResponse<SignUpResponse>> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    var response =
        await _signUpApiClient.signUp(SignUpRequest(email, password, username));
    return BaseResponse.complete(SignUpResponse.fromJson(response.data));
  }

  Future<BaseResponse<GetOtpResponse>> getVerificationEmail({
    required GetOtpRequest getVerificationEmailRequest,
  }) async {
    var response =
        await _signUpApiClient.getActivationEmail(getVerificationEmailRequest);
    return BaseResponse.complete(GetOtpResponse.fromJson(response.data));
  }
}
