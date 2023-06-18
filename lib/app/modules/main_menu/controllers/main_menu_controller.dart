import 'package:clinic_max/app/data/config/app_config.dart';
import 'package:clinic_max/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainMenuController extends GetxController {
  late PersistentTabController bottomNavcontroller;

  @override
  void onInit() {
    bottomNavcontroller = PersistentTabController(initialIndex: 0);
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

  Future<void> logout()async{
    await AppConfig.firebaseAuth.signOut();
    await AppConfig.sharedPreferences.clear();
    GoogleSignIn().disconnect();
    await Get.offNamed(Routes.LOGIN);
  }
}
