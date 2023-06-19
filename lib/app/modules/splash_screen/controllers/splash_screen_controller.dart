import 'package:clinic_max/app/data/models/users/users_model.dart';
import 'package:clinic_max/app/data/utils/sessions/session.dart';
import 'package:clinic_max/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  final count = 0.obs;
  final appName = "ClinicMax".obs;

  @override
  Future<void> onInit() async {
    final user = await checkUserLogin();

    if (user == null) {
      Future.delayed(const Duration(seconds: 3), () {
        Get.offNamed(Routes.LOGIN);
      });
    } else {
      if (user.id != null ||
          user.id != 0 ||
          user.icNumber != null ||
          user.icNumber != '') {
        Future.delayed(const Duration(seconds: 3), () {
          Get.offNamed(Routes.MAIN_MENU);
        });
      }
    }

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

  void increment() => count.value++;

  Future<UsersModel?> checkUserLogin() async {
    final user = await SessionPref.getUser();
    return user;
  }
}
