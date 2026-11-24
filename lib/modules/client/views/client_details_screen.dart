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
import 'package:smart_contractor_app/modules/client/controllers/client_controller.dart';

class ClientJobModel {
  final String title;
  final String subtitle;
  final String location;
  final String dueText;
  final String status;
  final bool isCompleted;

  const ClientJobModel({
    required this.title,
    required this.subtitle,
    required this.location,
    required this.dueText,
    required this.status,
    this.isCompleted = false,
  });
}

class ClientDetailsScreen extends StatelessWidget {
  const ClientDetailsScreen({super.key});

  final List<ClientJobModel> clientJobs = const [
    ClientJobModel(
      title: 'করিমের বাসা',
      subtitle: 'বাথরুমের পানির লাইন',
      location: 'মিরপুর, ঢাকা',
      dueText: 'বাকি ৳১০,০০০',
      status: 'চলছে',
      isCompleted: false,
    ),
    ClientJobModel(
      title: 'দোকানের লাইন',
      subtitle: 'পানির লাইন',
      location: 'মিরপুর, ঢাকা',
      dueText: 'বাকি ৳০',
      status: 'শেষ',
      isCompleted: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    String clientName = 'আব্দুল করিম';
    String clientSubtitle = '01812-345678 • মিরপুর-১০, ঢাকা';

    final args = Get.arguments;
    if (args is ClientModelData) {
      clientName = args.name;
      clientSubtitle = '${args.phoneAndJobs} • মিরপুর-১০, ঢাকা';
    } else if (args is Map<String, dynamic> && args.containsKey('name')) {
      clientName = args['name'].toString();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppCustomAppBar(
        title: 'ক্লায়েন্টের বিস্তারিত',
        subtitle: clientName,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Client Brief Card
            _buildClientBriefCard(clientName, clientSubtitle),

            SizedBox(height: 14.h),

            // 2. Summary 2x2 Grid (4 Cards)
            _buildSummaryGrid(),

            SizedBox(height: 16.h),

            // 3. Section Title: "ক্লায়েন্টের কাজ"
            Text(
              'ক্লায়েন্টের কাজ',
              style: AppTextStyles.mediumBlackBold,
            ),

            SizedBox(height: 10.h),

            // 4. Job Cards List
            ...clientJobs.map((job) => Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: _buildJobCard(job),
                )),

            SizedBox(height: 4.h),

            // 5. Info Notice Box
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
                      'টাকা নিতে নির্দিষ্ট কাজটি খুলুন।',
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

            // 6. Bottom Action Buttons Row
            Row(
              children: [
                // Outlined Edit Info Button
                Expanded(
                  child: AppOutlinedButton(
                    onPressed: () {
                      Get.toNamed(
                        AppRoutes.clientManagementScreen,
                        arguments: {
                          'name': clientName,
                          'phone': '01812-345678',
                          'address': 'মিরপুর-১০, ঢাকা'
                        },
                      );
                    },
                    text: 'তথ্য এডিট',
                    icon: Icons.edit_outlined,
                  ),
                ),

                SizedBox(width: 10.w),

                // Primary New Job Button
                Expanded(
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
          ],
        ),
      ),
    );
  }

  // Client Brief Card Helper
  Widget _buildClientBriefCard(String clientName, String clientSubtitle) {
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
                  clientName,
                  style: AppTextStyles.custom(
                    size: 17.sp,
                    color: AppColors.textPrimary,
                    weight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  clientSubtitle,
                  style: AppTextStyles.smallGrey,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Get.snackbar(
                'কল করা হচ্ছে',
                '$clientName-কে কল দেওয়া হচ্ছে',
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

  // Summary Grid (4 Cards)
  Widget _buildSummaryGrid() {
    return Column(
      children: [
        // Row 1: Total Jobs & Total Bill
        Row(
          children: [
            Expanded(
              child: AppCard(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
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
                            Icons.work_outline_rounded,
                            color: AppColors.primary,
                            size: 16.sp,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            'মোট কাজ',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.smallGrey
                                .copyWith(fontSize: 11.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '৩টি',
                      style: AppTextStyles.custom(
                        size: 20.sp,
                        color: AppColors.primary,
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
                padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
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
                            Icons.description_outlined,
                            color: AppColors.primary,
                            size: 16.sp,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            'মোট বিল',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.smallGrey
                                .copyWith(fontSize: 11.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '৳৪২,০০০',
                      style: AppTextStyles.custom(
                        size: 20.sp,
                        color: AppColors.primary,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 8.h),

        // Row 2: Received Amount & Due Amount
        Row(
          children: [
            Expanded(
              child: AppCard(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
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
                            Icons.payments_outlined,
                            color: const Color(0xFF079455),
                            size: 16.sp,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            'পাওয়া টাকা',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.smallGrey
                                .copyWith(fontSize: 11.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '৳৩২,০০০',
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
            SizedBox(width: 8.w),
            Expanded(
              child: AppCard(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
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
                            'পাওনা আছে',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.smallGrey
                                .copyWith(fontSize: 11.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '৳১০,০০০',
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
          ],
        ),
      ],
    );
  }

  // Job Card Helper
  Widget _buildJobCard(ClientJobModel job) {
    return AppCard(
      onTap: () {
        Get.toNamed(AppRoutes.jobDetailsScreen);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                job.title,
                style: AppTextStyles.custom(
                  size: 16.sp,
                  color: AppColors.textPrimary,
                  weight: FontWeight.w700,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: job.isCompleted
                      ? const Color(0xFFE8F8F0)
                      : AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  job.status,
                  style: AppTextStyles.custom(
                    size: 11.sp,
                    color: job.isCompleted
                        ? const Color(0xFF079455)
                        : AppColors.primary,
                    weight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(job.subtitle, style: AppTextStyles.smallGrey),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: AppColors.textSecondary,
                    size: 14.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    job.location,
                    style: AppTextStyles.smallGrey,
                  ),
                ],
              ),
              Text(
                job.dueText,
                style: AppTextStyles.custom(
                  size: 13.sp,
                  color: job.isCompleted
                      ? AppColors.textSecondary
                      : Colors.red,
                  weight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
