import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/modules/job/models/job_model.dart';

class JobController extends GetxController {
  // 1. Jobs Screen State
  late TextEditingController searchController;
  int selectedFilterIndex = 0;
  final List<String> filterLabels = ['সব', 'চলছে', 'অপেক্ষায়', 'শেষ'];

  final List<JobModel> allJobs = const [
    JobModel(
      id: '1',
      clientName: 'করিমের বাসা',
      workName: 'বাথরুমের পানির লাইন',
      category: 'Bathroom',
      location: 'মিরপুর, ঢাকা',
      date: '20 - 24 Aug, 2026',
      status: JobStatus.running,
      dueAmount: 10000,
    ),
    JobModel(
      id: '2',
      clientName: 'সেলিমের দোকান',
      workName: 'লাইট ও সুইচ বসানো',
      category: 'Electrical',
      location: 'মিরপুর, ঢাকা',
      date: '18 - 22 Aug, 2026',
      status: JobStatus.running,
      dueAmount: 0,
    ),
    JobModel(
      id: '3',
      clientName: 'হানিফের বাড়ি',
      workName: 'বেসিন বসানো',
      category: 'Bathroom',
      location: 'মিরপুর, ঢাকা',
      date: '15 - 17 Aug, 2026',
      status: JobStatus.completed,
      dueAmount: 0,
    ),
    JobModel(
      id: '4',
      clientName: 'রহিমার বাসা',
      workName: 'কমোড ফিটিং',
      category: 'Bathroom',
      location: 'উত্তরা, ঢাকা',
      date: '27 - 29 Aug, 2026',
      status: JobStatus.scheduled,
      dueAmount: 6500,
    ),
    JobModel(
      id: '5',
      clientName: 'জামাল উদ্দিন',
      workName: 'টিউবওয়েল বসানো',
      category: 'Water System',
      location: 'সাভার, ঢাকা',
      date: '21 - 25 Aug, 2026',
      status: JobStatus.running,
      dueAmount: 12000,
    ),
  ];

  List<JobModel> get filteredJobs {
    final query = searchController.text.trim().toLowerCase();

    return allJobs.where((job) {
      // Status Filter
      bool matchesStatus = true;
      if (selectedFilterIndex == 1) {
        matchesStatus = job.status == JobStatus.running;
      } else if (selectedFilterIndex == 2) {
        matchesStatus = job.status == JobStatus.scheduled;
      } else if (selectedFilterIndex == 3) {
        matchesStatus = job.status == JobStatus.completed;
      }

      // Search Query Filter
      bool matchesSearch = query.isEmpty ||
          job.clientName.toLowerCase().contains(query) ||
          job.workName.toLowerCase().contains(query);

      return matchesStatus && matchesSearch;
    }).toList();
  }

  // 2. Job Details Screen State
  int jobDetailsTabIndex = 0;
  final List<String> jobDetailsTabLabels = const ['সারাংশ', 'মালামাল', 'হাজিরা', 'হিসাব'];

  // 3. Job Management Screen State
  late TextEditingController workNameController;
  late TextEditingController jobAddressController;
  late TextEditingController jobNoteController;

  String selectedClientName = 'আব্দুল করিম';
  String selectedWorkType = 'পাইপ ফিটিংস';
  DateTime startDate = DateTime(2026, 10, 23);
  DateTime? endDate;

  // 4. Client Payment Screen State
  late TextEditingController paymentAmountController;
  late TextEditingController paymentReferenceController;
  bool isPartialPayment = true;
  String selectedPaymentMethod = 'ক্যাশ / Cash';
  DateTime paymentDate = DateTime(2026, 10, 23);
  bool generateReceipt = true;

  // 5. Wage & Expense Screen State
  int wageExpenseTabIndex = 0;
  late TextEditingController wageController;
  late TextEditingController wageNoteController;
  late TextEditingController extraBillTitleController;
  late TextEditingController extraBillAmountController;
  late TextEditingController otherExpenseTitleController;
  late TextEditingController otherExpenseAmountController;
  DateTime expenseDate = DateTime(2026, 10, 22);

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
    searchController.addListener(() => update());

    workNameController = TextEditingController(text: 'করিমের বাসা');
    jobAddressController = TextEditingController(text: 'মিরপুর-১০, ঢাকা');
    jobNoteController = TextEditingController();

    paymentAmountController = TextEditingController(text: '5000');
    paymentAmountController.addListener(() => update());
    paymentReferenceController = TextEditingController();

    wageController = TextEditingController(text: '26000');
    wageNoteController = TextEditingController(text: 'ক্লায়েন্টের সাথে ঠিক করা মজুরি');
    extraBillTitleController = TextEditingController();
    extraBillAmountController = TextEditingController();
    otherExpenseTitleController = TextEditingController();
    otherExpenseAmountController = TextEditingController();
  }

  @override
  void onClose() {
    searchController.dispose();

    workNameController.dispose();
    jobAddressController.dispose();
    jobNoteController.dispose();

    paymentAmountController.dispose();
    paymentReferenceController.dispose();

    wageController.dispose();
    wageNoteController.dispose();
    extraBillTitleController.dispose();
    extraBillAmountController.dispose();
    otherExpenseTitleController.dispose();
    otherExpenseAmountController.dispose();

    super.onClose();
  }

  // Jobs Actions
  void setFilterIndex(int index) {
    selectedFilterIndex = index;
    update();
  }

  // Job Details Actions
  void setJobDetailsTabIndex(int index) {
    jobDetailsTabIndex = index;
    update();
  }

  // Job Management Actions
  void setClientName(String name) {
    selectedClientName = name;
    update();
  }

  void setWorkType(String type) {
    selectedWorkType = type;
    update();
  }

  void setStartDate(DateTime date) {
    startDate = date;
    update();
  }

  void setEndDate(DateTime? date) {
    endDate = date;
    update();
  }

  // Client Payment Actions
  void setPartialPayment(bool val) {
    isPartialPayment = val;
    update();
  }

  void setPaymentMethod(String method) {
    selectedPaymentMethod = method;
    update();
  }

  void setPaymentDate(DateTime date) {
    paymentDate = date;
    update();
  }

  void setGenerateReceipt(bool val) {
    generateReceipt = val;
    update();
  }

  // Wage Expense Actions
  void setWageExpenseTabIndex(int index) {
    wageExpenseTabIndex = index;
    update();
  }

  void setExpenseDate(DateTime date) {
    expenseDate = date;
    update();
  }
}
