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
import 'package:smart_contractor_app/modules/job/controllers/job_controller.dart';
import 'package:smart_contractor_app/modules/job/models/job_model.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(JobController());

    return SafeArea(
      bottom: false,
      child: GetBuilder<JobController>(
        builder: (controller) {
          final jobs = controller.filteredJobs;

          return Padding(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
            child: Column(
              children: [
                // Top Header
                const AppTabHeader(
                  title: 'কাজ',
                  subtitle: 'সব কাজের তালিকা',
                  icon: Icons.apartment,
                ),

                SizedBox(height: 12.h),

                // Search Bar
                _buildSearchBar(controller),

                SizedBox(height: 10.h),

                // Filter Tabs
                _buildFilterTabs(controller),

                SizedBox(height: 12.h),

                // Jobs List + Info Box + Floating Action Button
                Expanded(
                  child: Stack(
                    children: [
                      ListView(
                        padding: EdgeInsets.only(bottom: 80.h),
                        children: [
                          // Job Cards
                          ...jobs.map((job) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: _buildJobCard(job),
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
                            Get.toNamed(AppRoutes.jobManagementScreen);
                          },
                          text: 'নতুন কাজ',
                          icon: Icons.add,
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
  Widget _buildSearchBar(JobController controller) {
    return AppTextField(
      controller: controller.searchController,
      hint: 'কাজ বা ক্লায়েন্টের নাম খুঁজুন',
      icon: Icons.search_rounded,
    );
  }

  // Filter Tabs Bar
  Widget _buildFilterTabs(JobController controller) {
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

  // Individual Job Card
  Widget _buildJobCard(JobModel job) {
    return AppCard(
      onTap: () {
        Get.toNamed(AppRoutes.jobDetailsScreen, arguments: job);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Title + Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                job.clientName,
                style: AppTextStyles.custom(
                  size: 16.sp,
                  color: AppColors.textPrimary,
                  weight: FontWeight.w700,
                ),
              ),
              _buildStatusBadge(job.status),
            ],
          ),

          SizedBox(height: 4.h),

          // Row 2: Work Subtitle
          Text(
            job.workName,
            style: AppTextStyles.mediumGrey,
          ),

          SizedBox(height: 10.h),

          // Row 3: Location + Remaining Due Amount
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16.sp,
                color: AppColors.textSecondary,
              ),
              SizedBox(width: 4.w),
              Text(
                job.location,
                style: AppTextStyles.smallGrey,
              ),
              const Spacer(),
              Text(
                'বাকি ৳${job.dueAmount.toStringAsFixed(0)}',
                style: AppTextStyles.custom(
                  size: 15.sp,
                  color: Colors.red,
                  weight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Status Badge Helper
  Widget _buildStatusBadge(JobStatus status) {
    String text = 'চলছে';
    Color bgColor = AppColors.primaryLight;
    Color textColor = AppColors.primary;

    if (status == JobStatus.scheduled) {
      text = 'অপেক্ষায়';
      bgColor = const Color(0xFFFFF4E5);
      textColor = const Color(0xFFE66A00);
    } else if (status == JobStatus.completed) {
      text = 'শেষ';
      bgColor = const Color(0xFFE8F8F0);
      textColor = const Color(0xFF079455);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        text,
        style: AppTextStyles.custom(
          size: 12.sp,
          color: textColor,
          weight: FontWeight.w700,
        ),
      ),
    );
  }

  // Info Note Box Helper
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
              'কাজ শেষ করলেও বাকি টাকা এখানে দেখা যাবে।',
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
