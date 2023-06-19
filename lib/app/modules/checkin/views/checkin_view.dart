import 'dart:typed_data';

import 'package:clinic_max/app/data/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../controllers/checkin_controller.dart';

class CheckinView extends GetView<CheckinController> {
  const CheckinView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: ColorConstant.blueShade,
        appBar: AppBar(
          title: Text(
            'Check in',
            style: TextStyle(
              fontSize: 24.sp,
            ),
          ),
          centerTitle: true,
          actions: [],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Scan QR Code & Check In',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: ColorConstant.darkBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    padding: const EdgeInsets.all(16),
                    child: MobileScanner(
                      controller: controller.cameraController.value,
                      onDetect: (capture) async {
                        final List<Barcode> barcodes = capture.barcodes;
                        if (barcodes.length > 0) {
                          await controller.checkin(barcodes.first.rawValue!);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.blackColor,
                        ),
                        child: Row(
                          children: [
                            ValueListenableBuilder(
                              valueListenable:
                                  controller.cameraController.value.torchState,
                              builder: (context, state, child) {
                                switch (state) {
                                  case TorchState.off:
                                    return const Icon(Icons.flash_off,
                                        color: Colors.white);
                                  case TorchState.on:
                                    return const Icon(Icons.flash_on,
                                        color: Colors.yellow);
                                }
                              },
                            ),
                            Text('Torch')
                          ],
                        ),
                        onPressed: () =>
                            controller.cameraController.value.toggleTorch(),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.blackColor,
                        ),
                        child: Row(
                          children: [
                            ValueListenableBuilder(
                              valueListenable: controller
                                  .cameraController.value.cameraFacingState,
                              builder: (context, state, child) {
                                switch (state) {
                                  case CameraFacing.front:
                                    return const Icon(Icons.camera_front);
                                  case CameraFacing.back:
                                    return const Icon(Icons.camera_rear);
                                }
                              },
                            ),
                            Text('Switch Camera')
                          ],
                        ),
                        onPressed: () =>
                            controller.cameraController.value.switchCamera(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
