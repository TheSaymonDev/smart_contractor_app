import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/modules/more/views/generated_pdf_list_screen.dart';

class MoreController extends GetxController {
  // 1. Generated PDF List State
  late TextEditingController pdfSearchController;
  int selectedFilterIndex = 0;

  final List<String> filterLabels = const ['সব', 'মালামাল', 'বিল', 'রসিদ', 'কর্মী'];

  final List<GeneratedPdfItem> pdfItems = const [
    GeneratedPdfItem(
      id: '1',
      title: 'মালামালের তালিকা',
      subtitle: 'করিমের বাসা • ২৩ অক্টোবর • v2',
      category: 'মালামাল',
      badgeColor: AppColors.primary,
      badgeBgColor: AppColors.primaryLight,
    ),
    GeneratedPdfItem(
      id: '2',
      title: 'মালামালের তালিকা',
      subtitle: 'করিমের বাসা • ২২ অক্টোবর • v1',
      category: 'মালামাল',
      badgeColor: AppColors.primary,
      badgeBgColor: AppColors.primaryLight,
    ),
    GeneratedPdfItem(
      id: '3',
      title: 'ফাইনাল বিল',
      subtitle: 'করিমের বাসা • ২৩ অক্টোবর',
      category: 'বিল',
      badgeColor: Color(0xFF079455),
      badgeBgColor: Color(0xFFE8F8F0),
    ),
    GeneratedPdfItem(
      id: '4',
      title: 'টাকা পাওয়ার রসিদ',
      subtitle: 'করিমের বাসা • ২৩ অক্টোবর',
      category: 'রসিদ',
      badgeColor: Color(0xFFE66A00),
      badgeBgColor: Color(0xFFFFF4E5),
    ),
    GeneratedPdfItem(
      id: '5',
      title: 'কর্মীর হিসাব',
      subtitle: 'রহিম মিয়া • অক্টোবর ২০২৬',
      category: 'কর্মী',
      badgeColor: Color(0xFF6941C6),
      badgeBgColor: Color(0xFFF4EBFF),
    ),
  ];

  // 2. Reports Screen State
  DateTime reportsSelectedDate = DateTime(2026, 10, 1);
  double totalBillAmount = 84000;
  double workerWagesAmount = 23000;
  double otherExpensesAmount = 7000;

  double get estimatedProfit =>
      totalBillAmount - workerWagesAmount - otherExpensesAmount;

  @override
  void onInit() {
    super.onInit();
    pdfSearchController = TextEditingController();
    pdfSearchController.addListener(() => update());
  }

  @override
  void onClose() {
    pdfSearchController.dispose();
    super.onClose();
  }

  void setFilterIndex(int index) {
    selectedFilterIndex = index;
    update();
  }

  void setReportsSelectedDate(DateTime date) {
    reportsSelectedDate = date;
    update();
  }

  List<GeneratedPdfItem> get filteredPdfItems {
    final query = pdfSearchController.text.trim().toLowerCase();

    return pdfItems.where((item) {
      // Category Tab Filter
      bool matchesTab = true;
      if (selectedFilterIndex > 0) {
        matchesTab = item.category == filterLabels[selectedFilterIndex];
      }

      // Search Query Filter
      bool matchesSearch = query.isEmpty ||
          item.title.toLowerCase().contains(query) ||
          item.subtitle.toLowerCase().contains(query);

      return matchesTab && matchesSearch;
    }).toList();
  }
}
