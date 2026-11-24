import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/modules/attendance/models/attendance_model.dart';

class AttendanceController extends GetxController {
  // Attendance Main Screen State
  DateTime selectedDate = DateTime(2026, 10, 23);

  List<AttendanceModel> attendanceList = [
    const AttendanceModel(
      id: '1',
      workerName: 'রহিম মিয়া',
      dailyRate: 800,
      status: AttendanceStatus.fullDay,
      jobName: 'করিমের বাসা',
      amount: 800,
    ),
    const AttendanceModel(
      id: '2',
      workerName: 'করিম মিয়া',
      dailyRate: 700,
      status: AttendanceStatus.halfDay,
      jobName: 'সেলিমের দোকান',
      amount: 350,
    ),
    const AttendanceModel(
      id: '3',
      workerName: 'সেলিম মিয়া',
      dailyRate: 600,
      status: AttendanceStatus.fullDay,
      jobName: 'হানিফের বাড়ি',
      amount: 600,
    ),
    const AttendanceModel(
      id: '4',
      workerName: 'সোহেল মিয়া',
      dailyRate: 900,
      status: AttendanceStatus.absent,
      jobName: 'ইলেক্ট্রিক্যাল ওয়্যারিং',
      amount: 0,
    ),
  ];

  final List<String> availableJobs = const [
    'করিমের বাসা',
    'সেলিমের দোকান',
    'হানিফের বাড়ি',
    'রহিমার বাসা',
    'টিউবওয়েল বসানো',
  ];

  // Split Wage Screen State
  late TextEditingController totalWageController;
  late TextEditingController job1AmountController;
  late TextEditingController job2AmountController;

  String selectedJob1 = 'করিমের বাসা';
  String selectedJob2 = 'সেলিমের দোকান';
  String workerName = 'রহিম মিয়া';
  String dateText = '২৩ অক্টোবর';

  @override
  void onInit() {
    super.onInit();
    totalWageController = TextEditingController(text: '800');
    totalWageController.addListener(() => update());

    job1AmountController = TextEditingController(text: '500');
    job1AmountController.addListener(() => update());

    job2AmountController = TextEditingController(text: '300');
    job2AmountController.addListener(() => update());
  }

  @override
  void onClose() {
    totalWageController.dispose();
    job1AmountController.dispose();
    job2AmountController.dispose();
    super.onClose();
  }

  // Attendance Actions
  void setSelectedDate(DateTime date) {
    selectedDate = date;
    update();
  }

  void updateWorkerStatus(int index, AttendanceStatus newStatus) {
    if (index >= 0 && index < attendanceList.length) {
      final currentItem = attendanceList[index];
      double calculatedAmount = 0;

      if (newStatus == AttendanceStatus.fullDay) {
        calculatedAmount = currentItem.dailyRate;
      } else if (newStatus == AttendanceStatus.halfDay) {
        calculatedAmount = currentItem.dailyRate / 2;
      } else {
        calculatedAmount = 0;
      }

      attendanceList[index] = currentItem.copyWith(
        status: newStatus,
        amount: calculatedAmount,
      );
      update();
    }
  }

  void updateWorkerJob(int index, String newJob) {
    if (index >= 0 && index < attendanceList.length) {
      attendanceList[index] = attendanceList[index].copyWith(jobName: newJob);
      update();
    }
  }

  int get presentCount => attendanceList
      .where((item) => item.status != AttendanceStatus.absent)
      .length;

  int get absentCount => attendanceList
      .where((item) => item.status == AttendanceStatus.absent)
      .length;

  // Split Wage Actions
  void setJob1(String job) {
    selectedJob1 = job;
    update();
  }

  void setJob2(String job) {
    selectedJob2 = job;
    update();
  }
}
