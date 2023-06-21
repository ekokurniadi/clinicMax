import 'package:clinic_max/app/data/constant/assets_constant.dart';
import 'package:clinic_max/app/data/constant/color_constant.dart';
import 'package:clinic_max/app/modules/login/views/create_an_account.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
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
                      'Login',
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
                          controller.formKey.value.currentState!.validate();
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
                          controller.formKey.value.currentState!.validate();
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.primaryColor,
                      ),
                      onPressed: () async {
                        if (controller.formKey.value.currentState!.validate()) {
                          await controller.handleSinginWIthEmailAndPassword();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'Login',
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
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dont Have an account?',
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await Get.to(() => CreateAnAccount());
                          },
                          child: Text(
                            'Create one',
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
                    Center(
                        child: Text(
                      'or',
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    )),
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.white,
                      ),
                      onPressed: () async {
                        await controller.handleSigninWithEmail();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AssetsConstant.iconGoogle,
                              width: 20.w,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Signin / Signup with Google',
                              style: TextStyle(
                                color: ColorConstant.blackColor,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
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
