import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/medical_record_controller.dart';

class MedicalRecordView extends GetView<MedicalRecordController> {
  const MedicalRecordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MedicalRecordView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MedicalRecordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
