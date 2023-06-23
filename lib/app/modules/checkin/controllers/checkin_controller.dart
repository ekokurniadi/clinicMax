import 'dart:convert';

import 'package:clinic_max/app/data/models/appointment/appointment_model.dart';
import 'package:clinic_max/app/data/models/queue/queue_model.dart';
import 'package:clinic_max/app/data/providers/appointment/appointment_provider.dart';
import 'package:clinic_max/app/data/providers/queue/queue_provider.dart';
import 'package:clinic_max/app/data/utils/sessions/session.dart';
import 'package:clinic_max/app/data/utils/toast/toast.dart';
import 'package:clinic_max/app/data/utils/widgets/loading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CheckinController extends GetxController {
  final appointmentModel = AppointmentModel(
    id: 0,
    clinicId: 0,
    appointmentDate: '',
    appointmentTime: '',
    isFromKiosk: false,
    userId: 0,
    queueNumber: 0,
  ).obs;

  final isScanning = false.obs;

  final cameraController = MobileScannerController().obs;

  @override
  Future<void> onInit() async {
    try {
      LoadingApp.show();
      await getCurrentAppointment();
      LoadingApp.dismiss();
    } catch (e) {
      LoadingApp.dismiss();
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    appointmentModel.value = AppointmentModel(
      id: 0,
      clinicId: 0,
      appointmentDate: '',
      appointmentTime: '',
      isFromKiosk: false,
      userId: 0,
      queueNumber: 0,
    );
    cameraController.close();
    super.onClose();
  }

  Future<void> getCurrentAppointment() async {
    final user = await SessionPref.getUser();

    final data = await AppointmentProvider.getCurrentAppointment(user!);

    if (data != null) {
      appointmentModel.value = data;
    }
  }

  int parsingTimeToInt(String time) {
    return int.parse(time.replaceAll(':', ''));
  }

  Future<void> checkin(String scannedBarcode) async {
    if (isScanning.value) return;

    try {
      isScanning.value = true;

      final listId = jsonDecode(scannedBarcode);
      if (listId.contains(appointmentModel.value.id)) {
        final bookingTime = DateTime.parse(
          '${appointmentModel.value.appointmentDate} ${appointmentModel.value.appointmentTime}',
        );
        final currentTime = DateTime.now();
        final timeDifference = bookingTime.difference(currentTime);

        if (timeDifference.inMinutes > 0 && timeDifference.inMinutes <= 15) {
          LoadingApp.show();
          await _setInitialCounter();

          final bookedAppointment =
              await AppointmentProvider.getAppointmentsChecked(
            date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
            clinicId: appointmentModel.value.clinicId,
          );

          if (bookedAppointment.isNotEmpty) {
            final counter = bookedAppointment[0].queueNumber + 1;
            await _setCounterForAppointment(counter);
          } else {
            final counter = 1;
            await _setCounterForAppointment(counter);
          }

          Toast.showSuccessToast(
            'Success',
          );
          LoadingApp.dismiss();
          appointmentModel.value = AppointmentModel(
            id: 0,
            clinicId: 0,
            appointmentDate: '',
            appointmentTime: '',
            isFromKiosk: false,
            userId: 0,
            queueNumber: 0,
          );
          Get.back();
        } else if (timeDifference.isNegative) {
          Toast.showErrorToast(
            'Booking time has passed',
          );
        } else {
          Toast.showErrorToast(
            'You can only check-in a maximum of 15 minutes before booking time',
          );
        }
      } else {
        Toast.showErrorToast(
          'You dont have an active Appointment',
        );
      }
      isScanning.value = false;
    } catch (e) {
      Toast.showErrorToast(
        e.toString(),
      );
      isScanning.value = false;
      LoadingApp.dismiss();
    }
  }

  Future<void> _setInitialCounter() async {
    final getQueue = await QueueProvider.getQueueByClinic(
      appointmentModel.value.clinicId,
    );

    if (getQueue == null) {
      await QueueProvider.insertQueueOnClinic(
        appointmentModel.value.clinicId,
        QueueModel(
          clinicId: appointmentModel.value.clinicId,
          queueNumber: 1,
          lastUpdate: DateTime.now(),
          id: 0,
        ),
      );
    } else {
      final getDiff = getDateDifference(getQueue.lastUpdate, DateTime.now());

      if (getDiff > 0) {
        // set counter initial
        await QueueProvider.resetQueueOnClinic(getQueue);
      }
    }
  }

  int getDateDifference(DateTime from, DateTime to) {
    final newFrom = DateTime(from.year, from.month, from.day);
    final newTo = DateTime(to.year, to.month, to.day);

    return newTo.difference(newFrom).inDays;
  }

  Future<void> _setCounterForAppointment(int counter) async {
    final checkInTime = DateTime.now();
    final result = await AppointmentProvider.updateCheckinTime(
      id: appointmentModel.value.id,
      counter: counter,
      checkinTime: DateFormat('yyyy-MM-dd HH:mm:ss').format(checkInTime),
    );

    if (result) {
      Toast.showSuccessToast('Check in success');
    } else {
      Toast.showErrorToast('Check in failed, please try again');
    }
  }
}
