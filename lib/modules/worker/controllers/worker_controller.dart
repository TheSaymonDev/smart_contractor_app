import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/modules/worker/models/worker_model.dart';

class WorkerController extends GetxController {
  // 1. Workers Screen State
  late TextEditingController searchController;
  int selectedFilterIndex = 0;
  final List<String> filterLabels = ['সব', 'দৈনিক', 'মাসিক'];

  final List<WorkerModel> allWorkers = const [
    WorkerModel(
      id: '1',
      name: 'রহিম মিয়া',
      role: 'পাইপ মিস্ত্রি',
      phone: '01912-345678',
      type: WorkerType.daily,
      dailyRate: 800,
      dueAmount: 2400,
      isDueToWorker: true,
    ),
    WorkerModel(
      id: '2',
      name: 'সোহেল মিয়া',
      role: 'ইলেক্ট্রিশিয়ান',
      phone: '01812-987654',
      type: WorkerType.monthly,
      monthlyRate: 15000,
      dueAmount: 5000,
      isDueToWorker: false,
    ),
    WorkerModel(
      id: '3',
      name: 'করিম শেখ',
      role: 'সহকারী মিস্ত্রি',
      phone: '01711-223344',
      type: WorkerType.daily,
      dailyRate: 600,
      dueAmount: 0,
      isDueToWorker: true,
    ),
    WorkerModel(
      id: '4',
      name: 'জামাল হোসেন',
      role: 'প্লাম্বার',
      phone: '01612-556677',
      type: WorkerType.daily,
      dailyRate: 850,
      dueAmount: 1700,
      isDueToWorker: true,
    ),
  ];

  List<WorkerModel> get filteredWorkers {
    final query = searchController.text.trim().toLowerCase();

    return allWorkers.where((worker) {
      // Type Filter
      bool matchesType = true;
      if (selectedFilterIndex == 1) {
        matchesType = worker.type == WorkerType.daily;
      } else if (selectedFilterIndex == 2) {
        matchesType = worker.type == WorkerType.monthly;
      }

      // Search Query Filter
      bool matchesSearch = query.isEmpty ||
          worker.name.toLowerCase().contains(query) ||
          worker.phone.contains(query) ||
          worker.role.toLowerCase().contains(query);

      return matchesType && matchesSearch;
    }).toList();
  }

  // 2. Worker Details Screen State
  int workerDetailsTabIndex = 0;
  final List<String> workerDetailsTabLabels = const ['হিসাব', 'হাজিরা', 'তথ্য'];

  // 3. Worker Payment History Screen State
  int historyFilterIndex = 0;
  DateTime historySelectedDate = DateTime(2026, 10, 1);
  final List<String> historyFilterLabels = const ['সব', 'মজুরি', 'বেতন', 'অগ্রিম'];

  // 4. Worker Management Screen State
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController previousBalanceController;
  late TextEditingController fullDayWageController;
  late TextEditingController halfDayWageController;
  late TextEditingController roleController;
  late TextEditingController monthlySalaryController;

  bool isDailyWage = true;
  bool isDueToWorker = true;
  DateTime startDate = DateTime(2026, 10, 1);

  // 5. Worker Payment Screen State
  late TextEditingController paymentAmountController;
  late TextEditingController paymentNoteController;
  String selectedPurpose = 'আজকের মজুরি / হাজিরা';
  String selectedMethod = 'ক্যাশ / Cash';
  DateTime paymentDate = DateTime(2026, 10, 23);

  // 6. Bulk Worker Payment Screen State
  String bulkPurpose = 'আজকের মজুরি / হাজিরা';
  String bulkMethod = 'ক্যাশ / Cash';
  DateTime bulkDate = DateTime(2026, 10, 23);

  // 7. Monthly Salary Adjustment State
  double baseSalary = 15000;
  double cutAmount = 1000;
  double extraAmount = 1500;
  double advanceAmount = 5000;
  late TextEditingController cutController;
  late TextEditingController extraController;
  late TextEditingController advanceController;
  late TextEditingController adjustNoteController;

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
    searchController.addListener(() => update());

    nameController = TextEditingController(text: 'রহিম মিয়া');
    phoneController = TextEditingController(text: '01912-345678');
    previousBalanceController = TextEditingController(text: '২,০০০');

    fullDayWageController = TextEditingController(text: '৮০০');
    halfDayWageController = TextEditingController(text: '৪০০');
    roleController = TextEditingController(text: 'পাইপ মিস্ত্রি');
    monthlySalaryController = TextEditingController(text: '১৫,০০০');

    paymentAmountController = TextEditingController(text: '১,০০০');
    paymentAmountController.addListener(() => update());
    paymentNoteController = TextEditingController();

    cutController = TextEditingController(text: '1000');
    cutController.addListener(() => update());
    extraController = TextEditingController(text: '1500');
    extraController.addListener(() => update());
    advanceController = TextEditingController(text: '5000');
    advanceController.addListener(() => update());
    adjustNoteController = TextEditingController();
  }

  @override
  void onClose() {
    searchController.dispose();

    nameController.dispose();
    phoneController.dispose();
    previousBalanceController.dispose();

    fullDayWageController.dispose();
    halfDayWageController.dispose();
    roleController.dispose();
    monthlySalaryController.dispose();

    paymentAmountController.dispose();
    paymentNoteController.dispose();

    cutController.dispose();
    extraController.dispose();
    advanceController.dispose();
    adjustNoteController.dispose();

    super.onClose();
  }

  // Actions
  void setFilterIndex(int index) {
    selectedFilterIndex = index;
    update();
  }

  void setWorkerDetailsTabIndex(int index) {
    workerDetailsTabIndex = index;
    update();
  }

  void setHistoryFilterIndex(int index) {
    historyFilterIndex = index;
    update();
  }

  void setHistorySelectedDate(DateTime date) {
    historySelectedDate = date;
    update();
  }

  void setDailyWage(bool val) {
    isDailyWage = val;
    update();
  }

  void setDueToWorker(bool val) {
    isDueToWorker = val;
    update();
  }

  void setStartDate(DateTime date) {
    startDate = date;
    update();
  }

  void setPaymentPurpose(String purpose) {
    selectedPurpose = purpose;
    update();
  }

  void setPaymentMethod(String method) {
    selectedMethod = method;
    update();
  }

  void setPaymentDate(DateTime date) {
    paymentDate = date;
    update();
  }

  void setBulkPurpose(String purpose) {
    bulkPurpose = purpose;
    update();
  }

  void setBulkMethod(String method) {
    bulkMethod = method;
    update();
  }

  void setBulkDate(DateTime date) {
    bulkDate = date;
    update();
  }
}
