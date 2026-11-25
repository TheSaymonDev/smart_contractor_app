import 'package:get/get.dart';
import 'package:smart_contractor_app/modules/auth/controllers/forgot_password_controller.dart';

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordController());
  }
}
