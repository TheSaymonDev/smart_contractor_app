import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/modules/attendance/views/attendance_screen.dart';
import 'package:smart_contractor_app/modules/attendance/views/split_wage_screen.dart';
import 'package:smart_contractor_app/modules/auth/views/business_setup_screen.dart';
import 'package:smart_contractor_app/modules/auth/views/forgot_password_screen.dart';
import 'package:smart_contractor_app/modules/auth/views/log_in_screen.dart';
import 'package:smart_contractor_app/modules/auth/views/otp_verification_screen.dart';
import 'package:smart_contractor_app/modules/auth/views/registration_screen.dart';
import 'package:smart_contractor_app/modules/auth/views/reset_password_screen.dart';
import 'package:smart_contractor_app/modules/home/views/home_screen.dart';
import 'package:smart_contractor_app/modules/client/views/client_details_screen.dart';
import 'package:smart_contractor_app/modules/client/views/client_management_screen.dart';
import 'package:smart_contractor_app/modules/client/views/clients_screen.dart';
import 'package:smart_contractor_app/modules/job/views/client_payment_screen.dart';
import 'package:smart_contractor_app/modules/job/views/final_bill_pdf_preview_screen.dart';
import 'package:smart_contractor_app/modules/job/views/job_details_screen.dart';
import 'package:smart_contractor_app/modules/job/views/job_management_screen.dart';
import 'package:smart_contractor_app/modules/job/views/payment_receipt_pdf_preview_screen.dart';
import 'package:smart_contractor_app/modules/job/views/wage_and_expense_screen.dart';

import 'package:smart_contractor_app/modules/material/views/custom_template_create_screen.dart';
import 'package:smart_contractor_app/modules/material/views/direct_material_list_create_screen.dart';
import 'package:smart_contractor_app/modules/material/views/material_item_add_edit_screen.dart';
import 'package:smart_contractor_app/modules/material/views/material_items_list_screen.dart';
import 'package:smart_contractor_app/modules/material/views/material_pdf_info_screen.dart';
import 'package:smart_contractor_app/modules/material/views/material_pdf_preview_screen.dart';
import 'package:smart_contractor_app/modules/material/views/material_template_select_screen.dart';
import 'package:smart_contractor_app/modules/material/views/my_material_templates_screen.dart';
import 'package:smart_contractor_app/modules/material/views/my_template_details_screen.dart';
import 'package:smart_contractor_app/modules/material/views/same_materials_merge_screen.dart';

import 'package:smart_contractor_app/modules/main/views/main_screen.dart';
import 'package:smart_contractor_app/modules/more/views/generated_pdf_list_screen.dart';
import 'package:smart_contractor_app/modules/more/views/reports_screen.dart';
import 'package:smart_contractor_app/modules/more/views/settings_and_help_screen.dart';
import 'package:smart_contractor_app/modules/worker/views/bulk_worker_payment_screen.dart';
import 'package:smart_contractor_app/modules/worker/views/monthly_salary_adjustment_screen.dart';
import 'package:smart_contractor_app/modules/worker/views/worker_details_screen.dart';
import 'package:smart_contractor_app/modules/worker/views/worker_ledger_pdf_preview_screen.dart';
import 'package:smart_contractor_app/modules/worker/views/worker_management_screen.dart';
import 'package:smart_contractor_app/modules/worker/views/worker_payment_history_screen.dart';
import 'package:smart_contractor_app/modules/worker/views/worker_payment_screen.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.logInScreen, page: () => const LogInScreen()),
    GetPage(name: AppRoutes.registrationScreen, page: () => const RegistrationScreen()),
    GetPage(name: AppRoutes.businessSetupScreen, page: () => const BusinessSetupScreen()),
    GetPage(name: AppRoutes.forgotPasswordScreen, page: () => const ForgotPasswordScreen()),
    GetPage(name: AppRoutes.otpVerificationScreen, page: () => const OtpVerificationScreen()),
    GetPage(name: AppRoutes.resetPasswordScreen, page: () => const ResetPasswordScreen()),
    GetPage(name: AppRoutes.mainScreen, page: () => const MainScreen()),
    GetPage(name: AppRoutes.homeScreen, page: () => const HomeScreen()),
    GetPage(name: AppRoutes.jobManagementScreen, page: () => const JobManagementScreen()),
    GetPage(name: AppRoutes.workerManagementScreen, page: () => const WorkerManagementScreen()),
    GetPage(name: AppRoutes.workerDetailsScreen, page: () => const WorkerDetailsScreen()),
    GetPage(name: AppRoutes.jobDetailsScreen, page: () => const JobDetailsScreen()),
    GetPage(name: AppRoutes.attendanceScreen, page: () => const AttendanceScreen()),
    GetPage(name: AppRoutes.clientPaymentScreen, page: () => const ClientPaymentScreen()),
    GetPage(name: AppRoutes.wageAndExpenseScreen, page: () => const WageAndExpenseScreen()),
    GetPage(name: AppRoutes.splitWageScreen, page: () => const SplitWageScreen()),
    GetPage(name: AppRoutes.monthlySalaryAdjustmentScreen, page: () => const MonthlySalaryAdjustmentScreen()),
    GetPage(name: AppRoutes.workerPaymentScreen, page: () => const WorkerPaymentScreen()),
    GetPage(name: AppRoutes.bulkWorkerPaymentScreen, page: () => const BulkWorkerPaymentScreen()),
    GetPage(name: AppRoutes.workerPaymentHistoryScreen, page: () => const WorkerPaymentHistoryScreen()),
    GetPage(name: AppRoutes.clientsScreen, page: () => const ClientsScreen()),
    GetPage(name: AppRoutes.clientManagementScreen, page: () => const ClientManagementScreen()),
    GetPage(name: AppRoutes.clientDetailsScreen, page: () => const ClientDetailsScreen()),
    GetPage(name: AppRoutes.generatedPdfListScreen, page: () => const GeneratedPdfListScreen()),
    GetPage(name: AppRoutes.finalBillPdfPreviewScreen, page: () => const FinalBillPdfPreviewScreen()),
    GetPage(name: AppRoutes.paymentReceiptPdfPreviewScreen, page: () => const PaymentReceiptPdfPreviewScreen()),
    GetPage(name: AppRoutes.workerLedgerPdfPreviewScreen, page: () => const WorkerLedgerPdfPreviewScreen()),
    GetPage(name: AppRoutes.reportsScreen, page: () => const ReportsScreen()),
    GetPage(name: AppRoutes.settingsAndHelpScreen, page: () => const SettingsAndHelpScreen()),

    // Material Wizard Pages
    GetPage(
        name: AppRoutes.materialTemplateSelectScreen,
        page: () => const MaterialTemplateSelectScreen()),
    GetPage(
        name: AppRoutes.myMaterialTemplatesScreen,
        page: () => const MyMaterialTemplatesScreen()),
    GetPage(
        name: AppRoutes.myTemplateDetailsScreen,
        page: () => const MyTemplateDetailsScreen()),
    GetPage(
        name: AppRoutes.customTemplateCreateScreen,
        page: () => const CustomTemplateCreateScreen()),
    GetPage(
        name: AppRoutes.directMaterialListCreateScreen,
        page: () => const DirectMaterialListCreateScreen()),
    GetPage(
        name: AppRoutes.materialItemsListScreen,
        page: () => MaterialItemsListScreen()),
    GetPage(
        name: AppRoutes.materialItemAddEditScreen,
        page: () => const MaterialItemAddEditScreen()),
    GetPage(
        name: AppRoutes.sameMaterialsMergeScreen,
        page: () => const SameMaterialsMergeScreen()),
    GetPage(
        name: AppRoutes.materialPdfInfoScreen,
        page: () => const MaterialPdfInfoScreen()),
    GetPage(
        name: AppRoutes.materialPdfPreviewScreen,
        page: () => const MaterialPdfPreviewScreen()),
  ];
}
