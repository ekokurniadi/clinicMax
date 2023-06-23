import 'dart:io';

import 'package:clinic_max/app/data/config/app_config.dart';
import 'package:clinic_max/app/data/constant/app_constant.dart';
import 'package:clinic_max/app/data/models/medical_record/medical_record_attachments.dart';
import 'package:clinic_max/app/data/utils/toast/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MedicalRecordProvider {
  const MedicalRecordProvider._();

  static Future<List<dynamic>> getMedicalRecord(int userId) async {
    final supabase = AppConfig.supabase.client;

    List<dynamic> result = [];
    try {
      final response = await supabase
          .from(AppConstant.tableMedicalRecords)
          .select("*,appointments!inner(*),users(*),clinics(*)")
          .eq(
            'appointments.user_id',
            userId,
          )
          .order('id');

      if (response.length > 0) {
        result = response;
      }
    } catch (e) {
      Toast.showErrorToast(e.toString());
    }

    return result;
  }

  static Future<List<MedicalRecordAttachments>> getMedicalRecordAttachments(
    int medicalRecordId,
  ) async {
    final supabase = AppConfig.supabase.client;

    List<MedicalRecordAttachments> result = [];

    try {
      final response = await supabase
          .from(AppConstant.tableAttachment)
          .select()
          .eq('medical_record_id', medicalRecordId);

      result = List<MedicalRecordAttachments>.from(
        response.map((e) => MedicalRecordAttachments.fromJson(e)),
      );
    } catch (e) {
      Toast.showErrorToast(e.toString());
    }

    return result;
  }

  static Future<String?> downloadFile({
    required String url,
    required String fileName,
  }) async {
    try {
      final file = await _downloadTask(url, fileName);

      return file?.path;
    } catch (e) {
      Toast.showErrorToast(e.toString());
      return null;
    }
  }

  static Future<File?> _downloadTask(String url, String name) async {
    try {
      String savePath = "/storage/emulated/0/Download/${name}";
      File file = File(savePath);

      final response = await Dio().get(
        url,
        onReceiveProgress: _showDownloadProgress,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );

      var raw = file.openSync(mode: FileMode.write);
      raw.writeFromSync(response.data);
      await raw.close();
      return file;
    } catch (e) {
      Toast.showErrorToast(e.toString());
      return null;
    }
  }

  static void _showDownloadProgress(int received, int total) {
    if (total > 0) {
      print((received / total * 100).toStringAsFixed(0) + "%");
      EasyLoading.showProgress(
        double.parse(((received / total * 100) / 100).toStringAsFixed(1)),
        status: 'Downloading...',
        maskType: EasyLoadingMaskType.black,
      );
    }
  }
}
