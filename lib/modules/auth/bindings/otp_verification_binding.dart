import 'package:get/get.dart';
import 'package:smart_contractor_app/modules/auth/controllers/otp_verification_controller.dart';

class OtpVerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
          () => OtpVerificationController(),
    );
  }
}