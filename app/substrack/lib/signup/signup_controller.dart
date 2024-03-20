import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:substrack/signup/user_signup_model.dart';
import 'package:substrack/util/color.dart';

class SignUpController extends GetxController {
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;

  final database = FirebaseDatabase.instance.ref("user_profile");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your email';
    } else {
      return "";
    }
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your password';
    } else {
      return "";
    }
  }

  String? validateFirstName(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your firstName';
    } else {
      return "";
    }
  }

  String? validateLastName(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your lastName';
    } else {
      return "";
    }
  }

  String? validatePhoneNumber(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your phoneNumber';
    } else {
      return "";
    }
  }

  void userSubmit() {
    EasyLoading.show(status: "Please wait..");
    String email = emailController.value.text.toString().trim();
    String password = passwordController.value.text.toString().trim();
    String phone = phoneController.value.text.toString();
    String firstName = firstNameController.value.text.toString();
    String lastName = lastNameController.value.text.toString();

    if (email.isEmpty) {
      cancelSnackBar("Error!", "Please enter your email address");
      EasyLoading.dismiss();
      return;
    } else if (password.isEmpty) {
      EasyLoading.dismiss();
      cancelSnackBar("Error!", "Please enter your password");
      return;
    } else if (phone.isEmpty) {
      EasyLoading.dismiss();
      cancelSnackBar("Error!", "Please enter your phone number");
      return;
    } else if (firstName.isEmpty) {
      EasyLoading.dismiss();
      cancelSnackBar("Error!", "Please enter your firstName");
      return;
    } else if (lastName.isEmpty) {
      EasyLoading.dismiss();
      cancelSnackBar("Error!", "Please enter your lastName");
      return;
    } else {
      registerWithEmailAndPassword(email, password).then((value) {
        SignUpModel model = SignUpModel(firstName, lastName, phone, email, password);
          Map<String, dynamic> userData = model.toJson();
          String uid = _auth.currentUser!.uid.toString();
          database.child(uid).set(userData).then((_) {
            Get.back();
            EasyLoading.dismiss();
            successfullySnackBar("Congratulation", "Your account has been created!");
          }).catchError((error) {
            EasyLoading.dismiss();
            cancelSnackBar("Error!", "Failed to create your account");
          });
      });
    }
  }

  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User registered with email: ${userCredential.user!.email}');
      // Optionally, you can do something after successful registration, like navigating to a new screen
    } catch (e) {
      print('Failed to register user: $e');
      // Handle registration failure, e.g., show an error message
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
