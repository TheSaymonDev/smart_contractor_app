import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';

class BulkWorkerPaymentItem {
  final String id;
  final String name;
  final String dueText;
  bool isSelected;
  final TextEditingController amountController;
  String purpose;
  String method;

  BulkWorkerPaymentItem({
    required this.id,
    required this.name,
    required this.dueText,
    this.isSelected = true,
    required this.amountController,
    this.purpose = 'মজুরি',
    this.method = 'ক্যাশ',
  });
}

class BulkWorkerPaymentScreen extends StatefulWidget {
  const BulkWorkerPaymentScreen({super.key});

  @override
  State<BulkWorkerPaymentScreen> createState() =>
      _BulkWorkerPaymentScreenState();
}

class _BulkWorkerPaymentScreenState extends State<BulkWorkerPaymentScreen> {
  DateTime selectedDate = DateTime(2026, 10, 23);

  late List<BulkWorkerPaymentItem> workers;

  final List<String> purposeOptions = ['মজুরি', 'অগ্রিম', 'খোরাকি / বোনাস'];
  final List<String> methodOptions = [
    'ক্যাশ',
    'bKash',
    'Nagad',
    'ব্যাংক ট্রান্সফার'
  ];

  @override
  void initState() {
    super.initState();
    workers = [
      BulkWorkerPaymentItem(
        id: '1',
        name: 'রহিম মিয়া',
        dueText: 'দিতে হবে ৳৩,৪০০',
        isSelected: true,
        amountController: TextEditingController(text: '1000'),
        purpose: 'মজুরি',
        method: 'ক্যাশ',
      ),
      BulkWorkerPaymentItem(
        id: '2',
        name: 'করিম মিয়া',
        dueText: 'দিতে হবে ৳১,২০০',
        isSelected: true,
        amountController: TextEditingController(text: '1200'),
        purpose: 'মজুরি',
        method: 'bKash',
      ),
      BulkWorkerPaymentItem(
        id: '3',
        name: 'সেলিম মিয়া',
        dueText: 'দিতে হবে ৳৮০০',
        isSelected: false,
        amountController: TextEditingController(text: '800'),
        purpose: 'মজুরি',
        method: 'ক্যাশ',
      ),
    ];

    for (var w in workers) {
      w.amountController.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    for (var w in workers) {
      w.amountController.dispose();
    }
    super.dispose();
  }

  // Date Picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    const months = [
      'জানুয়ারি',
      'ফেব্রুয়ারি',
      'মার্চ',
      'এপ্রিল',
      'মে',
      'জুন',
      'জুলাই',
      'আগস্ট',
      'সেপ্টেম্বর',
      'অক্টোবর',
      'নভেম্বর',
      'ডিসেম্বর'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  // Option Dropdown Bottom Sheet
  void _showDropdownBottomSheet(
      String title, List<String> options, ValueChanged<String> onSelect) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.mediumBlackBold),
              SizedBox(height: 12.h),
              ...options.map((opt) {
                return ListTile(
                  title: Text(opt, style: AppTextStyles.mediumBlack),
                  onTap: () {
                    onSelect(opt);
                    Get.back();
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedWorkers = workers.where((w) => w.isSelected).toList();
    final int selectedCount = selectedWorkers.length;

    double totalAmount = 0;
    for (var w in selectedWorkers) {
      totalAmount += double.tryParse(w.amountController.text.trim()) ?? 0;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primary,
            size: 24.sp,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'একসাথে টাকা দিন',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'কর্মী বেছে টাকা ও মাধ্যম লিখুন',
              style: AppTextStyles.smallGrey,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Date Field
            Text('তারিখ', style: AppTextStyles.mediumBlackBold),
            SizedBox(height: 6.h),
            _buildDateSelectorBox(),

            SizedBox(height: 14.h),

            // 2. Worker Payment Cards
            ...List.generate(workers.length, (index) {
              final worker = workers[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: _buildWorkerPaymentCard(worker, index),
              );
            }),

            SizedBox(height: 2.h),

            // 3. Calculated Total Card
            AppCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$selectedCount জনকে মোট দেবেন',
                    style: AppTextStyles.mediumGrey,
                  ),
                  Text(
                    '৳${totalAmount.toStringAsFixed(0)}',
                    style: AppTextStyles.custom(
                      size: 16.sp,
                      color: AppColors.primary,
                      weight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 14.h),

            // 4. Info Notice Box
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.primary,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'সেভ করার আগে প্রতিটি কর্মীর টাকার পরিমাণ মিলিয়ে নিন।',
                      style: AppTextStyles.custom(
                        size: 12.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // 5. Bottom Action Save Button
            AppPrimaryButton(
              onPressed: () {
                Get.snackbar(
                  'পেমেন্ট সেভ করা হয়েছে',
                  '$selectedCount জন কর্মীর মোট ৳${totalAmount.toStringAsFixed(0)} প্রদানের তথ্য সংরক্ষিত হয়েছে',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.primary,
                  colorText: Colors.white,
                );
                Future.delayed(const Duration(milliseconds: 600), () {
                  Get.back();
                });
              },
              text: '$selectedCount জনের পেমেন্ট সেভ',
              icon: Icons.check_rounded,
            ),
          ],
        ),
      ),
    );
  }

  // Date Selector Box
  Widget _buildDateSelectorBox() {
    return InkWell(
      onTap: () => _selectDate(context),
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: 52.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.border, width: 1.5),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_month_outlined,
              color: AppColors.textSecondary,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                _formatDate(selectedDate),
                style: AppTextStyles.mediumBlackBold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Individual Worker Card
  Widget _buildWorkerPaymentCard(BulkWorkerPaymentItem worker, int index) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkbox + Name Row
          Row(
            children: [
              SizedBox(
                width: 24.w,
                height: 24.w,
                child: Checkbox(
                  value: worker.isSelected,
                  activeColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  onChanged: (val) {
                    setState(() {
                      worker.isSelected = val ?? false;
                    });
                  },
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    worker.name,
                    style: AppTextStyles.custom(
                      size: 16.sp,
                      color: AppColors.textPrimary,
                      weight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    worker.dueText,
                    style: AppTextStyles.smallGrey,
                  ),
                ],
              ),
            ],
          ),

          if (worker.isSelected) ...[
            SizedBox(height: 12.h),

            // Amount Input Field
            Text('পরিমাণ', style: AppTextStyles.mediumBlackBold),
            SizedBox(height: 6.h),
            TextFormField(
              controller: worker.amountController,
              keyboardType: TextInputType.number,
              style: AppTextStyles.mediumBlackBold,
              decoration: InputDecoration(
                hintText: 'টাকার পরিমাণ',
                hintStyle: AppTextStyles.mediumGrey,
                prefixIcon: Icon(
                  Icons.payments_outlined,
                  color: AppColors.textSecondary,
                  size: 20.sp,
                ),
                suffixText: 'টাকা',
                suffixStyle: AppTextStyles.mediumBlackBold,
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide:
                      const BorderSide(color: AppColors.border, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 1.5),
                ),
              ),
            ),

            SizedBox(height: 10.h),

            // Purpose & Method Side-by-Side Dropdowns
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ধরন', style: AppTextStyles.mediumBlackBold),
                      SizedBox(height: 4.h),
                      _buildMiniDropdownBox(
                        worker.purpose,
                        () => _showDropdownBottomSheet(
                          'ধরন নির্বাচন করুন',
                          purposeOptions,
                          (val) => setState(() => worker.purpose = val),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('মাধ্যম', style: AppTextStyles.mediumBlackBold),
                      SizedBox(height: 4.h),
                      _buildMiniDropdownBox(
                        worker.method,
                        () => _showDropdownBottomSheet(
                          'মাধ্যম নির্বাচন করুন',
                          methodOptions,
                          (val) => setState(() => worker.method = val),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // Mini Dropdown Box Helper
  Widget _buildMiniDropdownBox(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        height: 46.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.border, width: 1.5),
        ),
        child: Row(
          children: [
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.textSecondary,
              size: 20.sp,
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: Text(
                text,
                style: AppTextStyles.custom(
                  size: 13.sp,
                  color: AppColors.textPrimary,
                  weight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
