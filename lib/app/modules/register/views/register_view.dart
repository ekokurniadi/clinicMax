import 'package:clinic_max/app/data/constant/assets_constant.dart';
import 'package:clinic_max/app/data/constant/color_constant.dart';
import 'package:clinic_max/app/modules/register/controllers/register_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorConstant.greyColor,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Obx(() {
              return Form(
                key: controller.formKey.value,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Image.asset(
                        AssetsConstant.clinicMaxLogo,
                        width: MediaQuery.of(context).size.height * 0.10,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Register Completion',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Flexible(
                      child: Center(
                        child: ZoomTapAnimation(
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
                                            final image =
                                                await picker.pickImage(
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
                                            final image =
                                                await picker.pickImage(
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
                            width: 80.w,
                            height: 80.w,
                            decoration: BoxDecoration(
                              color: ColorConstant.blueShade,
                              shape: BoxShape.circle,
                            ),
                            child: controller.imageUrl.value == ''
                                ? Icon(Icons.upload)
                                : controller.imageFile.value.path == ''
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          controller.imageUrl.value,
                                          fit: BoxFit.cover,
                                        ))
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.file(
                                          controller.imageFile.value,
                                          fit: BoxFit.cover,
                                        )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: double.infinity,
                      child: TextFormField(
                        controller: controller.nameController.value,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Name cannot empty';
                          }
                          return null;
                        },
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Name',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(),
                          label: Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: double.infinity,
                      child: TextFormField(
                        controller: controller.emailController.value,
                        readOnly: true,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Email cannot empty';
                          } else if (!EmailValidator.validate(val)) {
                            return 'Email not valid';
                          }
                          return null;
                        },
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(),
                          label: Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: double.infinity,
                      child: TextFormField(
                        controller: controller.phoneController.value,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Phone cannot empty';
                          }
                          return null;
                        },
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Phone',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(),
                          label: Text(
                            'Phone',
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: double.infinity,
                      child: TextFormField(
                        controller: controller.icNumberController.value,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'IC Number cannot empty';
                          }
                          return null;
                        },
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                        decoration: InputDecoration(
                          hintText: 'IC Number',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(),
                          label: Text(
                            'IC Number',
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: double.infinity,
                      child: TextFormField(
                        controller: controller.addressController.value,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Address cannot empty';
                          }
                          return null;
                        },
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Address',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(),
                          label: Text(
                            'Address',
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: double.infinity,
                      child: TextFormField(
                        onTap: () async {
                          await showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                        readOnly: true,
                        controller: controller.genderController.value,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Gender cannot empty';
                          }
                          return null;
                        },
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Gender',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(),
                          label: Text(
                            'Gender',
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: double.infinity,
                      child: TextFormField(
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
                        readOnly: true,
                        controller: controller.dobController.value,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Date of birthday cannot empty';
                          }
                          return null;
                        },
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Date of birthday',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(),
                          label: Text(
                            'Date of birthday',
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.primaryColor,
                      ),
                      onPressed: () async {
                        if (controller.formKey.value.currentState!.validate()) {
                          await controller.register();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
