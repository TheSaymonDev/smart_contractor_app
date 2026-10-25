import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';

class ClientModelData {
  final String id;
  final String name;
  final String phoneAndJobs;
  final double dueAmount;
  final bool isPaidAll;

  const ClientModelData({
    required this.id,
    required this.name,
    required this.phoneAndJobs,
    required this.dueAmount,
    this.isPaidAll = false,
  });
}

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  final TextEditingController searchController = TextEditingController();

  final List<ClientModelData> clientsData = const [
    ClientModelData(
      id: '1',
      name: 'আব্দুল করিম',
      phoneAndJobs: '01812-345678 • ৩টি কাজ',
      dueAmount: 10000,
      isPaidAll: false,
    ),
    ClientModelData(
      id: '2',
      name: 'সেলিম মিয়া',
      phoneAndJobs: '01813-456789 • ২টি কাজ',
      dueAmount: 0,
      isPaidAll: true,
    ),
    ClientModelData(
      id: '3',
      name: 'হানিফ মিয়া',
      phoneAndJobs: '01814-567890 • ১টি কাজ',
      dueAmount: 0,
      isPaidAll: true,
    ),
    ClientModelData(
      id: '4',
      name: 'রহিমা বেগম',
      phoneAndJobs: '01815-678901 • ১টি কাজ',
      dueAmount: 4500,
      isPaidAll: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<ClientModelData> get filteredClients {
    final query = searchController.text.trim().toLowerCase();
    if (query.isEmpty) return clientsData;

    return clientsData.where((client) {
      return client.name.toLowerCase().contains(query) ||
          client.phoneAndJobs.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final clients = filteredClients;

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
              'ক্লায়েন্ট',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'ক্লায়েন্ট ও পাওনা টাকা',
              style: AppTextStyles.smallGrey,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Search Bar
            _buildSearchBar(),

            SizedBox(height: 12.h),

            // 2. Summary Board (2 Cards)
            _buildSummaryBoard(),

            SizedBox(height: 12.h),

            // 3. Client Cards List
            ...clients.map((client) => Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: _buildClientCard(client),
                )),

            SizedBox(height: 16.h),

            // 4. Bottom Action Button
            AppPrimaryButton(
              onPressed: () {
                Get.toNamed(AppRoutes.clientManagementScreen);
              },
              text: 'নতুন ক্লায়েন্ট যোগ করুন',
              icon: Icons.add,
            ),
          ],
        ),
      ),
    );
  }

  // Search Input Bar
  Widget _buildSearchBar() {
    return AppTextField(
      controller: searchController,
      hint: 'নাম বা মোবাইল দিয়ে খুঁজুন',
      icon: Icons.search_rounded,
    );
  }

  // Summary Board (2 Cards)
  Widget _buildSummaryBoard() {
    return Row(
      children: [
        // Total Clients Card
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
                  '১২ জন',
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

        // Total Due Card
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
    );
  }

  // Client Card Helper
  Widget _buildClientCard(ClientModelData client) {
    return AppCard(
      onTap: () {
        Get.toNamed(AppRoutes.clientDetailsScreen, arguments: client);
      },
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
                  client.name,
                  style: AppTextStyles.custom(
                    size: 16.sp,
                    color: AppColors.textPrimary,
                    weight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  client.phoneAndJobs,
                  style: AppTextStyles.smallGrey,
                ),
              ],
            ),
          ),
          if (client.isPaidAll)
            Text(
              'সব পেয়েছেন',
              style: AppTextStyles.custom(
                size: 14.sp,
                color: const Color(0xFF079455),
                weight: FontWeight.w700,
              ),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '৳${client.dueAmount.toStringAsFixed(0)}',
                  style: AppTextStyles.custom(
                    size: 16.sp,
                    color: Colors.red,
                    weight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'পাওনা',
                  style: AppTextStyles.custom(
                    size: 11.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
