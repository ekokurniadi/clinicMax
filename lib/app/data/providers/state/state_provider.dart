import 'package:clinic_max/app/data/config/app_config.dart';
import 'package:clinic_max/app/data/constant/app_constant.dart';
import 'package:clinic_max/app/data/models/states/states_model.dart';
import 'package:clinic_max/app/data/utils/toast/toast.dart';

class StateProvider {
  const StateProvider._();

  static Future<List<StatesModel>> getDataState() async {
    List<StatesModel> states = [];

    try {
      final result = await AppConfig.supabase.client
          .from(AppConstant.tableState)
          .select('*');
      if (result.length > 0) {
        states = List<StatesModel>.from(
          result.map((e) => StatesModel.fromJson(e)),
        );
      }
    } catch (e) {
      Toast.showErrorToast(e.toString());
    }

    return states;
  }
}
