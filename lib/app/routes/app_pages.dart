import 'package:get/get.dart';

import '../modules/account/bindings/account_binding.dart';
import '../modules/account/views/account_view.dart';
import '../modules/appointment.list/bindings/appointment_list_binding.dart';
import '../modules/appointment.list/views/appointment_list_view.dart';
import '../modules/appointment/bindings/appointment_binding.dart';
import '../modules/appointment/views/appointment_form.dart';
import '../modules/appointment/views/appointment_view.dart';
import '../modules/checkin/bindings/checkin_binding.dart';
import '../modules/checkin/views/checkin_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main_menu/bindings/main_menu_binding.dart';
import '../modules/main_menu/views/main_menu_view.dart';
import '../modules/medical.record/bindings/medical_record_binding.dart';
import '../modules/medical.record/views/medical_record_view.dart';
import '../modules/medical_record_detail/bindings/medical_record_detail_binding.dart';
import '../modules/medical_record_detail/views/medical_record_detail_view.dart';
import '../modules/queue.status/bindings/queue_status_binding.dart';
import '../modules/queue.status/views/queue_status_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.APPOINTMENT,
      page: () => const AppointmentView(),
      binding: AppointmentBinding(),
    ),
    GetPage(
      name: _Paths.MEDICAL_RECORD,
      page: () => const MedicalRecordView(),
      binding: MedicalRecordBinding(),
    ),
    GetPage(
      name: _Paths.MEDICAL_RECORD_DETAIL,
      page: () => const MedicalRecordDetailView(),
      binding: MedicalRecordDetailBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => const AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_MENU,
      page: () => const MainMenuView(),
      binding: MainMenuBinding(),
    ),
    GetPage(
      name: _Paths.APPOINTMENT_LIST,
      page: () => const AppointmentListView(),
      binding: AppointmentListBinding(),
    ),
    GetPage(
      name: _Paths.CHECKIN,
      page: () => const CheckinView(),
      binding: CheckinBinding(),
    ),
    GetPage(
      name: _Paths.QUEUE_STATUS,
      page: () => const QueueStatusView(),
      binding: QueueStatusBinding(),
    ),
    GetPage(
      name: _Paths.APPOINMENT_FORM,
      page: () => const AppointmentForm(),
      binding: AppointmentBinding(),
    ),
  ];
}
