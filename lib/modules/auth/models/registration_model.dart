// POST /auth/register
class RegistrationModel {
  String? name;
  String? phone;
  String? password;

  RegistrationModel({
    this.name,
    this.phone,
    this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['password'] = password;
    return data;
  }
}