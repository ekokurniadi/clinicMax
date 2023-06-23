import 'package:get/get.dart';

import '../controllers/medical_record_detail_controller.dart';

class MedicalRecordDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicalRecordDetailController>(
      () => MedicalRecordDetailController(),
    );
  }
}
