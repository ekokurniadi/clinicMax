import 'package:clinic_max/app/data/config/app_config.dart';
import 'package:clinic_max/app/data/constant/app_constant.dart';
import 'package:clinic_max/app/data/models/appointment/appointment_model.dart';
import 'package:clinic_max/app/data/models/users/users_model.dart';
import 'package:intl/intl.dart';

class AppointmentProvider {
  const AppointmentProvider._();

  static Future<List<AppointmentModel>> getAppointmentBookedTime({
    required String date,
    required int clinicId,
  }) async {
    final supabase = AppConfig.supabase.client;
    List<AppointmentModel> appointmentModel = [];
    final response =
        await supabase.from(AppConstant.tableAppointment).select('*').match({
      'appointment_date': date,
      'clinic_id': clinicId,
    });

    if (response.length > 0) {
      appointmentModel = List<AppointmentModel>.from(
        response.map(
          (e) => AppointmentModel.fromJson(e),
        ),
      );
    }
    return appointmentModel;
  }

  static Future<AppointmentModel?> getAppointmentByUser({
    required String date,
    required String email,
  }) async {
    final supabase = AppConfig.supabase.client;
    AppointmentModel? appointmentModel;
    final response =
        await supabase.from(AppConstant.tableAppointment).select('*').match({
      'appointment_date': date,
      'email': email,
    });

    if (response.length > 0) {
      appointmentModel = AppointmentModel.fromJson(response[0]);
    }
    return appointmentModel;
  }

  static Future<bool> createAppointment({
    required AppointmentModel data,
  }) async {
    final supabase = AppConfig.supabase.client;
    bool saved = false;
    final getExisting = await getAppointmentByUser(
      date: data.appointmentDate,
      email: data.email,
    );

    if (getExisting == null) {
      final response = await supabase
          .from(AppConstant.tableAppointment)
          .insert(data.toJson())
          .select('id');

      return saved = response.length > 0;
    }

    return saved;
  }

  static Future<List<dynamic>> getHistoryAppointment(
    String email,
  ) async {
    List<dynamic> data = [];
    final supabase = AppConfig.supabase.client;
    final response = await supabase
        .from(AppConstant.tableMedicalRecords)
        .select(
          '*, appointments(id,appointment_date,appointment_time),clinics(address,contact), users(name)',
        )
        .eq(
          'email',
          email,
        );

    if (response.length > 0) {
      data = response;
    }
    return data;
  }

  static Future<List<dynamic>> getListAppointment(
    String email,
  ) async {
    final dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final timeNow = DateFormat('HH:mm:ss').format(DateTime.now());
    List<dynamic> data = [];
    final supabase = AppConfig.supabase.client;
    final response = await supabase
        .from(AppConstant.tableAppointment)
        .select('*, clinics(address,contact), users(name)')
        .eq('email', email)
        .eq('is_from_kiosk', false)
        .is_('checkin_time', null)
        .gte('appointment_date', dateNow)
        .gte('appointment_time', timeNow);

    if (response.length > 0) {
      data = response;
    }
    return data;
  }

  static Future<AppointmentModel?> getCurrentAppointment(
    UsersModel user,
  ) async {
    AppointmentModel? appointmentModel;
    final supabase = AppConfig.supabase.client;
    final timeNow = DateFormat('HH:mm:ss').format(DateTime.now());
    final response = await supabase
        .from(AppConstant.tableAppointment)
        .select('*')
        .eq('user_id', user.id)
        .eq('email', user.email)
        .eq('appointment_date', DateFormat('yyyy-MM-dd').format(DateTime.now()))
        .eq('is_from_kiosk', false)
        .is_('checkin_time', null);

    if (response.length > 0) {
      appointmentModel = AppointmentModel.fromJson(response[0]);
    }

    return appointmentModel;
  }

  static Future<bool> updateCheckinTime(int id) async {
    final supabase = AppConfig.supabase.client;

    final response = await supabase
        .from(AppConstant.tableAppointment)
        .update({
          'checkin_time': DateTime.now(),
          'queue_status':'Active',
        })
        .eq('id', id)
        .select();

    if (response.length > 0) {
      return true;
    }

    return false;
  }
}
