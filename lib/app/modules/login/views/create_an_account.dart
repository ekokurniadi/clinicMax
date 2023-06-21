import 'package:clinic_max/app/data/constant/assets_constant.dart';
import 'package:clinic_max/app/data/constant/color_constant.dart';
import 'package:clinic_max/app/modules/login/controllers/login_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class CreateAnAccount extends StatefulWidget {
  const CreateAnAccount({Key? key}) : super(key: key);

  @override
  State<CreateAnAccount> createState() => _CreateAnAccountState();
}

class _CreateAnAccountState extends State<CreateAnAccount> {
  late LoginController controller;

  @override
  void initState() {
    controller = Get.put(LoginController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorConstant.greyColor,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  Obx(() {
                    return Form(
                      key: controller.formKeyCreate.value,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: Image.asset(
                              AssetsConstant.clinicMaxLogo,
                              width: MediaQuery.of(context).size.height * 0.20,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Welcome Back',
                            style: TextStyle(
                              fontSize: 18.sp,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Create an Account',
                            style: TextStyle(
                              fontSize: 18.sp,
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Container(
                            width: double.infinity,
                            child: TextFormField(
                              controller: controller.emailController.value,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Email cannot empty';
                                } else if (!EmailValidator.validate(val)) {
                                  return 'Email not valid';
                                }
                                return null;
                              },
                              onChanged: (val) {
                                controller.formKeyCreate.value.currentState!
                                    .validate();
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
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Password cannot empty';
                                }

                                return null;
                              },
                              onChanged: (val) {
                                controller.formKeyCreate.value.currentState!
                                    .validate();
                              },
                              controller: controller.passwordController.value,
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                              obscureText: controller.obscureText.value,
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(),
                                  label: Text(
                                    'Password',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.togglePassword();
                                    },
                                    icon: Icon(
                                      controller.obscureText.value
                                          ? Icons.remove_red_eye
                                          : Icons.visibility_off,
                                      size: 18.sp,
                                    ),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            width: double.infinity,
                            child: TextFormField(
                              onChanged: (value) {
                                controller.formKeyCreate.value.currentState!
                                    .validate();
                              },
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Confirm Password cannot empty';
                                } else if (val !=
                                    controller.passwordController.value.text) {
                                  return 'Confirm Password not match';
                                }

                                return null;
                              },
                              controller:
                                  controller.passwordConfirmController.value,
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                              obscureText: controller.obscureTextConfirm.value,
                              decoration: InputDecoration(
                                  hintText: 'Confirm Password',
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(),
                                  label: Text(
                                    'Confirm Password',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.togglePasswordConfirm();
                                    },
                                    icon: Icon(
                                      controller.obscureTextConfirm.value
                                          ? Icons.remove_red_eye
                                          : Icons.visibility_off,
                                      size: 18.sp,
                                    ),
                                  )),
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
                              if (controller.formKeyCreate.value.currentState!
                                  .validate()) {
                                await controller.handleCreateAccount();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  'Create Account',
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
                          Center(
                              child: Text(
                            'or',
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          )),
                          Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Have an account?',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: ColorConstant.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          )),
                          SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
