import 'package:clinic_max/app/data/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/queue_status_controller.dart';

class QueueStatusView extends GetView<QueueStatusController> {
  const QueueStatusView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.white,
        appBar: AppBar(
          backgroundColor: ColorConstant.primaryColor,
          title: Text(
            'Queue Status',
            style: TextStyle(
              fontSize: 24.sp,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 64),
              Text(
                'Queue Now',
                style: TextStyle(
                  fontSize: 24.sp,
                  color: ColorConstant.darkBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Obx(() {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ColorConstant.primaryColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: ColorConstant.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            controller.queueStatus.value.queueNumber
                                .toString()
                                .padLeft(3, '0'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 60.sp,
                                color: ColorConstant.primaryColor,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 24),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Visibility(
                        visible: controller.appointment.value.queueNumber >=
                            controller.queueStatus.value.queueNumber,
                        child: Text(
                          'Your Queue Number : ${controller.appointment.value.queueNumber}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: ColorConstant.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: controller.appointment.value.queueNumber >=
                            controller.queueStatus.value.queueNumber,
                        child: Text(
                          'Duration : ${controller.differenceTime.value}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: ColorConstant.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 32),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                color: ColorConstant.primaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Announcement',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: ColorConstant.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
