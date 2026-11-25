// POST /business/setup
class BusinessSetupModel {
  String? name;
  String? ownerName;
  String? phone;
  String? address;

  BusinessSetupModel({
    this.name,
    this.ownerName,
    this.phone,
    this.address,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['ownerName'] = ownerName;
    data['phone'] = phone;
    data['address'] = address;
    return data;
  }
}