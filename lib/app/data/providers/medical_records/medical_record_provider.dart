import 'package:clinic_max/app/data/config/app_config.dart';
import 'package:clinic_max/app/data/constant/app_constant.dart';

class MedicalRecordProvider {
  const MedicalRecordProvider._();

  static Future<List<dynamic>> getMedicalRecord(int userId) async {
    final supabase = AppConfig.supabase.client;

    List<dynamic> result = [];

    final response = await supabase
        .from(AppConstant.tableMedicalRecords)
        .select("*,appointments(*),users(*),clinics(*)")
        .eq(
          'appointments.user_id',
          userId,
        );

    if (response.length > 0) {
      result = response;
    }

    return result;
  }
}
