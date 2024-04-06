import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
  final database = FirebaseDatabase.instance.ref("user_profile");

  void loginUser(){
    EasyLoading.show(status: "please wait..");
    String email = emailController.value.text.toString().trim();
    String password = passwordController.value.text.toString().trim();

    if(email.isEmpty){
      cancelSnackBar("Error!", "please enter your email.");
      EasyLoading.dismiss();
      return;
    }else if(password.isEmpty){
      EasyLoading.dismiss();
      cancelSnackBar("Error!", "please enter your password.");
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
      fetchData();
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
  Future<void> fetchData() async {
    try {
      bool isEmail = false;
      bool isPassword=false;
      DatabaseEvent event = await database.orderByKey().once();
      DataSnapshot dataSnapshot = event.snapshot;
      if (dataSnapshot.value != null) {
        Map<dynamic, dynamic> data = dataSnapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          String userEmail = value['userEmail'];
          String password = value['userPassword'];

          print(userEmail);
          if(userEmail==emailController.value.text.toString().trim()){
            isEmail=true;
          }else if(password==passwordController.value.text.toString().trim()){
            isPassword=true;
          }
        });
        EasyLoading.dismiss();
        if(!isEmail){
          cancelSnackBar("Error", "Incorrect Email");
        }else if(!isPassword){
          cancelSnackBar("Error", "Incorrect Password");
        }
      }
    } catch (error) {
      print("Error fetching data from Firebase: $error");
    }
  }
}
