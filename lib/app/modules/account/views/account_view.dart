import 'package:clinic_max/app/data/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../controllers/account_controller.dart';

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 24.sp,
          ),
        ),
        actions: [
          PopupMenuButton(
            offset: Offset(0, 50),
            child: Icon(
              Icons.settings,
              size: 24.sp,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ];
            },
            onSelected: (val) async {
              if (val == 'logout') {
                await controller.logout();
              }
            },
          ),
          SizedBox(width: 16)
        ],
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 32.h,
                ),
                ZoomTapAnimation(
                  onTap: () async {
                    await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    'Select your profile picture',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ZoomTapAnimation(
                                  onTap: () async {
                                    final picker = await ImagePicker();
                                    final image = await picker.pickImage(
                                      source: ImageSource.gallery,
                                    );
                                    if (image != null) {
                                      await controller.setImage(image);
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Text('From Galery'),
                                  ),
                                ),
                                const Divider(),
                                ZoomTapAnimation(
                                  onTap: () async {
                                    final picker = await ImagePicker();
                                    final image = await picker.pickImage(
                                      source: ImageSource.camera,
                                    );
                                    if (image != null) {
                                      await controller.setImage(image);
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Text('From Camera'),
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          );
                        });
                  },
                  child: Container(
                    width: 130.w,
                    height: 130.w,
                    decoration: BoxDecoration(
                      color: ColorConstant.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: controller.userModel.value.imageUrl == '' ||
                              controller.userModel.value.imageUrl == null
                          ? Icon(Icons.people)
                          : Image.network(
                              controller.userModel.value.imageUrl!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                FormInputAccount(
                  icon: Icons.person,
                  label: 'Full Name',
                  inputController: controller.nameController.value,
                ),
                FormInputAccount(
                  readOnly: true,
                  icon: Icons.email,
                  label: 'Email',
                  inputController: controller.emailController.value,
                ),
                FormInputAccount(
                  icon: Icons.phone,
                  label: 'Contact',
                  inputController: controller.phoneController.value,
                ),
                FormInputAccount(
                  icon: Icons.assignment_ind_outlined,
                  label: 'IC Number',
                  inputController: controller.icNumberController.value,
                ),
                FormInputAccount(
                  icon: Icons.location_on_outlined,
                  label: 'Address',
                  inputController: controller.addressController.value,
                ),
                FormInputAccount(
                  readOnly: true,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900, 1, 1),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      controller.setDob(date);
                    }
                  },
                  icon: Icons.date_range,
                  label: 'DOB',
                  inputController: controller.dobController.value,
                ),
                FormInputAccount(
                  onTap: () async {
                    await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    'Select your Gender',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ZoomTapAnimation(
                                  onTap: () {
                                    controller.setGender('Male');
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Text('Male'),
                                  ),
                                ),
                                const Divider(),
                                ZoomTapAnimation(
                                  onTap: () {
                                    controller.setGender('Female');
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Text('Female'),
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          );
                        });
                  },
                  icon: Icons.man,
                  label: 'Gender',
                  inputController: controller.genderController.value,
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),

                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red
                    ),
                    onPressed: () async {
                      await controller.updateUser();
                    },
                    child: Text('Update'),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class FormInputAccount extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController inputController;
  final void Function()? onTap;
  final bool readOnly;
  const FormInputAccount({
    super.key,
    required this.label,
    required this.icon,
    required this.inputController,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: ColorConstant.primaryColor,
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Icon(
                icon,
                size: 24.sp,
                color: Colors.white,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  cursorColor: Colors.white,
                  readOnly: readOnly,
                  controller: inputController,
                  onTap: onTap,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: ColorConstant.white,
                    fontSize: 16.sp,
                  ),
                  decoration: InputDecoration(
                    label: Text(
                      label,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: ColorConstant.white,
                        fontSize: 16.sp,
                      ),
                    ),
                    hintText: label,
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ColorConstant.white,
                      fontSize: 16.sp,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
