import 'dart:io';

import 'package:clinic_max/app/data/models/users/users_model.dart';
import 'package:clinic_max/app/data/providers/medical_records/medical_record_provider.dart';
import 'package:clinic_max/app/data/providers/supabase/user_supabase_provider.dart';
import 'package:clinic_max/app/data/utils/sessions/session.dart';
import 'package:clinic_max/app/data/utils/toast/toast.dart';
import 'package:clinic_max/app/data/utils/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicalRecordController extends GetxController {
  final userModel = UsersModel().obs;
  final listMedicalRecord = <dynamic>[].obs;

  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final icNumberController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final dobController = TextEditingController().obs;
  final genderController = TextEditingController().obs;
  final bloodController = TextEditingController().obs;
  final heightController = TextEditingController().obs;
  final weightController = TextEditingController().obs;
  final imageFile = File('').obs;
  final age = 0.obs;
  final formKey = GlobalKey<FormState>().obs;

  @override
  Future<void> onInit() async {
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

  Future<void> getUserData() async {
    final user = await SessionPref.getUser();

    final result = await UserSupabaseProvider.getUserByEmail(user!.email ?? '');

    if (result != null) {
      userModel.value = result;
      nameController.value.text = userModel.value.name ?? '';
      icNumberController.value.text = userModel.value.icNumber ?? '';
      genderController.value.text = userModel.value.gender ?? '';
      dobController.value.text = userModel.value.dob ?? '';
      phoneController.value.text = userModel.value.phone ?? '';
      addressController.value.text = userModel.value.address ?? '';
      bloodController.value.text = userModel.value.bloodGroup ?? '';
      heightController.value.text = (userModel.value.height ?? '0').toString();
      weightController.value.text = (userModel.value.weight ?? '0').toString();
    }
  }

  Future<void> getMedicalRecord() async {
    final user = await SessionPref.getUser();

    final result = await MedicalRecordProvider.getMedicalRecord(user!.id ?? 0);

    if (result.isNotEmpty) {
      listMedicalRecord.value = result;
    }
  }

  void setDob(DateTime? date) {
    dobController.value.text = date.toString().split(' ')[0];
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
        icNumber: icNumberController.value.text.isEmpty
            ? userModel.value.icNumber
            : icNumberController.value.text,
        address: addressController.value.text,
        dob: dobController.value.text,
        gender: genderController.value.text,
        imageUrl: userModel.value.imageUrl,
        phone: phoneController.value.text,
        bloodGroup: bloodController.value.text,
        firebaseUid: userModel.value.firebaseUid,
        provider: userModel.value.provider,
        weight: double.tryParse(weightController.value.text) ?? 0.0,
        height: double.tryParse(heightController.value.text) ?? 0.0,
      );

      await UserSupabaseProvider.updateUserFromMedicalRecors(user);
      LoadingApp.dismiss();
      Toast.showSuccessToast('Update Success');
    } catch (e) {
      LoadingApp.dismiss();
      Toast.showErrorToast('Update Failed with ${e.toString()}');
    }
  }
}
