import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';

class AuthController extends GetxController {
  // Login State & Controllers
  late TextEditingController loginPhoneController;
  late TextEditingController loginPasswordController;
  bool isLoginPasswordObscured = true;

  // Registration State & Controllers
  late TextEditingController regNameController;
  late TextEditingController regPhoneController;
  late TextEditingController regPasswordController;
  late TextEditingController regConfirmPasswordController;
  bool isRegPasswordObscured = true;

  // Forgot Password State & Controllers
  late TextEditingController forgotPhoneController;

  // OTP Verification State & Controllers
  late TextEditingController otpController;
  Timer? otpTimer;
  int remainingSeconds = 45;

  // Reset Password State & Controllers
  late TextEditingController newPasswordController;
  late TextEditingController resetConfirmPasswordController;
  bool isResetPasswordObscured = true;

  // Business Setup State & Controllers
  late TextEditingController businessNameController;
  late TextEditingController contractorNameController;
  late TextEditingController businessPhoneController;
  late TextEditingController businessAddressController;

  @override
  void onInit() {
    super.onInit();
    // Initialize Controllers
    loginPhoneController = TextEditingController();
    loginPasswordController = TextEditingController();

    regNameController = TextEditingController();
    regPhoneController = TextEditingController();
    regPasswordController = TextEditingController();
    regConfirmPasswordController = TextEditingController();

    forgotPhoneController = TextEditingController();

    otpController = TextEditingController();

    newPasswordController = TextEditingController();
    resetConfirmPasswordController = TextEditingController();

    businessNameController =
        TextEditingController(text: 'রহমান কন্ট্রাক্টর সার্ভিস');
    contractorNameController = TextEditingController(text: 'রহমান আলী');
    businessPhoneController = TextEditingController(text: '01712-345678');
    businessAddressController = TextEditingController(text: 'মিরপুর-১০, ঢাকা');
  }

  @override
  void onClose() {
    // Dispose Controllers & Timers
    loginPhoneController.dispose();
    loginPasswordController.dispose();

    regNameController.dispose();
    regPhoneController.dispose();
    regPasswordController.dispose();
    regConfirmPasswordController.dispose();

    forgotPhoneController.dispose();

    otpTimer?.cancel();
    otpController.dispose();

    newPasswordController.dispose();
    resetConfirmPasswordController.dispose();

    businessNameController.dispose();
    contractorNameController.dispose();
    businessPhoneController.dispose();
    businessAddressController.dispose();

    super.onClose();
  }

  // Login Toggles
  void toggleLoginPasswordVisibility() {
    isLoginPasswordObscured = !isLoginPasswordObscured;
    update();
  }

  // Registration Toggles
  void toggleRegPasswordVisibility() {
    isRegPasswordObscured = !isRegPasswordObscured;
    update();
  }

  // Reset Password Toggles
  void toggleResetPasswordVisibility() {
    isResetPasswordObscured = !isResetPasswordObscured;
    update();
  }

  // OTP Timer Methods
  void startOtpTimer() {
    otpTimer?.cancel();
    remainingSeconds = 45;
    update();

    otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        update();
      } else {
        timer.cancel();
      }
    });
  }

  void resendOtp() {
    otpController.clear();
    startOtpTimer();
  }

  void verifyOtp() {
    if (otpController.text.length < 4) {
      Get.snackbar(
        'OTP প্রয়োজন',
        'OTP কোডটি সঠিকভাবে লিখুন',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    Get.toNamed(AppRoutes.resetPasswordScreen);
  }
}
