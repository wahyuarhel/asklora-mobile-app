import '../../../core/utils/storage/shared_preference.dart';

class BackdoorRepository {
  final SharedPreference _sharedPreference = SharedPreference();
  static const String _sfKeyLoginVersion = 'login_version';

  static const String _baseUrlKey = 'baseUrlKey';

  Future<void> saveBaseUrl(String baseUrl) async {
    await _sharedPreference.writeData(_baseUrlKey, baseUrl);
  }

  Future<String?> getBaseUrl() async {
    return await _sharedPreference.readData(_baseUrlKey);
  }

  Future<bool> isOtpLoginDisabled() async {
    bool? response = await _sharedPreference.readBoolData(_sfKeyLoginVersion);
    return response ?? true;
  }

  Future<bool> otpLoginVersion(bool value) async {
    bool response =
        await _sharedPreference.writeBoolData(_sfKeyLoginVersion, value);
    return response;
  }
}
