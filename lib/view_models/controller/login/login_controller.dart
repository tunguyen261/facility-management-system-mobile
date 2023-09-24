import 'package:FMS/models/login/users_model.dart';
import 'package:FMS/view_models/controller/notification/notification_controller.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:FMS/res/repository/login_repository/login_repository.dart';
import 'package:FMS/res/routes/routes_name.dart';
import 'package:FMS/utlis/utlis.dart';
import 'package:FMS/view_models/controller/user_prefrence/user_prefrence_view_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginViewModel extends GetxController {
  final _api = LoginRepository();

  UserPreference userPrefrence = UserPreference();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
  }

  RxBool loading = false.obs;
  void loginApiMailPassword() {
    //print(emailController);
    loading.value = true;
    Map data = {
      'email': emailController.value.text,
      'password': passwordController.value.text,
    };
    _api.loginApi(data).then((value) {
      print(value);
      loading.value = false;
      //print(value);
      if (value['status-code'] == 400 || value['status-code'] == 404) {
        Utils.snackBar('Something wrong!!!', value['status-code']);
      } else {
        UsersModel userModel = UsersModel.fromJson(value);
        // we will this model in sharedprefences
        userPrefrence
            .saveUserInfoPreferences(userModel)
            .then((value) => {
                  Get.delete<LoginViewModel>(),
                  Get.toNamed(RouteName.homeScreen)!.then((value) => {}),
                  Utils.snackBar("Chào mừng", "Chúc một ngày mới tốt lành"),
                })
            .onError((error, stackTrace) => {});
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.snackBar('Có lỗi xảy ra: ', "Email hoặc mật khẩu không chính xác");
    });
  }

  Future<void> handleSignIn() async {
    try {
      googleSignIn.signOut();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final String email = googleSignInAccount.email;
        if (email.endsWith("@fpt.edu.vn")) {
          final GoogleSignInAuthentication googleSignInAuthentication =
              await googleSignInAccount.authentication;
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );
          FirebaseAuth.instance.signInWithCredential(credential);
          final token = await AwesomeNotificationsFcm().requestFirebaseAppToken();
          //print("TOKEN FCM: $token");
          //print("token User ID: ${googleSignInAuthentication.idToken}");
          checkTokenGoogle(googleSignInAuthentication.idToken);
        } else {
          // Show an error message or handle unauthorized domain here
          Utils.snackBar("Bạn Không Có Quyền Truy Cập","Email not valid (...@fpt.edu.vn)");
          await signOutGoogle();
        }
      }
    } catch (error) {
      print("Google Sign-In Error: $error");
    }
  }

  checkTokenGoogle(String? token) async {
    loading.value = true;
    Map data = {
      'access_token': token,
    };
    _api.loginApiToken(data).then((value) {
      print(value);
      loading.value = false;
      if (value['status_code'] != 200) {
        Utils.snackBar("Đăng nhập không hợp lệ", "Hãy thử lại");
        Get.toNamed(RouteName.loginScreen);
      } else {
        UsersModel userModel = UsersModel.fromJson(value);
        // we will this model in sharedprefences
        userPrefrence
            .saveUserInfoPreferences(userModel)
            .then((value) => {
          Get.delete<LoginViewModel>(),
          Get.toNamed(RouteName.homeScreen)!.then((value) => {}),
          Utils.snackBar("Chào mừng", "Chúc một ngày mới tốt lành"),
        })
            .onError((error, stackTrace) => {});
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.snackBar('Something wrong: ', error.toString());
    });
  }

  loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      FirebaseAuth.instance.signInWithCredential(credential);
      checkTokenGoogle(googleSignInAuthentication.idToken); // navigate to your wanted page
      return;
    } catch (e) {
      Get.toNamed(RouteName.loginScreen);
      throw (e);
    }
  }

  Future<void> logoutGoogle() async {
    await googleSignIn.signOut();
    Get.toNamed(
        RouteName.loginScreen); // navigate to your wanted page after logout.
  }
}
