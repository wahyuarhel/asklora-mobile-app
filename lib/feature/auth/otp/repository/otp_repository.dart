import 'dart:async';

import '../../../../core/domain/base_response.dart';
import '../../../../core/domain/otp/get_otp_client.dart';
import '../../../../core/domain/otp/get_otp_request.dart';
import '../../../../core/domain/otp/get_sms_otp_request.dart';
import '../../../../core/domain/otp/validate_phone_request.dart';
import '../../../../core/domain/otp/verify_otp_request.dart';
import '../../sign_up/domain/response.dart';

class OtpRepository {
  final GetOtpClient _getOtpApiClient = GetOtpClient();

  Future<BaseResponse<GetOtpResponse>> getOtp({
    required GetOtpRequest getOtpRequest,
  }) async {
    var response = await _getOtpApiClient.getOtp(getOtpRequest);
    return BaseResponse(data: GetOtpResponse.fromJson(response.data));
  }

  Future<BaseResponse<GetOtpResponse>> verifyOtp({
    required VerifyOtpRequest verifyOtpRequest,
  }) async {
    var response = await _getOtpApiClient.verifyOtp(verifyOtpRequest);
    return BaseResponse.complete(GetOtpResponse.fromJson(response.data));
  }

  Future<BaseResponse<GetOtpResponse>> validatePhone({
    required ValidatePhoneRequest validatePhoneRequest,
  }) async {
    var response = await _getOtpApiClient.validatePhone(validatePhoneRequest);
    return BaseResponse.complete(GetOtpResponse.fromJson(response.data));
  }

  Future<BaseResponse<GetOtpResponse>> getSmsOtp({
    required GetSmsOtpRequest getSmsOtpRequest,
  }) async {
    var response = await _getOtpApiClient.getSmsOtp(getSmsOtpRequest);
    return BaseResponse(
        data: GetOtpResponse.fromJson(response.data),
        message: 'Otp SMS is sent to your phone');
  }
}
