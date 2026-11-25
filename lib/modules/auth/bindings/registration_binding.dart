import 'package:get/get.dart';
import 'package:smart_contractor_app/modules/auth/controllers/registration_controller.dart';

class RegistrationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
          () => RegistrationController(),
    );
  }
}