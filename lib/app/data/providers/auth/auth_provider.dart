import 'package:clinic_max/app/data/config/app_config.dart';
import 'package:clinic_max/app/data/utils/toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  static Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = AppConfig.firebaseAuth;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        Toast.showSuccessToast('Login Succes');
      } on FirebaseAuthException catch (e) {
        Toast.showErrorToast(e.code);
        if (e.code == 'account-exists-with-different-credential') {
          Toast.showErrorToast('Please use your Email and Password to Login');
        } else if (e.code == 'invalid-credential') {
          Toast.showErrorToast(e.code);
        }
      } catch (e) {
        Toast.showErrorToast(e.toString());
      }
    }

    return user;
  }

  static Future<User?> signInWIthEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = AppConfig.firebaseAuth;
    User? user;

    try {
      final credentials = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = credentials.user;

      Toast.showSuccessToast('Login Succes');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        Toast.showErrorToast('Please use your Google Account to Login');
      } else if (e.code == 'invalid-credential') {
        Toast.showErrorToast(e.code);
      } else if (e.code.contains("already")) {
        Toast.showErrorToast('Please use your Google Account to Login');
      }
    } catch (e) {
      Toast.showErrorToast(e.toString());
    }

    return user;
  }
}
