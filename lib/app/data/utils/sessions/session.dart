import 'dart:convert';

import 'package:clinic_max/app/data/config/app_config.dart';
import 'package:clinic_max/app/data/models/users/users_model.dart';

class SessionPref {
  const SessionPref._();

  static Future<UsersModel?> getUser() async {
    final user = await AppConfig.sharedPreferences.getString('users');
    UsersModel? savedUser;
    if (user != null) {
      savedUser = UsersModel.fromJson(jsonDecode(user));
    }
    return savedUser;
  }

  static Future<bool> saveUserToPref(UsersModel user) async {
    return await AppConfig.sharedPreferences.setString(
      'users',
      jsonEncode(user.toPref()),
    );
  }
}
