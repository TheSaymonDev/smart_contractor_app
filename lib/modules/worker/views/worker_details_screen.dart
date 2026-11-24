import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_custom_app_bar.dart';
import 'package:smart_contractor_app/core/widgets/app_outlined_button.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/modules/main/controllers/main_controller.dart';
import 'package:smart_contractor_app/modules/worker/controllers/worker_controller.dart';

class WorkerDetailsScreen extends StatelessWidget {
  const WorkerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String workerName = 'রহিম মিয়া';
    String workerRole = 'পাইপ মিস্ত্রি • দৈনিক ৳৮০০';

    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      if (args.containsKey('name')) workerName = args['name'].toString();
      if (args.containsKey('subtitle')) workerRole = args['subtitle'].toString();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppCustomAppBar(
        title: 'কর্মীর বিস্তারিত',
        subtitle: workerName,
      ),
      body: GetBuilder<WorkerController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Worker Brief Card
                _buildWorkerBriefCard(workerName, workerRole),

                SizedBox(height: 12.h),

                // 2. Navigation Tabs Bar
                _buildNavigationTabs(controller),

                SizedBox(height: 16.h),

                // 3. Dynamic Tab Content View
                _buildTabContent(controller, workerName, workerRole),
              ],
            ),
          );
        },
      ),
    );
  }

  // Brief Worker Card
  Widget _buildWorkerBriefCard(String workerName, String workerRole) {
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
                  workerRole,
                  style: AppTextStyles.smallGrey,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Get.snackbar(
                'কল করা হচ্ছে',
                '$workerName-কে কল দেওয়া হচ্ছে',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            icon: Icon(
              Icons.phone_outlined,
              color: AppColors.textPrimary,
              size: 22.sp,
            ),
          ),
        ],
      ),
    );
  }

  // Navigation Tabs Bar
  Widget _buildNavigationTabs(WorkerController controller) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: List.generate(controller.workerDetailsTabLabels.length, (index) {
          final isSelected = controller.workerDetailsTabIndex == index;
          return Expanded(
            child: InkWell(
              onTap: () => controller.setWorkerDetailsTabIndex(index),
              borderRadius: BorderRadius.circular(9.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: 38.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: Text(
                  controller.workerDetailsTabLabels[index],
                  style: AppTextStyles.custom(
                    size: 13.sp,
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    weight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // Dynamic Tab Content Selector
  Widget _buildTabContent(WorkerController controller, String workerName, String workerRole) {
    switch (controller.workerDetailsTabIndex) {
      case 1:
        return _buildAttendanceTab();
      case 2:
        return _buildProfileInfoTab(workerName);
      case 0:
      default:
        return _buildAccountsTab(workerName, workerRole);
    }
  }

  // TAB 0: হিসাব (Accounts Tab)
  Widget _buildAccountsTab(String workerName, String workerRole) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Summary Board Cards (2 Cards)
        Row(
          children: [
            Expanded(
              child: AppCard(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 28.w,
                          height: 28.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEBEB),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.payments_outlined,
                            color: Colors.red,
                            size: 16.sp,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            'কর্মীকে দিতে হবে',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.smallGrey.copyWith(fontSize: 11.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '৳৩,৪০০',
                      style: AppTextStyles.custom(
                        size: 20.sp,
                        color: Colors.red,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(width: 8.w),

            Expanded(
              child: AppCard(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 28.w,
                          height: 28.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F8F0),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.account_balance_wallet_outlined,
                            color: const Color(0xFF079455),
                            size: 16.sp,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            'এই মাসে দেওয়া',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.smallGrey.copyWith(fontSize: 11.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '৳১,০০০',
                      style: AppTextStyles.custom(
                        size: 20.sp,
                        color: const Color(0xFF079455),
                        weight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 14.h),

        // "হিসাবের সময়" Box
        Text('হিসাবের সময়', style: AppTextStyles.mediumBlackBold),
        SizedBox(height: 6.h),
        InkWell(
          onTap: () {
            Get.snackbar('হিসাবের সময়', 'অক্টোবর ২০২৬ মাসের হিসাব');
          },
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            height: 50.h,
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
                    'এই মাস • অক্টোবর ২০২৬',
                    style: AppTextStyles.mediumBlackBold,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 14.h),

        // Running Statement Table Card
        AppCard(
          child: Column(
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('বিবরণ', style: AppTextStyles.smallGrey),
                  Text('চলমান বাকি', style: AppTextStyles.smallGrey),
                ],
              ),
              Divider(height: 16.h, color: AppColors.border),

              // Row 1
              _buildStatementRow('আগের বাকি', '৳২,০০০', AppColors.textPrimary),
              Divider(height: 16.h, color: AppColors.border),

              // Row 2
              _buildStatementRow(
                  '২১ অক্টো • পূর্ণ দিন +৮০০', '৳২,৮০০', AppColors.textPrimary),
              Divider(height: 16.h, color: AppColors.border),

              // Row 3
              _buildStatementRow(
                  '২২ অক্টো • পূর্ণ দিন +৮০০', '৳৩,৬০০', AppColors.textPrimary),
              Divider(height: 16.h, color: AppColors.border),

              // Row 4
              _buildStatementRow(
                  '২২ অক্টো • টাকা দেওয়া –১,০০০', '৳২,৬০০', AppColors.textPrimary),
              Divider(height: 16.h, color: AppColors.border),

              // Row 5
              _buildStatementRow(
                  '২৩ অক্টো • পূর্ণ দিন +৮০০', '৳৩,৪০০', Colors.red),
            ],
          ),
        ),

        SizedBox(height: 12.h),

        // Info Notice Box
        _buildInfoNoticeBox('আগের বাকি + মজুরি – দেওয়া টাকা = এখন বাকি।'),

        SizedBox(height: 24.h),

        // Bottom Action Buttons Row
        Row(
          children: [
            // Outlined PDF Button
            Expanded(
              child: AppOutlinedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.workerLedgerPdfPreviewScreen);
                },
                text: 'হিসাবের PDF',
                icon: Icons.description_outlined,
              ),
            ),

            SizedBox(width: 10.w),

            // Primary Pay Button
            Expanded(
              child: AppPrimaryButton(
                onPressed: () {
                  if (workerRole.contains('মাসিক')) {
                    Get.toNamed(
                      AppRoutes.monthlySalaryAdjustmentScreen,
                      arguments: {'name': workerName},
                    );
                  } else {
                    Get.toNamed(
                      AppRoutes.workerPaymentScreen,
                      arguments: {'name': workerName, 'amount': 3400},
                    );
                  }
                },
                text: 'টাকা দিন',
                icon: Icons.payments_outlined,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // TAB 1: হাজিরা (Attendance Logs Tab)
  Widget _buildAttendanceTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('উপস্থিতি রেজিস্টার', style: AppTextStyles.mediumBlackBold),
            Text(
              'এই মাস • অক্টোবর ২০২৬',
              style: AppTextStyles.custom(
                size: 12.sp,
                color: AppColors.primary,
                weight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),

        AppCard(
          child: Column(
            children: [
              _buildAttendanceLogRow('২৩ অক্টোবর ২০২৬', 'পূর্ণ দিন', '৳৮০০', Colors.green),
              Divider(height: 16.h, color: AppColors.border),
              _buildAttendanceLogRow('২২ অক্টোবর ২০২৬', 'পূর্ণ দিন', '৳৮০০', Colors.green),
              Divider(height: 16.h, color: AppColors.border),
              _buildAttendanceLogRow('২১ অক্টোবর ২০২৬', 'পূর্ণ দিন', '৳৮০০', Colors.green),
              Divider(height: 16.h, color: AppColors.border),
              _buildAttendanceLogRow('২০ অক্টোবর ২০২৬', 'হাফ দিন', '৳৪০০', Colors.purple),
              Divider(height: 16.h, color: AppColors.border),
              _buildAttendanceLogRow('১৯ অক্টোবর ২০২৬', 'অনুপস্থিত', '৳০', Colors.orange),
            ],
          ),
        ),

        SizedBox(height: 16.h),

        AppPrimaryButton(
          onPressed: () {
            if (Get.isRegistered<MainController>()) {
              Get.find<MainController>().changeTab(2);
            }
          },
          text: 'আজকের হাজিরা দিন',
          icon: Icons.calendar_month_outlined,
        ),
      ],
    );
  }

  // TAB 2: তথ্য (Worker Info Profile Tab)
  Widget _buildProfileInfoTab(String workerName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('কর্মীর বিস্তারিত তথ্য', style: AppTextStyles.mediumBlackBold),
              SizedBox(height: 12.h),
              _buildInfoDetailRow('নাম', workerName),
              Divider(height: 16.h, color: AppColors.border),
              _buildInfoDetailRow('মোবাইল নম্বর', '01912-345678'),
              Divider(height: 16.h, color: AppColors.border),
              _buildInfoDetailRow('পেশা', 'পাইপ মিস্ত্রি'),
              Divider(height: 16.h, color: AppColors.border),
              _buildInfoDetailRow('মজুরির ধরন', 'দৈনিক (৳৮০০ / ৪টি)'),
              Divider(height: 16.h, color: AppColors.border),
              _buildInfoDetailRow('বর্তমান স্ট্যাটাস', 'সক্রিয়'),
            ],
          ),
        ),

        SizedBox(height: 16.h),

        AppPrimaryButton(
          onPressed: () {
            Get.toNamed(AppRoutes.workerManagementScreen);
          },
          text: 'কর্মীর তথ্য এডিট করুন',
          icon: Icons.edit_outlined,
        ),
      ],
    );
  }

  // Helpers
  Widget _buildStatementRow(String description, String balance, Color balanceColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            description,
            style: AppTextStyles.mediumBlack.copyWith(fontSize: 13.sp),
          ),
        ),
        Text(
          balance,
          style: AppTextStyles.custom(
            size: 15.sp,
            color: balanceColor,
            weight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildAttendanceLogRow(String date, String status, String amount, Color statusColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date, style: AppTextStyles.mediumBlackBold),
            SizedBox(height: 2.h),
            Text('দৈনিক হাজিরা', style: AppTextStyles.smallGrey),
          ],
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                status,
                style: AppTextStyles.custom(
                  size: 11.sp,
                  color: statusColor,
                  weight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              amount,
              style: AppTextStyles.custom(
                size: 14.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.smallGrey),
        Text(value, style: AppTextStyles.mediumBlackBold),
      ],
    );
  }

  Widget _buildInfoNoticeBox(String message) {
    return Container(
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
              message,
              style: AppTextStyles.custom(
                size: 12.sp,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
