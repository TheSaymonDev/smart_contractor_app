import 'package:get/get.dart';
import 'package:smart_contractor_app/modules/auth/controllers/reset_password_controller.dart';

class ResetPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetPasswordController());
  }
}
