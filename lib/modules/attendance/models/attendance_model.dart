enum AttendanceStatus {
  fullDay,
  halfDay,
  absent,
}

class AttendanceModel {
  final String id;
  final String workerName;
  final double dailyRate;
  final AttendanceStatus status;
  final String jobName;
  final double amount;

  const AttendanceModel({
    required this.id,
    required this.workerName,
    required this.dailyRate,
    required this.status,
    required this.jobName,
    required this.amount,
  });

  AttendanceModel copyWith({
    String? id,
    String? workerName,
    double? dailyRate,
    AttendanceStatus? status,
    String? jobName,
    double? amount,
  }) {
    return AttendanceModel(
      id: id ?? this.id,
      workerName: workerName ?? this.workerName,
      dailyRate: dailyRate ?? this.dailyRate,
      status: status ?? this.status,
      jobName: jobName ?? this.jobName,
      amount: amount ?? this.amount,
    );
  }

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id']?.toString() ?? '',
      workerName: json['worker_name']?.toString() ?? '',
      dailyRate: (json['daily_rate'] as num?)?.toDouble() ?? 0,
      status: _parseStatus(json['status']),
      jobName: json['job_name']?.toString() ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'worker_name': workerName,
      'daily_rate': dailyRate,
      'status': status.name,
      'job_name': jobName,
      'amount': amount,
    };
  }

  static AttendanceStatus _parseStatus(dynamic status) {
    if (status == 'halfDay') return AttendanceStatus.halfDay;
    if (status == 'absent') return AttendanceStatus.absent;
    return AttendanceStatus.fullDay;
  }
}
