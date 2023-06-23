import 'package:clinic_max/app/data/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/appointment_list_controller.dart';

class AppointmentListView extends GetView<AppointmentListController> {
  const AppointmentListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.blueShade,
        appBar: AppBar(
          backgroundColor: ColorConstant.primaryColor,
          title: Text(
            'View Your Appointment',
            style: TextStyle(
              fontSize: 24.sp,
            ),
          ),
          centerTitle: false,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Coming Appointment Details.',
                style: TextStyle(
                    fontSize: 18.sp,
                    color: ColorConstant.primaryColor,
                    fontWeight: FontWeight.w600),
              ),
              Obx(() {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.40,
                  padding: const EdgeInsets.all(16),
                  child: controller.listAppointment.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.listAppointment.length,
                          itemBuilder: (context, index) {
                            final appointmentData =
                                controller.listAppointment[index];
                            return Container(
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: ColorConstant.primaryColor,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: ColorConstant.darkBlue),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    appointmentData['appointments_date'] != ''
                                        ? 'Date : ${DateFormat('dd/MM/yyyy').format(DateTime.parse(appointmentData['appointment_date']))}'
                                        : '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  const Divider(),
                                  Text(
                                    'Time : ${appointmentData['appointment_time']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  const Divider(),
                                  Text(
                                    'Location : ${appointmentData['clinics']['address']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  const Divider(),
                                  Text(
                                    'Clinic Number : ${appointmentData['clinics']['contact']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  const Divider(),
                                  Text(
                                    'Patient Name : ${controller.userModel.value.name}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Divider(),
                                ],
                              ),
                            );
                          })
                      : Center(
                          child: Text(
                            'Not found',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                );
              }),
              Text(
                'Your History Appointment Details.',
                style: TextStyle(
                    fontSize: 18.sp,
                    color: ColorConstant.primaryColor,
                    fontWeight: FontWeight.w600),
              ),
              Obx(() {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.40,
                  padding: const EdgeInsets.all(16),
                  child: controller.listAppointmentHistory.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.listAppointmentHistory.length,
                          itemBuilder: (context, index) {
                            final historyData =
                                controller.listAppointmentHistory[index];
                            return Container(
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: ColorConstant.primaryColor,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: ColorConstant.darkBlue),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Date : ${DateFormat('dd/MM/yyyy').format(DateTime.parse(historyData['appointments']['appointment_date']))}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  const Divider(),
                                  Text(
                                    'Time : ${historyData['appointments']['appointment_time']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  const Divider(),
                                  Text(
                                    'Location : ${historyData['clinics']['address']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  const Divider(),
                                  Text(
                                    'Clinic Number : ${historyData['clinics']['contact']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  const Divider(),
                                  Text(
                                    'Patient Name : ${controller.userModel.value.name}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Divider(),
                                ],
                              ),
                            );
                          })
                      : Center(
                          child: Text(
                            'Not found',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                );
              }),
            ],
          ),
        ));
  }
}
