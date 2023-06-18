import 'package:clinic_max/app/data/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingApp {
  const LoadingApp._();

  static void show({String message = ""}) {
    EasyLoading.show(
      indicator: LoadingAnimationWidget.discreteCircle(
        color: ColorConstant.primaryColor,
        size: 48,
        secondRingColor: Colors.red,
        thirdRingColor: Colors.yellow,
      ),
      status: message,
      maskType: EasyLoadingMaskType.black,
    );
  }

  static void showError({String message = ""}) {
    EasyLoading.showError(
      message,
      duration: const Duration(seconds: 2),
      maskType: EasyLoadingMaskType.black,
    );
  }

  static void showSuccess({String message = ""}) {
    EasyLoading.showSuccess(
      message,
      duration: const Duration(seconds: 2),
      maskType: EasyLoadingMaskType.black,
    );
  }

  static void dismiss() {
    EasyLoading.dismiss();
  }
}