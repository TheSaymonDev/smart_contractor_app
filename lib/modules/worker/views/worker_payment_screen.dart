import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';

class WorkerPaymentScreen extends StatefulWidget {
  const WorkerPaymentScreen({super.key});

  @override
  State<WorkerPaymentScreen> createState() => _WorkerPaymentScreenState();
}

class _WorkerPaymentScreenState extends State<WorkerPaymentScreen> {
  final TextEditingController amountController =
      TextEditingController(text: '1000');
  final TextEditingController noteController = TextEditingController();

  String workerName = 'রহিম মিয়া';
  double currentDue = 3400;

  String selectedPurpose = 'মজুরি';
  String selectedMethod = 'ক্যাশ / Cash';
  DateTime selectedDate = DateTime(2026, 10, 23);

  final List<String> purposeOptions = ['মজুরি', 'অগ্রিম', 'খোরাকি / বোনাস'];
  final List<String> methodOptions = [
    'ক্যাশ / Cash',
    'বিকাশ / bKash',
    'নগদ / Nagad',
    'ব্যাংক ট্রান্সফার'
  ];

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      if (args.containsKey('name')) workerName = args['name'].toString();
      if (args.containsKey('amount')) {
        currentDue = double.tryParse(args['amount'].toString()) ?? 3400;
      }
    }

    amountController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
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

  // Purpose Bottom Sheet
  void _showPurposeBottomSheet() {
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
              Text('কিসের টাকা?', style: AppTextStyles.mediumBlackBold),
              SizedBox(height: 12.h),
              ...purposeOptions.map((purpose) {
                return ListTile(
                  title: Text(purpose, style: AppTextStyles.mediumBlack),
                  onTap: () {
                    setState(() {
                      selectedPurpose = purpose;
                    });
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

  // Method Bottom Sheet
  void _showMethodBottomSheet() {
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
              Text('পেমেন্ট মাধ্যম', style: AppTextStyles.mediumBlackBold),
              SizedBox(height: 12.h),
              ...methodOptions.map((method) {
                return ListTile(
                  title: Text(method, style: AppTextStyles.mediumBlack),
                  onTap: () {
                    setState(() {
                      selectedMethod = method;
                    });
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
    final double payingAmount =
        double.tryParse(amountController.text.trim()) ?? 0;
    final double remainingDue = currentDue - payingAmount;
    final bool isSurplusAdvance = payingAmount > currentDue;

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
              'কর্মীকে টাকা দিন',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              workerName,
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
            // 1. Worker Brief Card
            _buildWorkerBriefCard(),

            SizedBox(height: 14.h),

            // 2. Amount Field
            AppTextField(
              label: 'টাকার পরিমাণ',
              controller: amountController,
              icon: Icons.payments_outlined,
              hint: '১,০০০',
              suffixText: 'টাকা',
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 14.h),

            // 3. Purpose Dropdown (কিসের টাকা?)
            Text('কিসের টাকা?', style: AppTextStyles.mediumBlackBold),
            SizedBox(height: 6.h),
            _buildDropdownBox(selectedPurpose, _showPurposeBottomSheet),

            SizedBox(height: 14.h),

            // 4. Method Dropdown (মাধ্যম)
            Text('মাধ্যম', style: AppTextStyles.mediumBlackBold),
            SizedBox(height: 6.h),
            _buildDropdownBox(selectedMethod, _showMethodBottomSheet),

            SizedBox(height: 14.h),

            // 5. Date Field (তারিখ)
            Text('তারিখ', style: AppTextStyles.mediumBlackBold),
            SizedBox(height: 6.h),
            _buildDateSelectorBox(),

            SizedBox(height: 14.h),

            // 6. Note Field (রেফারেন্স / নোট)
            AppTextField(
              labelWidget: RichText(
                text: TextSpan(
                  text: 'রেফারেন্স / নোট ',
                  style: AppTextStyles.mediumBlackBold,
                  children: [
                    TextSpan(
                      text: '(ইচ্ছা হলে)',
                      style: AppTextStyles.smallGrey,
                    ),
                  ],
                ),
              ),
              controller: noteController,
              hint: 'ইচ্ছা হলে লিখুন',
            ),

            SizedBox(height: 14.h),

            // 7. Calculated Remaining Due Card
            AppCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'টাকা দিলে বাকি থাকবে',
                    style: AppTextStyles.mediumGrey,
                  ),
                  Text(
                    isSurplusAdvance
                        ? 'অগ্রিম ৳${(payingAmount - currentDue).toStringAsFixed(0)}'
                        : '৳${remainingDue.toStringAsFixed(0)}',
                    style: AppTextStyles.custom(
                      size: 16.sp,
                      color: isSurplusAdvance
                          ? const Color(0xFF079455)
                          : Colors.red,
                      weight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 14.h),

            // 8. Info Notice Box
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
                      'বাকির বেশি দিলে অতিরিক্ত টাকা “অগ্রিম আছে” দেখাবে।',
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

            // 9. Bottom Action Button
            AppPrimaryButton(
              onPressed: () {
                Get.snackbar(
                  'টাকা প্রদান সফল',
                  '$workerName-কে ৳${payingAmount.toStringAsFixed(0)} প্রদানের তথ্য সেভ করা হয়েছে',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.primary,
                  colorText: Colors.white,
                );
                Future.delayed(const Duration(milliseconds: 600), () {
                  Get.back();
                });
              },
              text: 'টাকা দেওয়ার তথ্য সেভ',
              icon: Icons.check_rounded,
            ),
          ],
        ),
      ),
    );
  }

  // Worker Brief Card Helper
  Widget _buildWorkerBriefCard() {
    return AppCard(
      child: Row(
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: AppColors.primaryLight,
            child: Icon(
              Icons.person_outline_rounded,
              size: 26.sp,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workerName,
                  style: AppTextStyles.custom(
                    size: 17.sp,
                    color: AppColors.textPrimary,
                    weight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'এখন দিতে হবে ৳${currentDue.toStringAsFixed(0)}',
                  style: AppTextStyles.smallGrey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Dropdown Box Helper
  Widget _buildDropdownBox(String valueText, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
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
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.textSecondary,
              size: 22.sp,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                valueText,
                style: AppTextStyles.mediumBlackBold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Date Selector Box Helper
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

  // Input Field Helper
  Widget _buildInputField({
    required TextEditingController controller,
    IconData? icon,
    required String hint,
    String? suffixText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: AppTextStyles.mediumBlackBold,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.mediumGrey,
        prefixIcon: icon != null
            ? Icon(
                icon,
                color: AppColors.textSecondary,
                size: 20.sp,
              )
            : null,
        suffixText: suffixText,
        suffixStyle: AppTextStyles.mediumBlackBold,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.border, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }

  // Simple Input Field Helper
  Widget _buildSimpleInput({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextFormField(
      controller: controller,
      style: AppTextStyles.mediumBlack,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.mediumGrey,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.border, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
