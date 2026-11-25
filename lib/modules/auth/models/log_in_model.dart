class LogInModel {
  const LogInModel({required this.phone, required this.password});

  final String phone;
  final String password;

  Map<String, String> toJson() => {'phone': phone, 'password': password};
}

class LogInResult {
  const LogInResult({
    required this.accessToken,
    required this.refreshToken,
    required this.accessTokenExpiresAt,
    required this.refreshTokenExpiresAt,
    required this.businessSetupRequired,
  });

  final String accessToken;
  final String refreshToken;
  final DateTime accessTokenExpiresAt;
  final DateTime refreshTokenExpiresAt;
  final bool businessSetupRequired;
}
