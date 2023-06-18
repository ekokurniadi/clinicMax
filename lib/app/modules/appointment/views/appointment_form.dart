import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:clinic_max/app/data/constant/color_constant.dart';
import 'package:clinic_max/app/data/models/clinic/clinic_model.dart';
import 'package:clinic_max/app/data/models/states/states_model.dart';
import 'package:clinic_max/app/modules/appointment/controllers/appointment_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AppointmentForm extends StatefulWidget {
  const AppointmentForm({
    super.key,
  });

  @override
  State<AppointmentForm> createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  late AppointmentController appointmentController;

  @override
  void initState() {
    appointmentController = Get.put(AppointmentController());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        title: Text(
          'Make Appointment',
          style: TextStyle(
            fontSize: 24.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Container(
                child: Row(
                  children: [
                    Text(
                      'User Name : ',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: ColorConstant.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Obx(() {
                      return Text(
                        appointmentController.isForOther.value
                            ? appointmentController.otherUser.value.name ?? ''
                            : appointmentController.userModel.value.name ?? '',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: ColorConstant.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              CalendarTimeline(
                initialDate: DateTime.now().add(Duration(
                    days: DateTime.now().weekday == DateTime.saturday
                        ? 2
                        : DateTime.now().weekday == DateTime.sunday
                            ? 1
                            : 0)),
                firstDate: DateTime.now().add(Duration(
                    days: DateTime.now().weekday == DateTime.saturday
                        ? 2
                        : DateTime.now().weekday == DateTime.sunday
                            ? 1
                            : 0)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                onDateSelected: (date) =>
                    appointmentController.selectedDateTime(date),
                leftMargin: 2,
                monthColor: Colors.blueGrey,
                dayColor: ColorConstant.primaryColor,
                activeDayColor: Colors.white,
                activeBackgroundDayColor: ColorConstant.primaryColor,
                dotsColor: Color(0xFF333A47),
                selectableDayPredicate: (date) {
                  if (date.weekday == DateTime.saturday ||
                      date.weekday == DateTime.sunday) {
                    return false;
                  }
                  return true;
                },
                locale: 'en_ISO',
              ),
              const SizedBox(height: 16),
              const Divider(),
              Obx(() {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorConstant.blueShade,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        child: PopupMenuButton<StatesModel>(
                          itemBuilder: (context) {
                            return appointmentController.listStates
                                .map(
                                  (states) => PopupMenuItem(
                                    value: states,
                                    child: Text(states.name),
                                  ),
                                )
                                .toList();
                          },
                          onSelected: (value) {
                            appointmentController.setSelectedStates(value);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    appointmentController
                                        .selectedStates.value.name,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 16.sp,
                                      color: ColorConstant.blackColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorConstant.blueShade,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        child: PopupMenuButton<ClinicModel>(
                          itemBuilder: (context) {
                            return appointmentController.listClinic
                                .map(
                                  (states) => PopupMenuItem(
                                    value: states,
                                    child: Text(states.name),
                                  ),
                                )
                                .toList();
                          },
                          onSelected: (value) {
                            if (appointmentController.listClinic.isNotEmpty) {
                              appointmentController.setSelectedClinic(value);
                            } else {
                              appointmentController
                                  .setSelectedClinic(ClinicModel.initial());
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    appointmentController.listClinic.isNotEmpty
                                        ? appointmentController
                                            .selectedClinic.value.name
                                        : '',
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 16.sp,
                                      color: ColorConstant.blackColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(height: 16.h),
              Text(
                'Morning Slots',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: ColorConstant.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16.h),
              Obx(() {
                return appointmentController.timeSlots.value.slots.isNotEmpty
                    ? GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          mainAxisExtent: 30,
                        ),
                        itemCount: appointmentController.timeSlots.value.slots
                            .where((element) =>
                                int.parse(element.time.split(':')[0]) < 12)
                            .toList()
                            .length,
                        itemBuilder: (context, index) {
                          final data = appointmentController
                              .timeSlots.value.slots[index];

                          return Obx(() {
                            final booked = appointmentController.bookedSlotList
                                .contains(data.time);
                            return ZoomTapAnimation(
                              onTap: () {
                                if (!booked) {
                                  appointmentController
                                      .setSelectedTime('${data.time}');
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: appointmentController
                                              .selectedTime.value ==
                                          '${data.time}'
                                      ? Colors.amber
                                      : booked
                                          ? ColorConstant.blueShade
                                          : ColorConstant.primaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    '${data.time}',
                                    style: TextStyle(
                                      color: ColorConstant.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                      )
                    : Center(
                        heightFactor: MediaQuery.of(context).size.height / 40,
                        child: Text('Time slot not found'),
                      );
              }),
              SizedBox(height: 16.h),
              Text(
                'Afternoon Slots',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: ColorConstant.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16.h),
              Obx(() {
                return appointmentController.timeSlots.value.slots.isNotEmpty
                    ? GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          mainAxisExtent: 30,
                        ),
                        itemCount: appointmentController.timeSlots.value.slots
                            .where((element) =>
                                int.parse(element.time.split(':')[0]) >= 12)
                            .toList()
                            .length,
                        itemBuilder: (context, index) {
                          final data = appointmentController
                              .timeSlots.value.slots
                              .where((element) =>
                                  int.parse(element.time.split(':')[0]) >= 12)
                              .toList()[index];

                          return Obx(() {
                            final booked = appointmentController.bookedSlotList
                                .contains(data.time);

                            return ZoomTapAnimation(
                              onTap: () {
                                if (!booked) {
                                  appointmentController
                                      .setSelectedTime('${data.time}');
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: appointmentController
                                              .selectedTime.value ==
                                          '${data.time}'
                                      ? Colors.amber
                                      : booked
                                          ? ColorConstant.blueShade
                                          : ColorConstant.primaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    '${data.time}',
                                    style: TextStyle(
                                      color: ColorConstant.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                      )
                    : Center(
                        heightFactor: MediaQuery.of(context).size.height / 40,
                        child: Text('Time slot not found'),
                      );
              }),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: ElevatedButton(
          style:
              ElevatedButton.styleFrom(backgroundColor: ColorConstant.darkBlue),
          onPressed: () async {
            await AwesomeDialog(
                context: context,
                dialogType: DialogType.info,
                btnOk: ElevatedButton(
                  onPressed: () async{
                    Get.back();
                    await appointmentController.createAppointment();
                  },
                  child: Text('Yes'),
                ),
                btnCancel: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('No'),
                ),
                body: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Confirm Booking?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: ColorConstant.primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                          'Date : ${DateFormat('dd-MM-yyyy').format(appointmentController.selectedDateTime.value)}'),
                      const Divider(),
                      Text(
                          'Time : ${appointmentController.selectedTime.value}'),
                      const Divider(),
                      Text(
                          'Clinic Name : ${appointmentController.selectedClinic.value.name}'),
                      const Divider(),
                      Text(
                          'Patient Name : ${!appointmentController.isForOther.value ? appointmentController.userModel.value.name : appointmentController.otherUser.value.name}'),
                    ],
                  ),
                )).show();
            
          },
          child: Text('Save Appointment'),
        ),
      ),
    );
  }
}
