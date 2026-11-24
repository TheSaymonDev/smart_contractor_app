import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';
import 'package:smart_contractor_app/modules/client/controllers/client_controller.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ClientController());

    return SafeArea(
      bottom: false,
      child: GetBuilder<ClientController>(
        builder: (controller) {
          final clients = controller.filteredClients;

          return Padding(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
            child: Column(
              children: [
                // Top Header
                _buildHeader(),

                SizedBox(height: 12.h),

                // Search Bar
                _buildSearchBar(controller),

                SizedBox(height: 12.h),

                // Client Summary Stat Cards
                _buildSummaryStats(),

                SizedBox(height: 12.h),

                // Clients List + Info Box + Floating Action Button
                Expanded(
                  child: Stack(
                    children: [
                      ListView(
                        padding: EdgeInsets.only(bottom: 80.h),
                        children: [
                          // Client Cards
                          ...clients.map((client) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: _buildClientCard(client),
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
                            Get.toNamed(AppRoutes.clientManagementScreen);
                          },
                          text: 'নতুন ক্লায়েন্ট যোগ করুন',
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

  // Top Header Bar
  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 42.w,
          height: 42.w,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            Icons.person_pin_rounded,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ক্লায়েন্ট',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'সকল ক্লায়েন্ট ও কাজের হিসাব',
              style: AppTextStyles.smallGrey,
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            color: AppColors.textSecondary,
            size: 24.sp,
          ),
        ),
      ],
    );
  }

  // Search Input Bar
  Widget _buildSearchBar(ClientController controller) {
    return AppTextField(
      controller: controller.searchController,
      hint: 'নাম বা মোবাইল দিয়ে খুঁজুন',
      icon: Icons.search_rounded,
    );
  }

  // Summary Stat Cards (মোট ক্লায়েন্ট & মোট পাওনা)
  Widget _buildSummaryStats() {
    return Row(
      children: [
        Expanded(
          child: AppCard(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 28.w,
                      height: 28.w,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.groups_outlined,
                        color: AppColors.primary,
                        size: 16.sp,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        'মোট ক্লায়েন্ট',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.smallGrey.copyWith(fontSize: 11.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  '৪ জন',
                  style: AppTextStyles.custom(
                    size: 15.sp,
                    color: AppColors.textPrimary,
                    weight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: AppCard(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 28.w,
                      height: 28.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF4E5),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.account_balance_wallet_outlined,
                        color: const Color(0xFFE66A00),
                        size: 16.sp,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        'মোট পাওনা',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.smallGrey.copyWith(fontSize: 11.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  '৳১৬,৫০০',
                  style: AppTextStyles.custom(
                    size: 15.sp,
                    color: Colors.red,
                    weight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Individual Client Card
  Widget _buildClientCard(ClientModelData client) {
    final bool hasDue = !client.dueText.contains('৳০');

    return AppCard(
      onTap: () {
        Get.toNamed(AppRoutes.clientDetailsScreen, arguments: client);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                client.name,
                style: AppTextStyles.custom(
                  size: 16.sp,
                  color: AppColors.textPrimary,
                  weight: FontWeight.w700,
                ),
              ),
              Text(
                client.dueText,
                style: AppTextStyles.custom(
                  size: 14.sp,
                  color: hasDue ? Colors.red : const Color(0xFF079455),
                  weight: FontWeight.w700,
                ),
              ),
            ],
          ),

          SizedBox(height: 4.h),

          Text(
            client.phoneAndJobs,
            style: AppTextStyles.mediumGrey,
          ),

          SizedBox(height: 10.h),

          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16.sp,
                color: AppColors.textSecondary,
              ),
              SizedBox(width: 4.w),
              Text(
                client.location,
                style: AppTextStyles.smallGrey,
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14.sp,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ],
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
              'ক্লায়েন্টের ওপর ট্যাপ করে সব কাজের হিসাব ও PDF দেখতে পাবেন।',
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
