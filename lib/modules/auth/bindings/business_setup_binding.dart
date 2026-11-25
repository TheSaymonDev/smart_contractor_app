import 'package:get/get.dart';
import 'package:smart_contractor_app/modules/auth/controllers/business_setup_controller.dart';

class BusinessSetupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
          () => BusinessSetupController(),
    );
  }
}