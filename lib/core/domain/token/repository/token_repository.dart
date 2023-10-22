import '../../../utils/storage/secure_storage.dart';
import '../../base_response.dart';
import '../model/token_refresh_request.dart';
import '../model/token_refresh_response.dart';
import '../model/token_verify_request.dart';
import '../model/token_verify_response.dart';
import '../token_api_client.dart';
import 'repository.dart';

class TokenRepository implements Repository {
  final TokenApiClient _tokenApiClient = TokenApiClient();

  static final TokenRepository _tokenRepository = TokenRepository._internal();

  final _secureStorage = SecureStorage();

  factory TokenRepository() {
    return _tokenRepository;
  }

  TokenRepository._internal();

  @override
  Future<void> saveAccessToken(String token) async {
    return await _secureStorage.writeData(Repository.keyAuthTokenAccess, token);
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    return await _secureStorage.writeData(
        Repository.keyAuthTokenRefresh, token);
  }

  @override
  Future<String?> getAccessToken() async =>
      await _secureStorage.readData(Repository.keyAuthTokenAccess);

  @override
  Future<String?> getRefreshToken() async =>
      await _secureStorage.readData(Repository.keyAuthTokenRefresh);

  @override
  Future<void> deleteAll() async => await _secureStorage.deleteAllData();

  @override
  Future<bool> isTokenValid() async {
    try {
      var accessToken = await getAccessToken();
      if (accessToken != null && accessToken.isNotEmpty) {
        await _verifyToken(accessToken);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return refreshToken();
    }
  }

  @override
  Future<bool> refreshToken() async {
    try {
      var refreshToken = await getRefreshToken();
      if (refreshToken != null) {
        await _refreshToken(refreshToken);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<BaseResponse<TokenVerifyResponse>> _verifyToken(
      String accessToken) async {
    var response =
        await _tokenApiClient.verify(TokenVerifyRequest(accessToken));
    return BaseResponse.complete(TokenVerifyResponse.fromJson(response.data));
  }

  Future<BaseResponse<TokenRefreshResponse>> _refreshToken(
      String refreshToken) async {
    var response =
        await _tokenApiClient.refresh(TokenRefreshRequest(refreshToken));
    var refreshResponse =
        BaseResponse.complete(TokenRefreshResponse.fromJson(response.data));
    saveAccessToken(refreshResponse.data!.access!);
    return refreshResponse;
  }
}
