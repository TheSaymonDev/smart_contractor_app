import 'package:get/get.dart';
import 'package:smart_contractor_app/modules/auth/models/log_in_model.dart';

class AuthSession extends GetxService {
  LogInResult? _current;
  LogInResult? get current => _current;

  void start(LogInResult result) => _current = result;

  void clear() => _current = null;
}
