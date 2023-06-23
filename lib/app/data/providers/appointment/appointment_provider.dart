import 'package:clinic_max/app/data/config/app_config.dart';
import 'package:clinic_max/app/data/constant/app_constant.dart';
import 'package:clinic_max/app/data/models/appointment/appointment_model.dart';
import 'package:clinic_max/app/data/models/users/users_model.dart';
import 'package:clinic_max/app/data/utils/toast/toast.dart';
import 'package:intl/intl.dart';

class AppointmentProvider {
  const AppointmentProvider._();

  static Future<List<AppointmentModel>> getAppointmentBookedTime({
    required String date,
    required int clinicId,
  }) async {
    final supabase = AppConfig.supabase.client;
    List<AppointmentModel> appointmentModel = [];

    try {
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
    } catch (e) {
      Toast.showErrorToast(e.toString());
    }

    return appointmentModel;
  }

  static Future<AppointmentModel?> getAppointmentByUser({
    required String date,
    required int id,
  }) async {
    final supabase = AppConfig.supabase.client;
    AppointmentModel? appointmentModel;

    try {
      final response =
          await supabase.from(AppConstant.tableAppointment).select('*').match({
        'appointment_date': date,
        'user_id': id,
      });

      if (response.length > 0) {
        appointmentModel = AppointmentModel.fromJson(response[0]);
      }
    } catch (e) {
      Toast.showErrorToast(e.toString());
    }

    return appointmentModel;
  }

  static Future<bool> createAppointment({
    required AppointmentModel data,
  }) async {
    final supabase = AppConfig.supabase.client;
    bool saved = false;

    try {
      final getExisting = await getAppointmentByUser(
        date: data.appointmentDate,
        id: data.userId,
      );

      if (getExisting == null) {
        final response = await supabase
            .from(AppConstant.tableAppointment)
            .insert(data.toJson())
            .select('id');

        saved = response.length > 0;
      }
    } catch (e) {
      Toast.showErrorToast(e.toString());
    }

    return saved;
  }

  static Future<List<dynamic>> getHistoryAppointment(
    int id,
  ) async {
    final supabase = AppConfig.supabase.client;
    List<dynamic> data = [];

    try {
      final response = await supabase
          .from(AppConstant.tableMedicalRecords)
          .select(
            '*, appointments!inner(*),clinics(address,contact), users(name)',
          )
          .eq(
            'appointments.user_id',
            id,
          );

      if (response.length > 0) {
        data = response;
      }
    } catch (e) {
      Toast.showErrorToast(e.toString());
    }

    return data;
  }

  static Future<List<dynamic>> getListAppointment(
    int id,
  ) async {
    final dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());

    List<dynamic> data = [];
    try {
      final supabase = AppConfig.supabase.client;
      final response = await supabase
          .from(AppConstant.tableAppointment)
          .select(
              'id,clinic_id,appointment_date,appointment_time,is_from_kiosk,checkin_time,user_id,queue_number,status, clinics(address,contact), users!inner(*)')
          .neq('status', 'Done')
          .eq('users.id', id)
          .eq('is_from_kiosk', false)
          .gte('appointment_date', dateNow);

      if (response.length > 0) {
        data = response;
      }
    } catch (e) {
      Toast.showErrorToast(e.toString());
    }

    return data;
  }

  static Future<AppointmentModel?> getCurrentAppointment(
    UsersModel user,
  ) async {
    AppointmentModel? appointmentModel;
    try {
      final supabase = AppConfig.supabase.client;

      final response = await supabase
          .from(AppConstant.tableAppointment)
          .select('*')
          .eq('user_id', user.id)
          .eq('appointment_date',
              DateFormat('yyyy-MM-dd').format(DateTime.now()))
          .eq('is_from_kiosk', false)
          .is_('checkin_time', null);

      if (response.length > 0) {
        appointmentModel = AppointmentModel.fromJson(response[0]);
      }
    } catch (e) {
      Toast.showErrorToast(e.toString());
    }

    return appointmentModel;
  }

  static Future<AppointmentModel?> getCurrentAppointmentAlreadyCheckin(
    UsersModel user,
  ) async {
    AppointmentModel? appointmentModel;
    final supabase = AppConfig.supabase.client;
    try {
      final response = await supabase
          .from(AppConstant.tableAppointment)
          .select('*')
          .eq('user_id', user.id)
          .eq('appointment_date',
              DateFormat('yyyy-MM-dd').format(DateTime.now()))
          .eq('is_from_kiosk', false)
          .not('checkin_time', 'is', null);

      if (response.length > 0) {
        appointmentModel = AppointmentModel.fromJson(response[0]);
      }
    } catch (e) {
      Toast.showErrorToast(e.toString());
    }

    return appointmentModel;
  }

  static Future<bool> updateCheckinTime({
    required int id,
    required int counter,
    required String checkinTime,
  }) async {
    final supabase = AppConfig.supabase.client;
    bool result = false;

    try {
      final response = await supabase
          .from(AppConstant.tableAppointment)
          .update({
            'checkin_time': checkinTime,
            'queue_number': counter,
            'status': 'Waiting'
          })
          .eq('id', id)
          .is_('checkin_time', null)
          .select();

      if (response.length > 0) {
        result = true;
      }
    } catch (e) {
      Toast.showErrorToast(e.toString());
    }

    return result;
  }

  static Future<List<AppointmentModel>> getAppointmentsChecked({
    required String date,
    required int clinicId,
  }) async {
    final supabase = AppConfig.supabase.client;
    List<AppointmentModel> appointmentModel = [];

    try {
      final response = await supabase
          .from(AppConstant.tableAppointment)
          .select('*')
          .match({
            'appointment_date': date,
            'clinic_id': clinicId,
          })
          .gt('queue_number', 0)
          .order('queue_number')
          .limit(1);

      if (response.length > 0) {
        appointmentModel = List<AppointmentModel>.from(
          response.map(
            (e) => AppointmentModel.fromJson(e),
          ),
        );
      }
    } catch (e) {
      Toast.showErrorToast(e.toString());
    }

    return appointmentModel;
  }
}
