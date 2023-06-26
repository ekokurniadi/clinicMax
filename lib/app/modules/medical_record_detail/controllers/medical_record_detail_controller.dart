import 'package:clinic_max/app/data/models/clinic/clinic_model.dart';
import 'package:clinic_max/app/data/models/medical_record/medical_record_attachments.dart';
import 'package:clinic_max/app/data/models/medical_record/medical_record_model.dart';
import 'package:clinic_max/app/data/models/users/users_model.dart';
import 'package:clinic_max/app/data/providers/medical_records/medical_record_provider.dart';
import 'package:clinic_max/app/data/utils/toast/toast.dart';
import 'package:clinic_max/app/data/utils/widgets/loading.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

class MedicalRecordDetailController extends GetxController {
  final medicalRecordModel = MedicalRecordModel(
    id: 0,
    appointmentId: 0,
    clinicId: 0,
    doctorId: 0,
    medicalRecordForm: '',
    createdAt: '',
  ).obs;
  final clinic = ClinicModel.initial().obs;
  final user = UsersModel().obs;

  final listAttachment = <MedicalRecordAttachments>[].obs;
  final listDownloaded = <int>[].obs;

  @override
  Future<void> onInit() async {
    permissionStorage();
    LoadingApp.show();
    medicalRecordModel.value = Get.arguments['medical_record'];
    user.value = Get.arguments['user'];
    await getAttachment(medicalRecordModel.value.id);
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

  Future<void> getAttachment(int medicalRecordId) async {
    LoadingApp.show();

    final result = await MedicalRecordProvider.getMedicalRecordAttachments(
      medicalRecordId,
    );

    listAttachment.value = result;

    LoadingApp.dismiss();
  }

  void permissionStorage() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  Future<void> downloadAttachment({
    required int id,
    required String url,
    required String fileName,
  }) async {
    final result = await MedicalRecordProvider.downloadFile(
      url: url,
      fileName: fileName,
    );

    if (result != null) {
      listDownloaded.add(id);
      Toast.showSuccessToast('Download success');
      LoadingApp.dismiss();
      await OpenFile.open(result);
    }
  }
}
