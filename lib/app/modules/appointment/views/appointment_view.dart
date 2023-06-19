import 'package:clinic_max/app/data/constant/color_constant.dart';
import 'package:clinic_max/app/modules/appointment/views/appointment_form.dart';
import 'package:clinic_max/app/routes/app_pages.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../controllers/appointment_controller.dart';

class AppointmentView extends GetView<AppointmentController> {
  const AppointmentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: ColorConstant.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        title: Text(
          'Book Appointment',
          style: TextStyle(
            fontSize: 24.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 32.h,
              ),
              Text(
                'Who are you Booking for?',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorConstant.darkBlue,
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              ZoomTapAnimation(
                onTap: () {
                  controller.isForOther.value = false;
                  Get.toNamed(Routes.APPOINTMENT_FORM);
                },
                child: Container(
                  width: 200.w,
                  height: 200.w,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstant.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 74.sp,
                        color: ColorConstant.primaryColor,
                      ),
                      Text(
                        'Book for Yourself',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorConstant.darkBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              Text(
                'OR',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorConstant.darkBlue,
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              ZoomTapAnimation(
                onTap: () async {
                  await showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Form(
                          key: _formKey,
                          child: Container(
                            color: Colors.white,
                            padding: MediaQuery.of(context).viewInsets,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Please insert this form'),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Flexible(
                                    child: TextFormField(
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return 'Name is required';
                                        }

                                        return null;
                                      },
                                      controller:
                                          controller.nameController.value,
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
                                    height: 16.h,
                                  ),
                                  Flexible(
                                    child: TextFormField(
                                      validator: (val) {
                                        if (!EmailValidator.validate(val!)) {
                                          return 'Email is invalid';
                                        }

                                        return null;
                                      },
                                      controller:
                                          controller.emailController.value,
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
                                    height: 16.h,
                                  ),
                                  Flexible(
                                    child: TextFormField(
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return 'IC Number is required';
                                        }

                                        return null;
                                      },
                                      controller:
                                          controller.icNumberController.value,
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
                                    height: 16.h,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          ColorConstant.primaryColor,
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        Navigator.pop(context);
                                        await controller
                                            .addAppointmentForOthers();
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
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
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  width: 200.w,
                  height: 200.w,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstant.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.groups,
                        size: 74.sp,
                        color: ColorConstant.primaryColor,
                      ),
                      Text(
                        'Help Others to Book',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorConstant.darkBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
