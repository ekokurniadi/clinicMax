import 'package:clinic_max/app/data/providers/appointment/appointment_provider.dart';
import 'package:clinic_max/app/data/utils/sessions/session.dart';
import 'package:clinic_max/app/data/utils/widgets/loading.dart';
import 'package:get/get.dart';

class AppointmentListController extends GetxController {
  final listAppointment = <dynamic>[].obs;
  final listAppointmentHistory = <dynamic>[].obs;

  @override
  Future<void> onInit() async {
    LoadingApp.show();
    await getHistory();
    await getListAppointment();
    LoadingApp.dismiss();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getHistory() async {
    final user = await SessionPref.getUser();

    final response =
        await AppointmentProvider.getHistoryAppointment(user!.email!);

    listAppointmentHistory.value = response;
  }

  Future<void> getListAppointment() async {
    final user = await SessionPref.getUser();

    final response = await AppointmentProvider.getListAppointment(user!.email!);

    listAppointment.value = response;
  }
}
