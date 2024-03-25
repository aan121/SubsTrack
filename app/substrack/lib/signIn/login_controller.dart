import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:substrack/home/home_view.dart';

import '../bottom_navaigation/bottom_navigation_view.dart';
import '../util/color.dart';
import '../util/extra.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  void loginUser(){
    EasyLoading.show(status: "please wait..");
    String email = emailController.value.text.toString().trim();
    String password = passwordController.value.text.toString().trim();

    if(email.isEmpty){
      cancelSnackBar("Error!", "please fill fields email.");
      EasyLoading.dismiss();
      return;
    }else if(password.isEmpty){
      EasyLoading.dismiss();
      cancelSnackBar("Error!", "please fill fields password.");
    }

    signInWithEmailAndPassword(email,password);
  }
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value) {
        Get.off(BottomNavigation());
        Extra.CURRENT_USER_ID = _auth.currentUser!.uid.toString();
        EasyLoading.dismiss();
        successfullySnackBar("Congratulation!","Logged in successfully.");
      });
    } catch (e) {
      EasyLoading.dismiss();
      String errorMessage = "Failed to sign in user";
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case "invalid-email":
            errorMessage = "Invalid email address";
            break;
          case "user-disabled":
            errorMessage = "User account has been disabled";
            break;
          case "user-not-found":
          case "wrong-password":
            errorMessage = "Invalid email or password";
            break;
          default:
            errorMessage = "An error occurred";
        }
      }
      print('$errorMessage: $e');
      cancelSnackBar("Error!", errorMessage);
    }
  }
  void successfullySnackBar(String title, String message) {
    Get.snackbar(title, message, backgroundColor: ThemeColors.tabColor);
  }
  void cancelSnackBar(String title, String message) {
    Get.snackbar(title, message,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white);
  }
}
