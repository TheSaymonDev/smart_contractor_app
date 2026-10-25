import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';
import 'package:smart_contractor_app/modules/job/models/job_model.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  final TextEditingController searchController = TextEditingController();
  int selectedFilterIndex = 0;

  final List<String> filterLabels = ['সব', 'চলছে', 'অপেক্ষায়', 'শেষ'];

  final List<JobModel> allJobs = const [
    JobModel(
      id: '1',
      clientName: 'করিমের বাসা',
      workName: 'বাথরুমের পানির লাইন',
      category: 'Bathroom',
      location: 'মিরপুর, ঢাকা',
      date: '20 - 24 Aug, 2026',
      status: JobStatus.running,
      dueAmount: 10000,
    ),
    JobModel(
      id: '2',
      clientName: 'সেলিমের দোকান',
      workName: 'লাইট ও সুইচ বসানো',
      category: 'Electrical',
      location: 'মিরপুর, ঢাকা',
      date: '18 - 22 Aug, 2026',
      status: JobStatus.running,
      dueAmount: 0,
    ),
    JobModel(
      id: '3',
      clientName: 'হানিফের বাড়ি',
      workName: 'বেসিন বসানো',
      category: 'Bathroom',
      location: 'মিরপুর, ঢাকা',
      date: '15 - 17 Aug, 2026',
      status: JobStatus.completed,
      dueAmount: 0,
    ),
    JobModel(
      id: '4',
      clientName: 'রহিমার বাসা',
      workName: 'কমোড ফিটিং',
      category: 'Bathroom',
      location: 'উত্তরা, ঢাকা',
      date: '27 - 29 Aug, 2026',
      status: JobStatus.scheduled,
      dueAmount: 6500,
    ),
    JobModel(
      id: '5',
      clientName: 'জামাল উদ্দিন',
      workName: 'টিউবওয়েল বসানো',
      category: 'Water System',
      location: 'সাভার, ঢাকা',
      date: '21 - 25 Aug, 2026',
      status: JobStatus.running,
      dueAmount: 12000,
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

  List<JobModel> get filteredJobs {
    final query = searchController.text.trim().toLowerCase();

    return allJobs.where((job) {
      // Status Filter
      bool matchesStatus = true;
      if (selectedFilterIndex == 1) {
        matchesStatus = job.status == JobStatus.running;
      } else if (selectedFilterIndex == 2) {
        matchesStatus = job.status == JobStatus.scheduled;
      } else if (selectedFilterIndex == 3) {
        matchesStatus = job.status == JobStatus.completed;
      }

      // Search Query Filter
      bool matchesSearch = query.isEmpty ||
          job.clientName.toLowerCase().contains(query) ||
          job.workName.toLowerCase().contains(query);

      return matchesStatus && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final jobs = filteredJobs;

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
              'কাজ',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'সব কাজের তালিকা',
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

  // Search Input Field
  Widget _buildSearchBar() {
    return AppTextField(
      controller: searchController,
      hint: 'কাজ বা ক্লায়েন্টের নাম খুঁজুন',
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
              'কাজ শেষ হলেও বাকি টাকা এখানে দেখা যাবে।',
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
