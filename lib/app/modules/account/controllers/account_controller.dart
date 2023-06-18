import 'package:clinic_max/app/data/config/app_config.dart';
import 'package:clinic_max/app/data/models/users/users_model.dart';
import 'package:clinic_max/app/data/providers/supabase/user_supabase_provider.dart';
import 'package:clinic_max/app/data/utils/sessions/session.dart';
import 'package:clinic_max/app/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AccountController extends GetxController {
  final userModel = UsersModel().obs;
  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final icNumberController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final dobController = TextEditingController().obs;
  final genderController = TextEditingController().obs;
  @override
  Future<void> onInit() async {
    await getUserFromRemote();
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

  Future<void> getUserFromRemote() async {
    final user = await SessionPref.getUser();
    final response = await UserSupabaseProvider.getUserByEmail(user!.email!);

    if (response != null) {
      userModel.value = response;
    }
  }

  Future<void> logout() async {
    await AppConfig.firebaseAuth.signOut();
    await AppConfig.sharedPreferences.clear();
    GoogleSignIn().disconnect();
    await Get.offNamed(Routes.LOGIN);
  }

  void setDob(DateTime? date) {
    dobController.value.text = date.toString().split(' ')[0];
  }

  void setGender(String gender) {
    genderController.value.text = gender;
  }
}
