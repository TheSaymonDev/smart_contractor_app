import 'package:get/get.dart';
import 'package:smart_contractor_app/core/network/dio_client.dart';
import 'package:smart_contractor_app/modules/auth/controllers/auth_controller.dart';
import 'package:smart_contractor_app/modules/auth/controllers/log_in_controller.dart';
import 'package:smart_contractor_app/modules/auth/data/auth_api.dart';
import 'package:smart_contractor_app/modules/auth/services/auth_session.dart';

class LogInBinding implements Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<AuthSession>()) {
      Get.put(AuthSession());
    }

    // Registration and password recovery still use this shared controller.
    if (!Get.isRegistered<AuthController>()) {
      Get.put(AuthController());
    }

    Get.lazyPut(() => LogInController(
          AuthApi(DioClient()),
          Get.find<AuthSession>(),
        ));
  }
}
