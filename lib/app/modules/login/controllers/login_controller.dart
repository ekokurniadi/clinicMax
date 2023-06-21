import 'package:clinic_max/app/data/models/users/users_model.dart';
import 'package:clinic_max/app/data/providers/auth/auth_provider.dart';
import 'package:clinic_max/app/data/providers/supabase/user_supabase_provider.dart';
import 'package:clinic_max/app/data/utils/sessions/session.dart';
import 'package:clinic_max/app/data/utils/widgets/loading.dart';
import 'package:clinic_max/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final obscureText = true.obs;
  final obscureTextConfirm = true.obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final passwordConfirmController = TextEditingController().obs;
  final formKey = GlobalKey<FormState>().obs;
  final formKeyCreate = GlobalKey<FormState>().obs;

  @override
  void onInit() {
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

  void togglePassword() {
    obscureText.value = !obscureText.value;
  }

  void togglePasswordConfirm() {
    obscureTextConfirm.value = !obscureTextConfirm.value;
  }

  Future<void> handleSigninWithEmail() async {
    LoadingApp.show();
    final user = await Authentication.signInWithGoogle();
    if (user != null) {
      _processLoginToDB(user, 'google');
    }
    LoadingApp.dismiss();
  }

  Future<void> handleCreateAccount() async {
    LoadingApp.show();
    await Authentication.createUserWIthEmailPassword(
      email: emailController.value.text,
      password: passwordController.value.text,
    );

    LoadingApp.dismiss();
  }

  Future<void> handleSinginWIthEmailAndPassword() async {
    LoadingApp.show();
    final user = await Authentication.signInWIthEmailPassword(
      email: emailController.value.text,
      password: passwordController.value.text,
    );

    if (user != null) {
      _processLoginToDB(user, 'email-password');
    }

    LoadingApp.dismiss();
  }

  Future<void> _processLoginToDB(User user, String provider) async {
    final getUser = await UserSupabaseProvider.getUserByEmail(user.email!);

    if (getUser == null) {
      final loggedIn = await UserSupabaseProvider.createUser(
        UsersModel(
          name: user.displayName,
          email: user.email,
          phone: user.phoneNumber,
          imageUrl: user.photoURL,
          provider: provider,
          firebaseUid: user.uid,
        ),
      );

      await SessionPref.saveUserToPref(loggedIn);

      if (loggedIn.icNumber == null ||
          loggedIn.icNumber == '' ||
          loggedIn.provider == null ||
          loggedIn.provider == '') {
        Get.toNamed(Routes.REGISTER, arguments: {'user': loggedIn.toJson()});
      }
    } else {
      await SessionPref.saveUserToPref(getUser);
      if (getUser.icNumber == '' ||
          getUser.provider == null ||
          getUser.provider == '' ||
          getUser.phone == '' ||
          getUser.phone == null) {
        getUser.provider = provider;
        getUser.firebaseUid = getUser.firebaseUid ?? user.uid;
        Get.toNamed(Routes.REGISTER, arguments: {'user': getUser.toJson()});
      } else {
        Get.offAllNamed(Routes.MAIN_MENU);
      }
    }
  }
}
