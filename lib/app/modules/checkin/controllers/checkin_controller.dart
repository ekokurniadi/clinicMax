import 'dart:convert';

import 'package:clinic_max/app/data/models/appointment/appointment_model.dart';
import 'package:clinic_max/app/data/models/queue/queue_model.dart';
import 'package:clinic_max/app/data/providers/appointment/appointment_provider.dart';
import 'package:clinic_max/app/data/providers/queue/queue_provider.dart';
import 'package:clinic_max/app/data/utils/sessions/session.dart';
import 'package:clinic_max/app/data/utils/toast/toast.dart';
import 'package:clinic_max/app/data/utils/widgets/loading.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CheckinController extends GetxController {
  final appointmentModel = AppointmentModel(
    id: 0,
    clinicId: 0,
    email: '',
    appointmentDate: '',
    appointmentTime: '',
    isFromKiosk: false,
    userId: 0,
    queueNumber: 0,
  ).obs;

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
    final List<int> listId = jsonDecode(scannedBarcode);
    final user = await SessionPref.getUser();

    if (listId.contains(appointmentModel.value.id)) {
      final bookingTime = DateTime.parse(
        '${appointmentModel.value.appointmentDate} ${appointmentModel.value.appointmentTime}',
      );

      final currentTime = DateTime.now();

      final timeDifference = bookingTime.difference(currentTime);

      if (timeDifference.inMinutes >= 0 && timeDifference.inMinutes <= 15) {
        final updateCheckinTime = await AppointmentProvider.updateCheckinTime(
          appointmentModel.value.id,
        );

        if (updateCheckinTime) {
          final getQueue = await QueueProvider.getQueueByClinic(
            appointmentModel.value.clinicId,
          );

          if (getQueue == null) {
            final insertQueue = await QueueProvider.insertQueueOnClinic(
              appointmentModel.value.clinicId,
              QueueModel(
                clinicId: appointmentModel.value.clinicId,
                queueNumber: 1,
                lastUpdate: DateTime.now(),
                queueDate: DateTime.now(),
                id: 0,
              ),
            );
          }
        }
      } else if (timeDifference.isNegative) {
        Toast.showErrorToast(
          'Booking time has passed',
        );
      } else {
        Toast.showErrorToast(
          'You can only check-in a maximum of 15 minutes before booking time',
        );
      }
      print('checkin');
    } else {
      print('dont have appointment');
    }
  }
}
