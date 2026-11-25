// POST /auth/password/forgot
class ForgotPasswordModel {
  String? phone;

  ForgotPasswordModel({
    this.phone,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    return data;
  }
}