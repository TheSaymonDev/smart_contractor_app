class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://api.smartcontractor.com/v1/';
  static const int receiveTimeout = 15000;
  static const int connectionTimeout = 15000;

  // Auth Endpoints
  static const String login = 'auth/login';
  static const String register = 'auth/register';

  // Feature Endpoints
  static const String workers = 'workers';
  static const String jobs = 'jobs';
  static const String attendance = 'attendance';
}
