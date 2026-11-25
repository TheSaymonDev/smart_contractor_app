// POST /auth/password/reset
class ResetPasswordModel {
  String? phone;
  String? otp;
  String? newPassword;

  ResetPasswordModel({
    this.phone,
    this.otp,
    this.newPassword,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['otp'] = otp;
    data['newPassword'] = newPassword;
    return data;
  }
}