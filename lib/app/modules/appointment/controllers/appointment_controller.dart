import 'package:clinic_max/app/data/models/appointment/appointment_model.dart';
import 'package:clinic_max/app/data/models/clinic/clinic_model.dart';
import 'package:clinic_max/app/data/models/states/states_model.dart';
import 'package:clinic_max/app/data/models/time_slots/time_slots.dart';
import 'package:clinic_max/app/data/models/users/users_model.dart';
import 'package:clinic_max/app/data/providers/appointment/appointment_provider.dart';
import 'package:clinic_max/app/data/providers/clinic/clinic_provider.dart';
import 'package:clinic_max/app/data/providers/state/state_provider.dart';
import 'package:clinic_max/app/data/providers/supabase/user_supabase_provider.dart';
import 'package:clinic_max/app/data/providers/time_slots/time_slots.dart';
import 'package:clinic_max/app/data/utils/sessions/session.dart';
import 'package:clinic_max/app/data/utils/toast/toast.dart';
import 'package:clinic_max/app/data/utils/widgets/loading.dart';
import 'package:clinic_max/app/modules/appointment/views/appointment_form.dart';
import 'package:clinic_max/app/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppointmentController extends GetxController {
  final listStates = <StatesModel>[].obs;
  final listClinic = <ClinicModel>[].obs;
  final userModel = UsersModel().obs;
  final selectedStates = StatesModel(name: '', id: 0).obs;
  final selectedClinic = ClinicModel.initial().obs;
  final selectedTime = ''.obs;
  final isLoading = true.obs;
  final timeSlots = TimeSlots(days: '', slots: []).obs;
  final selectedDateTime = DateTime.now().obs;
  final bookedSlotList = <String>[].obs;

  final nameController = TextEditingController().obs;
  final icNumberController = TextEditingController().obs;
  final emailController = TextEditingController().obs;

  final otherUser = UsersModel().obs;
  final isForOther = false.obs;

  @override
  Future<void> onInit() async {
    isLoading.value = true;
    await getUserData();
    await getStates();
    selectedDateTime.value = DateTime.now().add(Duration(
        days: DateTime.now().weekday == DateTime.saturday
            ? 2
            : DateTime.now().weekday == DateTime.sunday
                ? 1
                : 0));
    isLoading.value = false;
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

  Future<void> getStates() async {
    LoadingApp.show();
    final states = await StateProvider.getDataState();
    listStates.value = states;
    selectedStates.value = listStates.first;
    LoadingApp.dismiss();
  }

  Future<void> getClinics(int id) async {
    LoadingApp.show();
    listClinic.clear();
    final clinics = await ClinicProvider.getDataClinics(id);
    listClinic.value = clinics;
    if (listClinic.length <= 0) {
      timeSlots.value = TimeSlots(days: '', slots: []);
    }
    LoadingApp.dismiss();
  }

  Future<void> getUserData() async {
    LoadingApp.show();
    final users = await SessionPref.getUser();
    userModel.value = users!;
    LoadingApp.dismiss();
  }

  Future<void> setSelectedClinic(ClinicModel clinic) async {
    selectedClinic.value = clinic;
    await getTimeSlot();
  }

  void setSelectedStates(StatesModel model) async {
    selectedStates.value = model;
    await getClinics(selectedStates.value.id);
  }

  void setSelectedDate(DateTime date) {
    selectedDateTime.value = date;
  }

  Future<void> getTimeSlot() async {
    LoadingApp.show();
    final getNameOfDay = DateFormat('EEEE').format(selectedDateTime.value);
    final slot = await TimeSlotsProvider.getTimeSlot(getNameOfDay);
    final bookedSlot = await _getBookedSlot(
      date: DateFormat('yyyy-MM-dd').format(selectedDateTime.value),
    );
    List<String> booked = [];
    for (var book in bookedSlot) {
      booked.add(book.appointmentTime.substring(0, 5));
    }
    bookedSlotList.value = booked;
    timeSlots.value = slot;
    LoadingApp.dismiss();
  }

  Future<List<AppointmentModel>> _getBookedSlot({
    required String date,
  }) async {
    final result = await AppointmentProvider.getAppointmentBookedTime(
      date: date,
      clinicId: selectedClinic.value.id,
    );
    return result;
  }

  void setSelectedTime(String time) {
    selectedTime.value = time;
  }

  Future<void> createAppointment() async {
    if (selectedTime != '' &&
        selectedClinic.value.id != 0 &&
        selectedStates.value.id != 0) {
      LoadingApp.show();

      if (isForOther.value) {
        UsersModel? userForCreate;
        final checkUser =
            await UserSupabaseProvider.getUserByEmail(otherUser.value.email!);
        if (checkUser == null) {
          final createUser = await UserSupabaseProvider.createUser(
            otherUser.value,
          );
          userForCreate = createUser;
        } else {
          userForCreate = checkUser;
        }

        final response = await AppointmentProvider.createAppointment(
          data: AppointmentModel(
            id: 0,
            clinicId: selectedClinic.value.id,
            email: userForCreate.email ?? '',
            userId: userForCreate.id ?? 0,
            appointmentDate:
                DateFormat('yyyy-MM-dd').format(selectedDateTime.value),
            appointmentTime: selectedTime.value,
            isFromKiosk: false,
          ),
        );

        if (response) {
          LoadingApp.dismiss();
          Toast.showSuccessToast('Create appointment success');
          refresh();
          Get.delete<AppointmentController>();
          Get.toNamed(Routes.MAIN_MENU);
        } else {
          refresh();
          LoadingApp.dismiss();
          Toast.showErrorToast('You only can create 1 appointment per day');
        }
      } else {
        final response = await AppointmentProvider.createAppointment(
          data: AppointmentModel(
            id: 0,
            clinicId: selectedClinic.value.id,
            email: userModel.value.email!,
            userId: userModel.value.id!,
            appointmentDate:
                DateFormat('yyyy-MM-dd').format(selectedDateTime.value),
            appointmentTime: selectedTime.value,
            isFromKiosk: false,
          ),
        );

        if (response) {
          LoadingApp.dismiss();
          Toast.showSuccessToast('Create appointment success');
          refresh();
          Get.delete<AppointmentController>();
          Get.toNamed(Routes.MAIN_MENU);
              
        } else {
          refresh();
          LoadingApp.dismiss();
          Toast.showErrorToast('You only can create 1 appointment per day');
        }
      }
    } else {
      Toast.showErrorToast('Please complete appointment form first');
    }
  }

  Future<void> addAppointmentForOthers() async {
    isForOther.value = true;
    otherUser.value = UsersModel(
      name: nameController.value.text,
      email: emailController.value.text,
      icNumber: icNumberController.value.text,
    );
    nameController.value.clear();
    emailController.value.clear();
    icNumberController.value.clear();

    Get.to(() => AppointmentForm());
  }
}
