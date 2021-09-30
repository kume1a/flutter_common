abstract class AuthKeyStore {
  Future<String?> readAccessToken();
  Future<void> writeAccessToken(String accessToken);

  Future<String?> readRefreshToken();
  Future<void> writeRefreshToken(String refreshToken);

  Future<void> clear();
}
