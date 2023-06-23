import 'package:clinic_max/app/data/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../controllers/medical_record_detail_controller.dart';

class MedicalRecordDetailView extends GetView<MedicalRecordDetailController> {
  const MedicalRecordDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.primaryColor,
          title: Text(
            'Medical Record : ${DateFormat('dd MMM yyyy').format(DateTime.parse(controller.medicalRecordModel.value.createdAt))}',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: false,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: ColorConstant.greyColor,
                child: PDF(
                  swipeHorizontal: false,
                )
                    .cachedFromUrl(
                      controller.medicalRecordModel.value.medicalRecordForm,
                      placeholder: (double progress) =>
                          Center(child: Text('$progress %')),
                      errorWidget: (dynamic error) =>
                          Center(child: Text(error.toString())),
                    )
                    .marginAll(12),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
                onPressed: () async {
                  await controller
                      .getAttachment(controller.medicalRecordModel.value.id);
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 38.0),
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  GridView.builder(
                                    physics: ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 4,
                                      crossAxisSpacing: 4,
                                    ),
                                    itemCount: controller.listAttachment.length,
                                    itemBuilder: (context, index) {
                                      return ZoomTapAnimation(
                                        onTap: () async {
                                          await controller.downloadAttachment(
                                            url: controller
                                                .listAttachment[index]
                                                .attachment,
                                            fileName:
                                                'attachment-${index + 1}-${DateFormat('dd-MM-yyyy').format(
                                              DateTime.parse(controller
                                                  .medicalRecordModel
                                                  .value
                                                  .createdAt),
                                            )}-${controller.user.value.name}.pdf',
                                          );
                                        },
                                        child: Container(
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/images/pdf-icon.png',
                                                  width: 24,
                                                ),
                                                const SizedBox(height: 16),
                                                Text(
                                                  'Attachment ${index + 1}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: ColorConstant
                                                        .blackColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 64)
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 28),
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Attachments (${controller.listAttachment.length})',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: ColorConstant.blackColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                color: Colors.white,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  child: Text('Close'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Text('View Attachment')),
            const SizedBox(height: 32)
          ],
        ),
      );
    });
  }
}
