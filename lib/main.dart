import 'package:clinic_max/app/data/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.init();

  runApp(
    ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "ClinicMax",
            theme: ThemeData(
              fontFamily: 'Inter',
              textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Inter'),
            ),
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            builder: EasyLoading.init(),
            home: child,
          );
        }),
  );
}
