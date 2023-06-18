import 'dart:io';

import 'package:clinic_max/app/data/models/users/users_model.dart';
import 'package:clinic_max/app/data/providers/supabase/user_supabase_provider.dart';
import 'package:clinic_max/app/data/utils/sessions/session.dart';
import 'package:clinic_max/app/data/utils/toast/toast.dart';
import 'package:clinic_max/app/data/utils/widgets/loading.dart';
import 'package:clinic_max/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterController extends GetxController {
  final emailController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final icNumberController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final dobController = TextEditingController().obs;
  final genderController = TextEditingController().obs;
  final id = 0.obs;
  final firebaseUid =''.obs;
  final formKey = GlobalKey<FormState>().obs;
  final imageUrl = ''.obs;
  final imageFile = File('').obs;
  final provider =''.obs;
  @override
  void onInit() {
    final arg = Get.arguments['user'];
    final user = UsersModel.fromJson(arg);
    nameController.value.text = user.name ?? '';
    emailController.value.text = user.email ?? '';
    phoneController.value.text = user.phone ?? '';
    icNumberController.value.text = user.icNumber ?? '';
    addressController.value.text = user.address ?? '';
    dobController.value.text = user.dob ?? '';
    genderController.value.text = user.gender ?? '';
    id.value = user.id ?? 0;
    firebaseUid.value = user.firebaseUid ?? '';
    imageUrl.value = user.imageUrl ?? '';
    provider.value= user.provider ?? '';
    super.onInit();
  }

  void setDob(DateTime? date) {
    dobController.value.text = date.toString().split(' ')[0];
  }

  void setGender(String? gender) {
    genderController.value.text = gender ?? 'Male';
  }

  Future<void> setImage(XFile file) async {
    LoadingApp.show();
    imageFile.value = File(file.path);
    final url = await UserSupabaseProvider.uploadProfilePicture(
      imageFile.value,
    );
    imageUrl.value = url!;
    LoadingApp.dismiss();
  }

  Future<void> register() async {
    LoadingApp.show();
    final userModel = UsersModel(
      name: nameController.value.text,
      email: emailController.value.text,
      phone: phoneController.value.text,
      address: addressController.value.text,
      dob: dobController.value.text,
      gender: genderController.value.text,
      icNumber: icNumberController.value.text,
      imageUrl: imageUrl.value,
      id: id.value,
      firebaseUid: firebaseUid.value,
      provider: provider.value,
    );
    final userUpdated = await UserSupabaseProvider.updateUser(userModel);
    await SessionPref.saveUserToPref(userUpdated);
    LoadingApp.dismiss();
    Toast.showSuccessToast('Register Success');
    Get.offNamed(Routes.MAIN_MENU);
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
