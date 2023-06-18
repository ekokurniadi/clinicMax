import 'dart:io';

import 'package:clinic_max/app/data/config/app_config.dart';
import 'package:clinic_max/app/data/models/users/users_model.dart';
import 'package:clinic_max/app/data/providers/supabase/user_supabase_provider.dart';
import 'package:clinic_max/app/data/utils/sessions/session.dart';
import 'package:clinic_max/app/data/utils/toast/toast.dart';
import 'package:clinic_max/app/data/utils/widgets/loading.dart';
import 'package:clinic_max/app/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class AccountController extends GetxController {
  final userModel = UsersModel().obs;
  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final icNumberController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final dobController = TextEditingController().obs;
  final genderController = TextEditingController().obs;
  final imageFile = File('').obs;
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

  Future<void> setImage(XFile file) async {
    LoadingApp.show();
    imageFile.value = File(file.path);
    final url = await UserSupabaseProvider.uploadProfilePicture(
      imageFile.value,
    );
    userModel.value.imageUrl = url;
    LoadingApp.dismiss();
  }

  void setGender(String gender) {
    genderController.value.text = gender;
  }

  Future<void> updateUser() async {
    try {
      LoadingApp.show();
      final user = UsersModel(
        id: userModel.value.id,
        name: nameController.value.text,
        email: userModel.value.email,
        icNumber: icNumberController.value.text,
        address: addressController.value.text,
        dob: dobController.value.text,
        gender: genderController.value.text,
        imageUrl: userModel.value.imageUrl,
        phone: phoneController.value.text,
        firebaseUid: userModel.value.firebaseUid,
        provider: userModel.value.provider,
      );

      await UserSupabaseProvider.updateUser(user);
      LoadingApp.dismiss();
      Toast.showSuccessToast('Update Profile Success');
    } catch (e) {
      LoadingApp.dismiss();
      Toast.showErrorToast('Update Profile Failed');
    }
  }
}
