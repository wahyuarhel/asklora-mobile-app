abstract class Repository {
  static const String keyAuthTokenAccess = 'auth_token_key_access';
  static const String keyAuthTokenRefresh = 'auth_token_key_refresh';

  Future<void> saveAccessToken(String token);

  Future<void> saveRefreshToken(String token);

  Future<String?> getAccessToken();

  Future<String?> getRefreshToken();

  Future<bool> isTokenValid();

  Future<bool> refreshToken();

  Future<void> deleteAll();
}
