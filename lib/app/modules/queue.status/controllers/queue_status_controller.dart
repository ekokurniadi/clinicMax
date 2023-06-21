import 'dart:async';

import 'package:clinic_max/app/data/models/appointment/appointment_model.dart';
import 'package:clinic_max/app/data/models/queue/queue_model.dart';
import 'package:clinic_max/app/data/providers/appointment/appointment_provider.dart';
import 'package:clinic_max/app/data/providers/queue/queue_provider.dart';
import 'package:clinic_max/app/data/utils/sessions/session.dart';
import 'package:get/get.dart';

class QueueStatusController extends GetxController {
  final queueStatus = QueueModel(
    clinicId: 0,
    id: 0,
    lastUpdate: DateTime.now(),
    queueNumber: 0,
  ).obs;

  final appointment = AppointmentModel(
          id: 0,
          clinicId: 0,
          appointmentDate: '',
          appointmentTime: '',
          isFromKiosk: false,
          userId: 0,
          queueNumber: 0)
      .obs;

  StreamSubscription<QueueModel>? _connectionStreamSubscription;
  Timer? timer;

  final differenceTime = ''.obs;

  final count = 0.obs;
  final announces = <dynamic>[].obs;

  @override
  Future<void> onInit() async {
    final user = await SessionPref.getUser();
    final result =
        await AppointmentProvider.getCurrentAppointmentAlreadyCheckin(user!);
    if (result != null) {
      appointment.value = result;
      await streamQueueStatus(appointment.value.clinicId);
      await streamDuration();
    }

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    timer?.cancel();
    _connectionStreamSubscription?.cancel();
    super.onClose();
  }

  Future<void> streamQueueStatus(int clinicId) async {
    _connectionStreamSubscription =
        QueueProvider.streamQueue(clinicId).listen((event) {
      queueStatus.value = event;
      if (clinicId > 0) {
        final bookingTime = DateTime.parse(
          '${appointment.value.appointmentDate} ${appointment.value.appointmentTime}',
        );
        final currentTime = DateTime.now();
        final timeDifference = bookingTime.difference(currentTime);
        differenceTime.value =
            '${timeDifference.inHours < 0 ? '-' : timeDifference.inHours}h ${timeDifference.inMinutes < 0 ? '-' : timeDifference.inMinutes}mins';
      }
    });
  }

  Future<void> streamDuration() async {
    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (appointment.value.id > 0) {
        final bookingTime = DateTime.parse(
          '${appointment.value.appointmentDate} ${appointment.value.appointmentTime}',
        );
        final currentTime = DateTime.now();
        final timeDifference = bookingTime.difference(currentTime);
        differenceTime.value =
            '${timeDifference.inHours < 0 ? '-' : timeDifference.inHours}h ${timeDifference.inMinutes < 0 ? '-' : timeDifference.inMinutes}mins';
      }
    });
  }
}
