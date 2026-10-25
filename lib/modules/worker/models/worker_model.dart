enum WageType {
  daily,
  monthly,
}

class WorkerModel {
  final String id;
  final String name;
  final String role;
  final WageType wageType;
  final double rate;
  final double dueAmount;

  const WorkerModel({
    required this.id,
    required this.name,
    required this.role,
    required this.wageType,
    required this.rate,
    required this.dueAmount,
  });

  factory WorkerModel.fromJson(Map<String, dynamic> json) {
    return WorkerModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      wageType: json['wage_type'] == 'monthly' ? WageType.monthly : WageType.daily,
      rate: (json['rate'] as num?)?.toDouble() ?? 0,
      dueAmount: (json['due_amount'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'wage_type': wageType.name,
      'rate': rate,
      'due_amount': dueAmount,
    };
  }
}
