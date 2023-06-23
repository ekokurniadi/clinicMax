import 'package:clinic_max/app/data/constant/app_constant.dart';
import 'package:clinic_max/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppConfig {
  static late SharedPreferences sharedPreferences;
  static late FirebaseAuth firebaseAuth;
  static late Supabase supabase;

  static Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    firebaseAuth = FirebaseAuth.instance;

    // init Supabase
    await Supabase.initialize(
      url: AppConstant.supabaseUrl,
      anonKey: AppConstant.anonKey,
    );

    supabase = Supabase.instance;

    sharedPreferences = await SharedPreferences.getInstance();

    await ScreenUtil.ensureScreenSize();

  }
}
