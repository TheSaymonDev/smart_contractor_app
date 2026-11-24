import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_tab_header.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';
import 'package:smart_contractor_app/modules/worker/controllers/worker_controller.dart';
import 'package:smart_contractor_app/modules/worker/models/worker_model.dart';

class WorkersScreen extends StatelessWidget {
  const WorkersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WorkerController());

    return SafeArea(
      bottom: false,
      child: GetBuilder<WorkerController>(
        builder: (controller) {
          final workers = controller.filteredWorkers;

          return Padding(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
            child: Column(
              children: [
                // Top Header
                AppTabHeader(
                  title: 'কর্মী',
                  subtitle: 'সকল কর্মীর তালিকা ও হিসাব',
                  icon: Icons.apartment,
                  action: IconButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.bulkWorkerPaymentScreen);
                    },
                    icon: Icon(
                      Icons.payments_outlined,
                      color: AppColors.primary,
                      size: 24.sp,
                    ),
                  ),
                ),

                SizedBox(height: 12.h),

                // Search Bar
                _buildSearchBar(controller),

                SizedBox(height: 10.h),

                // Filter Tabs
                _buildFilterTabs(controller),

                SizedBox(height: 12.h),

                // Workers List + Info Box + Floating Action Button
                Expanded(
                  child: Stack(
                    children: [
                      ListView(
                        padding: EdgeInsets.only(bottom: 80.h),
                        children: [
                          // Worker Cards
                          ...workers.map((worker) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: _buildWorkerCard(worker),
                            );
                          }),

                          SizedBox(height: 6.h),

                          // Info Note Box
                          _buildInfoNoteBox(),
                        ],
                      ),

                      // Bottom Action Button
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 8.h,
                        child: AppPrimaryButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.workerManagementScreen);
                          },
                          text: 'নতুন কর্মী যোগ করুন',
                          icon: Icons.person_add_alt_1_rounded,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Search Input Field
  Widget _buildSearchBar(WorkerController controller) {
    return AppTextField(
      controller: controller.searchController,
      hint: 'নাম বা মোবাইল দিয়ে খুঁজুন',
      icon: Icons.search_rounded,
    );
  }

  // Filter Tabs Bar
  Widget _buildFilterTabs(WorkerController controller) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: List.generate(controller.filterLabels.length, (index) {
          final isSelected = controller.selectedFilterIndex == index;
          return Expanded(
            child: InkWell(
              onTap: () => controller.setFilterIndex(index),
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
                  controller.filterLabels[index],
                  style: AppTextStyles.custom(
                    size: 12.sp,
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

  // Individual Worker Card
  Widget _buildWorkerCard(WorkerModel worker) {
    final bool isDaily = worker.type == WorkerType.daily;
    final String rateText = isDaily
        ? 'দৈনিক ৳${worker.dailyRate.toStringAsFixed(0)}'
        : 'মাসিক ৳${worker.monthlyRate.toStringAsFixed(0)}';

    final String dueLabel = worker.dueAmount > 0
        ? (worker.isDueToWorker
            ? 'পাবে ৳${worker.dueAmount.toStringAsFixed(0)}'
            : 'অগ্রিম ৳${worker.dueAmount.toStringAsFixed(0)}')
        : 'হিসাব সমান';

    final Color dueColor = worker.dueAmount == 0
        ? const Color(0xFF079455)
        : (worker.isDueToWorker ? Colors.red : AppColors.primary);

    return AppCard(
      onTap: () {
        Get.toNamed(AppRoutes.workerDetailsScreen, arguments: worker);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                worker.name,
                style: AppTextStyles.custom(
                  size: 16.sp,
                  color: AppColors.textPrimary,
                  weight: FontWeight.w700,
                ),
              ),
              _buildWorkerTypeBadge(isDaily),
            ],
          ),

          SizedBox(height: 4.h),

          Text(
            '${worker.role} • ${worker.phone}',
            style: AppTextStyles.mediumGrey,
          ),

          SizedBox(height: 10.h),

          Row(
            children: [
              Text(
                rateText,
                style: AppTextStyles.smallGrey,
              ),
              const Spacer(),
              Text(
                dueLabel,
                style: AppTextStyles.custom(
                  size: 14.sp,
                  color: dueColor,
                  weight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWorkerTypeBadge(bool isDaily) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isDaily ? AppColors.primaryLight : const Color(0xFFE8F8F0),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        isDaily ? 'দৈনিক' : 'মাসিক',
        style: AppTextStyles.custom(
          size: 12.sp,
          color: isDaily ? AppColors.primary : const Color(0xFF079455),
          weight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildInfoNoteBox() {
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
              'কর্মীর যেকোনো পাওনা বা অগ্রিম টাকা এই তালিকায় দেখতে পাবেন।',
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
