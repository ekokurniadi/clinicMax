import 'package:clinic_max/app/data/constant/assets_constant.dart';
import 'package:clinic_max/app/data/models/dashboard/menu_model.dart';
import 'package:clinic_max/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final List<MenuModel> menuList = [
    MenuModel(
      icons: AssetsConstant.svgIconBookAppointment,
      menuTitle: 'Book Appointment',
      route: Routes.APPOINTMENT,
    ),
    MenuModel(
      icons: AssetsConstant.svgIconViewAppointment,
      menuTitle: 'View Appointment',
      route: Routes.APPOINTMENT_LIST,
    ),
    MenuModel(
      icons: AssetsConstant.svgIconCheckin,
      menuTitle: 'Check-In',
      route: Routes.CHECKIN,
    ),
    MenuModel(
      icons: AssetsConstant.svgIconQueueStatus,
      menuTitle: 'Queue Status',
      route: Routes.QUEUE_STATUS,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
