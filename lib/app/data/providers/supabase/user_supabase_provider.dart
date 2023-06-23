import 'dart:io';

import 'package:clinic_max/app/data/config/app_config.dart';
import 'package:clinic_max/app/data/constant/app_constant.dart';
import 'package:clinic_max/app/data/models/users/users_model.dart';
import 'package:clinic_max/app/data/utils/toast/toast.dart';
import 'package:path/path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserSupabaseProvider {
  const UserSupabaseProvider._();

  static Future<UsersModel?> getUserByEmail(String email) async {
    UsersModel? usersModel;
    final supabase = AppConfig.supabase.client;
    final data = await supabase.from(AppConstant.tableUser).select('*').eq(
          'email',
          email,
        );

    if (data.length > 0) {
      usersModel = UsersModel.fromJson(data[0]);
    }
    return usersModel;
  }

  static Future<UsersModel> createUser(UsersModel users) async {
    final supabase = AppConfig.supabase.client;
    final inserted = await supabase
        .from(AppConstant.tableUser)
        .insert(users.toJson())
        .select();

    return UsersModel.fromJson(inserted[0]);
  }

  static Future<UsersModel> updateUser(UsersModel users) async {
    final supabase = AppConfig.supabase.client;

    final updated = await supabase
        .from(AppConstant.tableUser)
        .update(users.toJson())
        .match({
      'email': users.email,
    }).select();

    return UsersModel.fromJson(updated[0]);
  }

  static Future<UsersModel> updateUserFromMedicalRecors(
      UsersModel users) async {
    final supabase = AppConfig.supabase.client;

    final updated = await supabase
        .from(AppConstant.tableUser)
        .update(users.toUpdateFromMedicalRecords())
        .match({
      'email': users.email,
    }).select();

    return UsersModel.fromJson(updated[0]);
  }

  static Future<String?> uploadProfilePicture(File image) async {
    final supabase = AppConfig.supabase.client;
    String url='';
    try {
      await supabase.storage.from('users_image').upload(
            'public/${basename(image.path)}',
            image,
            fileOptions: const FileOptions(
              cacheControl: '3600',
              upsert: false,
            ),
          );

      final getPublicUrl =
          await supabase.storage.from('users_image').getPublicUrl(
                'public/${basename(image.path)}',
              );
      url= getPublicUrl;
    } catch (e) {
      Toast.showErrorToast(e.toString());
    }
    return url;
  }
}
