enum JobStatus {
  scheduled,
  running,
  completed,
}

class JobModel {
  final String id;
  final String clientName;
  final String workName;
  final String category;
  final String location;
  final String date;
  final JobStatus status;
  final double dueAmount;

  const JobModel({
    required this.id,
    required this.clientName,
    required this.workName,
    required this.category,
    required this.location,
    required this.date,
    required this.status,
    this.dueAmount = 0,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id']?.toString() ?? '',
      clientName: json['client_name']?.toString() ?? '',
      workName: json['work_name']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      status: _parseStatus(json['status']),
      dueAmount: (json['due_amount'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_name': clientName,
      'work_name': workName,
      'category': category,
      'location': location,
      'date': date,
      'status': status.name,
      'due_amount': dueAmount,
    };
  }

  static JobStatus _parseStatus(dynamic status) {
    if (status == 'running') return JobStatus.running;
    if (status == 'completed') return JobStatus.completed;
    return JobStatus.scheduled;
  }
}
