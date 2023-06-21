import 'dart:typed_data';

import 'package:clinic_max/app/data/constant/color_constant.dart';
import 'package:clinic_max/app/modules/medical.record/views/medical_record_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../controllers/medical_record_controller.dart';

class MedicalRecordView extends StatefulWidget {
  const MedicalRecordView({Key? key}) : super(key: key);

  @override
  State<MedicalRecordView> createState() => _MedicalRecordViewState();
}

class _MedicalRecordViewState extends State<MedicalRecordView> {
  late MedicalRecordController controller;
  int age = 0;

  int getAge(String date) {
    final now = DateTime.now();
    final bod = DateTime.parse(date);

    return (now.difference(bod).inDays / 365).round();
  }

  Future<Uint8List> generatePdf(dynamic data) async {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Medical Record',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  )),
              pw.SizedBox(height: 32),
              pw.Text('Medical Record ID : ${data['id']}'),
              pw.Divider(),
              pw.Text('Clinic : ${data['clinics']['name']}'),
              pw.Divider(),
              pw.Text('Clinic Address: ${data['clinics']['address']}'),
              pw.Divider(),
              pw.Text('Doctor : ${data['users']['name']}'),
              pw.Divider(),
              pw.Text('Diagnosis : ${data['diagnosis']}'),
              pw.Divider(),
              pw.Text('Medication : ${data['medication']}'),
              pw.Divider(),
              pw.Text('Procedures : ${data['procedures']}'),
              pw.Divider(),
              pw.Text('Therapies : ${data['therapis']}'),
              pw.Divider(),
              pw.Text('Instructions : ${data['instructions']}'),
              pw.Divider(),
              pw.Text('Progress Notes : ${data['progress_notes']}'),
              pw.Divider(),
              pw.Text(
                  'Follow Up Appointment : ${data['follow_up_appointment']}'),
            ],
          ); // Center
        },
      ),
    ); //

    return doc.save();
  }

  @override
  Widget build(BuildContext context) {
    controller = Get.put(MedicalRecordController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        title: Text(
          'Medical Record',
          style: TextStyle(
            fontSize: 24.sp,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () async {
              if (controller.formKey.value.currentState!.validate()) {
                await controller.updateUser();
              }
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Form(
            key: controller.formKey.value,
            child: Column(
              children: [
                SizedBox(height: 32.h),
                Container(
                  color: ColorConstant.primaryColor,
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Text(
                        'Name : ',
                        style: TextStyle(
                            color: ColorConstant.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp),
                      ),
                      Expanded(
                        child: TextFormField(
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                          cursorColor: Colors.white,
                          style: TextStyle(
                              color: ColorConstant.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp),
                          readOnly: false,
                          controller: controller.nameController.value,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration.collapsed(
                            hintText: '',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                BiodataWidget(
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'IC Number is required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    controller.formKey.value.currentState!.validate();
                  },
                  title: 'IC Number',
                  controller: controller,
                  editingController: controller.icNumberController.value,
                ),
                BiodataWidget(
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Gender is required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    controller.formKey.value.currentState!.validate();
                  },
                  title: 'Gender',
                  color: ColorConstant.primaryColor.withAlpha(50),
                  editingController: controller.genderController.value,
                  controller: controller,
                  isReadonly: true,
                  onTap: () async {
                    await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    'Select your Gender',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ZoomTapAnimation(
                                  onTap: () {
                                    controller.setGender('Male');
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.all(16),
                                    child: Text('Male'),
                                  ),
                                ),
                                const Divider(),
                                ZoomTapAnimation(
                                  onTap: () {
                                    controller.setGender('Female');
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.all(16),
                                    child: Text('Female'),
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          );
                        });
                  },
                ),
                BiodataWidget(
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Contact is required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    controller.formKey.value.currentState!.validate();
                  },
                  title: 'Contact',
                  editingController: controller.phoneController.value,
                  controller: controller,
                ),
                BiodataWidget(
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'DOB is required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    controller.formKey.value.currentState!.validate();
                  },
                  title: 'DOB',
                  color: ColorConstant.primaryColor.withAlpha(50),
                  editingController: controller.dobController.value,
                  controller: controller,
                  isReadonly: true,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900, 1, 1),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      controller.setDob(date);
                    }
                  },
                ),
                BiodataWidget(
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Address is required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    controller.formKey.value.currentState!.validate();
                  },
                  title: 'Address',
                  editingController: controller.addressController.value,
                  controller: controller,
                ),
                BiodataWidget(
                  title: 'Blood Group',
                  color: ColorConstant.primaryColor.withAlpha(50),
                  editingController: controller.bloodController.value,
                  controller: controller,
                ),
                BiodataWidget(
                  title: 'Height',
                  editingController: controller.heightController.value,
                  controller: controller,
                ),
                BiodataWidget(
                  title: 'Weight',
                  color: ColorConstant.primaryColor.withAlpha(50),
                  editingController: controller.weightController.value,
                  controller: controller,
                ),
                const SizedBox(height: 16),
                Container(
                  color: ColorConstant.primaryColor,
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Previous Medical History : ',
                        style: TextStyle(
                            color: ColorConstant.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: ColorConstant.primaryColor,
                  padding: const EdgeInsets.all(16),
                  child: controller.listMedicalRecord.isEmpty
                      ? Center(
                          child: Text(
                            'Not Found',
                            style: TextStyle(
                                color: ColorConstant.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp),
                          ),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                          ),
                          itemCount: controller.listMedicalRecord.length,
                          itemBuilder: (context, index) {
                            return ZoomTapAnimation(
                              onTap: () async {
                                final pdfData = await generatePdf(
                                  controller.listMedicalRecord[index],
                                );
                                Get.to(() => MedicalRecordViewer(
                                      data: pdfData,
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: Text(
                                    'PDF\n' +
                                        controller.listMedicalRecord[index]
                                                ['id']
                                            .toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: ColorConstant.primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class BiodataWidget extends StatefulWidget {
  final String title;
  final Color? color;
  final MedicalRecordController controller;
  final TextEditingController editingController;
  final bool isReadonly;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  const BiodataWidget({
    super.key,
    required this.title,
    this.color,
    required this.controller,
    required this.editingController,
    this.isReadonly = false,
    this.onTap,
    this.validator,
    this.onChanged,
  });

  @override
  State<BiodataWidget> createState() => _BiodataWidgetState();
}

class _BiodataWidgetState extends State<BiodataWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.widget.color ?? ColorConstant.white,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 1, child: Text('${widget.title}')),
          SizedBox(width: 16.w, child: Text(':')),
          Expanded(
            flex: 2,
            child: TextFormField(
              validator: widget.validator,
              onChanged: widget.onChanged,
              onTap: widget.onTap,
              readOnly: widget.isReadonly,
              controller: widget.editingController,
              textAlign: TextAlign.left,
              decoration: InputDecoration.collapsed(
                hintText: '${widget.title}',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
