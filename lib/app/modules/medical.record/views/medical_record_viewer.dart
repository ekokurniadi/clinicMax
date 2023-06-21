import 'dart:typed_data';

import 'package:clinic_max/app/data/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:printing/printing.dart';

class MedicalRecordViewer extends StatelessWidget {
  final Uint8List data;
  const MedicalRecordViewer({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        title: Text(
          'Medical Records View',
          style: TextStyle(
            fontSize: 24.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: PdfPreview(build: (format) {
        return data;
      }),
    );
  }
}
