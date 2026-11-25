import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/constants/api_endpoints.dart';
import 'package:smart_contractor_app/core/network/api_exceptions.dart';
import 'package:smart_contractor_app/core/network/dio_client.dart';
import 'package:smart_contractor_app/modules/auth/utils/auth_phone.dart';

class AuthController extends GetxController {
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

  static String? normalizeRegistrationPhone(String phone) =>
      normalizeAuthPhone(phone);

  Future<String> register() async {
    final phone = normalizeRegistrationPhone(regPhoneController.text);
    if (phone == null) {
      throw ApiException('সঠিক বাংলাদেশি মোবাইল নম্বর লিখুন');
    }

    final response = await DioClient().post(
      ApiEndpoints.register,
      data: {
        'name': regNameController.text.trim(),
        'phone': phone,
        'password': regPasswordController.text,
      },
    );
    final body = response.data;
    if (body is Map && body['success'] == false) {
      throw ApiException.fromResponse(response.statusCode, body);
    }
    final data = body is Map ? body['data'] : null;
    if (body is! Map ||
        body['success'] != true ||
        data is! Map ||
        data['userId'] is! String ||
        (data['userId'] as String).isEmpty) {
      throw ApiException('সার্ভার থেকে নিবন্ধনের ফল নিশ্চিত করা যায়নি');
    }
    return phone;
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
