import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:substrack/signup/signup_controller.dart';
import 'package:substrack/signup/user_signup_model.dart';
import 'package:substrack/util/fonts_styles.dart';
import '../util/color.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpController controller = Get.put(SignUpController());
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        automaticallyImplyLeading: false,
        backgroundColor: ThemeColors.background,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ThemeColors.background, ThemeColors.tabColor],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0,60,16,16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        child: TextFormField(
                          controller: controller.emailController.value,
                          decoration: InputDecoration(
                            hintText: 'Email Address',
                            hintStyle: FontStyles.meduimTitle_OutFif,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: controller.validateEmail,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 60,
                        child: TextFormField(
                          controller: controller.passwordController.value,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: FontStyles.meduimTitle_OutFif,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: controller.validatePassword,
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 60,
                        child: TextFormField(
                          controller: controller.firstNameController.value,

                          decoration: InputDecoration(
                            hintText: 'First Name',
                            hintStyle: FontStyles.meduimTitle_OutFif,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: controller.validateFirstName,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 60,
                        child: TextFormField(
                          controller: controller.lastNameController.value,

                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            hintStyle: FontStyles.meduimTitle_OutFif,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: controller.validateLastName,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 60,
                        child: TextFormField(
                          controller: controller.phoneController.value,

                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            hintStyle: FontStyles.meduimTitle_OutFif,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: controller.validatePhoneNumber,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: TextButton(
                  onPressed: () {
                    controller.userSubmit();
                  },
                  child: const Text(
                    'Sign up',
                    style: FontStyles.LargeTitle_OutFif,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
