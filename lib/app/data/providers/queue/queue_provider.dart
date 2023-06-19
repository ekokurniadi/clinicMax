import 'package:clinic_max/app/data/config/app_config.dart';
import 'package:clinic_max/app/data/constant/app_constant.dart';
import 'package:clinic_max/app/data/models/queue/queue_model.dart';

class QueueProvider {
  const QueueProvider._();

  static Future<QueueModel?> getQueueByClinic(int clinicId) async {
    final supabase = AppConfig.supabase.client;
    QueueModel? queueModel;
    final response = await supabase.from(AppConstant.tableQueue).select('*').eq(
          'clinic_id',
          clinicId,
        );

    if (response.length > 0) {
      queueModel = QueueModel.fromJson(response[0]);
    }

    return queueModel;
  }

  static Future<QueueModel?> insertQueueOnClinic(
    int clinicId,
    QueueModel queue,
  ) async {
    final supabase = AppConfig.supabase.client;
    QueueModel? queueModel;
    final response = await supabase
        .from(AppConstant.tableQueue)
        .insert(queue.toJson())
        .eq('clinic_id', clinicId)
        .select();

    if (response.length > 0) {
      queueModel = QueueModel.fromJson(response[0]);
    }

    return queueModel;
  }
}
