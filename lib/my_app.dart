import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_pages.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';


class MyApp extends StatelessWidget {
  final String? initialRoute;
  const MyApp({
    super.key,
    this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 758),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          theme: ThemeData(
            fontFamily: 'NotoSansBengali',
            scaffoldBackgroundColor: AppColors.background
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          getPages: AppPages.pages,
        );
      },
    );
  }
}