import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/screens/business_setup_screen/business_setup_screen.dart';
import 'package:smart_contractor_app/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:smart_contractor_app/screens/log_in_screen/log_in_screen.dart';
import 'package:smart_contractor_app/screens/otp_verification_screen/otp_verification_screen.dart';
import 'package:smart_contractor_app/screens/registration_screen/registration_screen.dart';
import 'package:smart_contractor_app/screens/reset_password_screen/reset_password_screen.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.logInScreen, page: () => LogInScreen()),
    GetPage(name: AppRoutes.registrationScreen, page: () => RegistrationScreen(),),
    GetPage(name: AppRoutes.businessSetupScreen, page: () => BusinessSetupScreen(),),
    GetPage(name: AppRoutes.forgotPasswordScreen, page: () => ForgotPasswordScreen(),),
    GetPage(name: AppRoutes.otpVerificationScreen, page: () => OtpVerificationScreen(),),
    GetPage(name: AppRoutes.resetPasswordScreen, page: () => ResetPasswordScreen(),),
  ];
}
