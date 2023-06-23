import 'package:clinic_max/app/data/config/app_config.dart';
import 'package:clinic_max/app/data/constant/app_constant.dart';
import 'package:clinic_max/app/data/models/queue/queue_model.dart';
import 'package:clinic_max/app/data/utils/toast/toast.dart';

class QueueProvider {
  const QueueProvider._();

  static Future<QueueModel?> getQueueByClinic(int clinicId) async {
    final supabase = AppConfig.supabase.client;
    QueueModel? queueModel;

    try {
      final response =
          await supabase.from(AppConstant.tableQueue).select('*').eq(
                'clinic_id',
                clinicId,
              );

      if (response.length > 0) {
        queueModel = QueueModel.fromJson(response[0]);
      }
    } catch (e) {
      Toast.showErrorToast(e.toString());
    }

    return queueModel;
  }

  static Future<QueueModel?> insertQueueOnClinic(
    int clinicId,
    QueueModel queue,
  ) async {
    final supabase = AppConfig.supabase.client;
    QueueModel? queueModel;

    try {
      final response = await supabase
          .from(AppConstant.tableQueue)
          .insert(queue.toJson())
          .eq('clinic_id', clinicId)
          .select();

      if (response.length > 0) {
        queueModel = QueueModel.fromJson(response[0]);
      }
    } catch (e) {
      Toast.showErrorToast(e.toString());
    }

    return queueModel;
  }

  static Future<QueueModel?> resetQueueOnClinic(
    QueueModel queue,
  ) async {
    final supabase = AppConfig.supabase.client;
    QueueModel? queueModel;

    try {
      final response = await supabase
          .from(AppConstant.tableQueue)
          .update({
            'queue_number': 1,
            'last_update': DateTime.now().toIso8601String(),
          })
          .eq('clinic_id', queue.clinicId)
          .select();

      if (response.length > 0) {
        queueModel = QueueModel.fromJson(response[0]);
      }
    } catch (e) {
      Toast.showErrorToast(e.toString());
    }

    return queueModel;
  }

  static Stream<QueueModel> streamQueue(int clinicId) async* {
    final supabase = AppConfig.supabase.client;

    yield* supabase
        .from(AppConstant.tableQueue)
        .stream(primaryKey: ['id'])
        .eq('clinic_id', clinicId)
        .map<QueueModel>((event) {
          return QueueModel.fromJson(
            event[0],
          );
        })
        .handleError((Object error) {
          return QueueModel(
            id: 0,
            clinicId: clinicId,
            queueNumber: 0,
            lastUpdate: DateTime.now(),
          );
        });
  }
}
