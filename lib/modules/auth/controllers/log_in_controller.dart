import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/core/network/api_exceptions.dart';
import 'package:smart_contractor_app/modules/auth/data/auth_api.dart';
import 'package:smart_contractor_app/modules/auth/models/log_in_model.dart';
import 'package:smart_contractor_app/modules/auth/services/auth_session.dart';
import 'package:smart_contractor_app/modules/auth/utils/auth_phone.dart';

class LogInController extends GetxController {
  LogInController(this._api, this._session);

  static const passwordId = 'loginPassword';
  static const submissionId = 'loginSubmission';

  final AuthApi _api;
  final AuthSession _session;
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordObscured = true;
  bool isSubmitting = false;

  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    update([passwordId]);
  }

  Future<LogInResult?> logIn() async {
    if (isSubmitting) return null;
    final phone = normalizeAuthPhone(phoneController.text);
    if (phone == null) {
      throw ApiException('সঠিক বাংলাদেশি মোবাইল নম্বর লিখুন।');
    }

    isSubmitting = true;
    update([submissionId, passwordId]);
    try {
      final result = await _api.logIn(
        LogInModel(phone: phone, password: passwordController.text),
      );
      if (isClosed) return null;
      passwordController.clear();
      _session.start(result);
      return result;
    } finally {
      if (!isClosed) {
        isSubmitting = false;
        update([submissionId, passwordId]);
      }
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
