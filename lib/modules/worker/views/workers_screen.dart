import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';
import 'package:smart_contractor_app/modules/worker/models/worker_model.dart';

class WorkersScreen extends StatefulWidget {
  const WorkersScreen({super.key});

  @override
  State<WorkersScreen> createState() => _WorkersScreenState();
}

class _WorkersScreenState extends State<WorkersScreen> {
  final TextEditingController searchController = TextEditingController();
  int selectedFilterIndex = 0;

  final List<String> filterLabels = ['সব', 'দৈনিক', 'মাসিক'];

  final List<Map<String, dynamic>> workersData = [
    {
      'id': '1',
      'name': 'রহিম মিয়া',
      'subtitle': 'দৈনিক মজুরি • ৳৮০০',
      'type': WageType.daily,
      'amount': 3400,
      'isAdvance': false,
    },
    {
      'id': '2',
      'name': 'করিম মিয়া',
      'subtitle': 'দৈনিক মজুরি • ৳৭০০',
      'type': WageType.daily,
      'amount': 1200,
      'isAdvance': false,
    },
    {
      'id': '3',
      'name': 'সেলিম মিয়া',
      'subtitle': 'দৈনিক মজুরি • ৳৬০০',
      'type': WageType.daily,
      'amount': 800,
      'isAdvance': false,
    },
    {
      'id': '4',
      'name': 'সোহেল মিয়া',
      'subtitle': 'মাসিক মজুরি • ৳১৫,০০০',
      'type': WageType.monthly,
      'amount': 2000,
      'isAdvance': true,
    },
    {
      'id': '5',
      'name': 'জামাল মিয়া',
      'subtitle': 'দৈনিক মজুরি • ৳৯০০',
      'type': WageType.daily,
      'amount': 6200,
      'isAdvance': false,
    },
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

  List<Map<String, dynamic>> get filteredWorkers {
    final query = searchController.text.trim().toLowerCase();

    return workersData.where((worker) {
      // Filter tab
      bool matchesType = true;
      if (selectedFilterIndex == 1) {
        matchesType = worker['type'] == WageType.daily;
      } else if (selectedFilterIndex == 2) {
        matchesType = worker['type'] == WageType.monthly;
      }

      // Search query
      bool matchesSearch = query.isEmpty ||
          (worker['name'] as String).toLowerCase().contains(query);

      return matchesType && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final workers = filteredWorkers;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
        child: Column(
          children: [
            // Top Header
            _buildHeader(),

            SizedBox(height: 12.h),

            // Search Bar
            _buildSearchBar(),

            SizedBox(height: 10.h),

            // Filter Tabs
            _buildFilterTabs(),

            SizedBox(height: 12.h),

            // Summary Board
            _buildSummaryBoard(),

            SizedBox(height: 12.h),

            // Worker Cards List
            Expanded(
              child: Stack(
                children: [
                  ListView.separated(
                    padding: EdgeInsets.only(bottom: 72.h),
                    itemCount: workers.length,
                    separatorBuilder: (context, index) => SizedBox(height: 8.h),
                    itemBuilder: (context, index) {
                      final item = workers[index];
                      return _buildWorkerCard(item);
                    },
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
                      icon: Icons.add,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
            Icons.apartment,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'কর্মী',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'কর্মীদের মজুরি ও বাকি',
              style: AppTextStyles.smallGrey,
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            Get.toNamed(AppRoutes.bulkWorkerPaymentScreen);
          },
          tooltip: 'একসাথে টাকা দিন',
          icon: Icon(
            Icons.payments_outlined,
            color: AppColors.primary,
            size: 24.sp,
          ),
        ),
      ],
    );
  }

  // Search Input Field
  Widget _buildSearchBar() {
    return AppTextField(
      controller: searchController,
      hint: 'নাম বা মোবাইল দিয়ে খুঁজুন',
      icon: Icons.search_rounded,
    );
  }

  // Filter Tabs Bar
  Widget _buildFilterTabs() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: List.generate(filterLabels.length, (index) {
          final isSelected = selectedFilterIndex == index;
          return Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedFilterIndex = index;
                });
              },
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
                  filterLabels[index],
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

  // Summary Board (2 Cards)
  Widget _buildSummaryBoard() {
    return Row(
      children: [
        // Active Workers Card
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
                        'সক্রিয় কর্মী',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.smallGrey.copyWith(fontSize: 11.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  '১০ জন',
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
                        'মোট দিতে হবে',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.smallGrey.copyWith(fontSize: 11.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  '৳৫,৪০০',
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

  // Individual Worker Card
  Widget _buildWorkerCard(Map<String, dynamic> item) {
    final bool isAdvance = item['isAdvance'] as bool;
    final int amount = item['amount'] as int;

    return AppCard(
      onTap: () {
        Get.toNamed(AppRoutes.workerDetailsScreen, arguments: item);
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

          // Worker Name & Wage Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] as String,
                  style: AppTextStyles.custom(
                    size: 16.sp,
                    color: AppColors.textPrimary,
                    weight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  item['subtitle'] as String,
                  style: AppTextStyles.smallGrey,
                ),
              ],
            ),
          ),

          // Due / Advance Amount Badge on Right
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '৳${amount.toStringAsFixed(0)}',
                style: AppTextStyles.custom(
                  size: 16.sp,
                  color: isAdvance ? const Color(0xFF079455) : Colors.red,
                  weight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                isAdvance ? 'অগ্রিম আছে' : 'দিতে হবে',
                style: AppTextStyles.custom(
                  size: 11.sp,
                  color: isAdvance
                      ? const Color(0xFF079455)
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
