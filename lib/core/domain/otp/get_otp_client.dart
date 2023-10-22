import 'dart:convert';

import '../../data/remote/asklora_api_client.dart';
import 'validate_phone_request.dart';
import 'verify_otp_request.dart';
import 'package:dio/dio.dart';

import '../endpoints.dart';
import 'get_otp_request.dart';
import 'get_sms_otp_request.dart';

class GetOtpClient {
  Future<Response> getOtp(GetOtpRequest getOtpRequest) async {
    var response = await AskloraApiClient().post(
        endpoint: endpointGetOtp, payload: json.encode(getOtpRequest.toJson()));
    return response;
  }

  Future<Response> verifyOtp(VerifyOtpRequest verifyOtpRequest) async {
    var response = await AskloraApiClient().post(
        endpoint: endpointVerifyEmail,
        payload: json.encode(verifyOtpRequest.toJson()));
    return response;
  }

  Future<Response> validatePhone(
      ValidatePhoneRequest validatePhoneRequest) async {
    var response = await AskloraApiClient().post(
        endpoint: endpointValidatePhone,
        payload: json.encode(validatePhoneRequest.toJson()));
    return response;
  }

  Future<Response> getSmsOtp(GetSmsOtpRequest getSmsOtpRequest) async {
    var response = await AskloraApiClient().post(
        endpoint: endpointGetSmsOtp,
        payload: json.encode(getSmsOtpRequest.toJson()));
    return response;
  }
}
