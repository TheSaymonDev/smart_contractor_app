enum WorkerType {
  daily,
  monthly,
}

typedef WageType = WorkerType;

class WorkerModel {
  final String id;
  final String name;
  final String role;
  final String phone;
  final WorkerType type;
  final double rate;
  final double dueAmount;
  final bool isDueToWorker;

  const WorkerModel({
    required this.id,
    required this.name,
    required this.role,
    this.phone = '01912-345678',
    required this.type,
    double? rate,
    double? dailyRate,
    double? monthlyRate,
    required this.dueAmount,
    this.isDueToWorker = true,
  }) : rate = dailyRate ?? monthlyRate ?? rate ?? 800;

  WorkerType get wageType => type;
  double get dailyRate => rate;
  double get monthlyRate => rate;

  factory WorkerModel.fromJson(Map<String, dynamic> json) {
    return WorkerModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '01912-345678',
      type: json['wage_type'] == 'monthly' ? WorkerType.monthly : WorkerType.daily,
      rate: (json['rate'] as num?)?.toDouble() ?? 0,
      dueAmount: (json['due_amount'] as num?)?.toDouble() ?? 0,
      isDueToWorker: json['is_due_to_worker'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'phone': phone,
      'wage_type': type.name,
      'rate': rate,
      'due_amount': dueAmount,
      'is_due_to_worker': isDueToWorker,
    };
  }
}
