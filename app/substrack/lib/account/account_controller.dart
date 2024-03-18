import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../signup/user_signup_model.dart';
import '../util/extra.dart';

class AccountController extends GetxController{

  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  late SignUpModel signUpModel;
  final database = FirebaseDatabase.instance.ref("user_profile");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> fetchData() async {
    try {
      DatabaseEvent event = await database.child(Extra.CURRENT_USER_ID).once();
      DataSnapshot dataSnapshot = event.snapshot;
      if (dataSnapshot.value != null) {
        Map<dynamic, dynamic> data = dataSnapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          emailController.value.text = data['userEmail'];
          firstNameController.value.text = data['userFirstName'];
          lastNameController.value.text = data['userLastName'];
          phoneController.value.text = data['userPhoneNumber'];
        });
      }
    } catch (error) {
      print("Error fetching data from Firebase: $error");
    }
  }
@override
  void onInit() {
    fetchData();
    super.onInit();
  }
}