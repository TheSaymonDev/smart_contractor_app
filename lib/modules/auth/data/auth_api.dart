import 'package:smart_contractor_app/core/constants/api_endpoints.dart';
import 'package:smart_contractor_app/core/network/api_exceptions.dart';
import 'package:smart_contractor_app/core/network/dio_client.dart';
import 'package:smart_contractor_app/modules/auth/models/log_in_model.dart';

class AuthApi {
  AuthApi(this._client);

  final DioClient _client;

  Future<LogInResult> logIn(LogInModel credentials) async {
    final response = await _client.post(
      ApiEndpoints.login,
      data: credentials.toJson(),
    );
    final body = response.data;
    if (body is Map && body['success'] == false) {
      throw ApiException.fromResponse(response.statusCode, body);
    }

    final data = body is Map && body['success'] == true ? body['data'] : null;
    if (data is! Map) {
      throw ApiException('লগইনের ফল নিশ্চিত করা যায়নি। আবার চেষ্টা করুন।');
    }

    final accessToken = data['accessToken'];
    final refreshToken = data['refreshToken'];
    final expiresIn = data['expiresIn'];
    final refreshExpires = data['refreshTokenExpiresAt'];
    final refreshExpiresAt =
        refreshExpires is String ? DateTime.tryParse(refreshExpires) : null;
    final businessSetupRequired = data['businessSetupRequired'];
    if (accessToken is! String ||
        accessToken.isEmpty ||
        refreshToken is! String ||
        refreshToken.isEmpty ||
        expiresIn is! int ||
        expiresIn <= 0 ||
        refreshExpiresAt == null ||
        businessSetupRequired is! bool) {
      throw ApiException('লগইনের ফল নিশ্চিত করা যায়নি। আবার চেষ্টা করুন।');
    }

    return LogInResult(
      accessToken: accessToken,
      refreshToken: refreshToken,
      accessTokenExpiresAt: DateTime.now().add(Duration(seconds: expiresIn)),
      refreshTokenExpiresAt: refreshExpiresAt,
      businessSetupRequired: businessSetupRequired,
    );
  }
}
