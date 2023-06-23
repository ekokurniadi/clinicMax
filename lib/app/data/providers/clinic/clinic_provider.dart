import 'package:clinic_max/app/data/config/app_config.dart';
import 'package:clinic_max/app/data/constant/app_constant.dart';
import 'package:clinic_max/app/data/models/clinic/clinic_model.dart';
import 'package:clinic_max/app/data/utils/toast/toast.dart';

class ClinicProvider {
  const ClinicProvider._();

  static Future<List<ClinicModel>> getDataClinics(int id) async {
    List<ClinicModel> clinics = [];

    try {
      final result = await AppConfig.supabase.client
          .from(AppConstant.tableClinic)
          .select('*')
          .eq('state_id', id);
      if (result.length > 0) {
        clinics = List<ClinicModel>.from(
          result.map((e) => ClinicModel.fromJson(e)),
        );
      }
    } catch (e) {
      Toast.showErrorToast(e.toString());
    }

    return clinics;
  }
}
