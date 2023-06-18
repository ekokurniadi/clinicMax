import 'package:get/get.dart';

import '../controllers/appointment_list_controller.dart';

class AppointmentListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppointmentListController>(
      () => AppointmentListController(),
    );
  }
}
