import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:substrack/bottom_navaigation/bottom_navigation_view.dart';
import 'package:substrack/signIn/login_controller.dart';
import 'package:substrack/signup/signup_view.dart';
import 'package:substrack/util/fonts_styles.dart';
import '../track/track_controller.dart';
import '../util/color.dart';
import '../util/extra.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignInController controller =Get.put(SignInController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: MediaQuery.of(context).size.height, // Set height to full screen height
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ThemeColors.background, ThemeColors.tabColor],
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(), // Add scroll controller
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0,120,0,0),
                  child: Text(
                    "Welcome to \n Substrack",
                    style: FontStyles.HeadingTitle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0,80,16,16),
                  child: SizedBox(
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
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
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
                      obscureText: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                    ),
                    child: TextButton(
                      onPressed: () {
                        controller.loginUser();
                      },
                      child: const Text(
                        'Sign in',
                        style: FontStyles.LargeTitle_OutFif_white,
                      ),
                    ),
                  ),
                ),
                const Text(
                  'Or',
                  style: FontStyles.smallTitle,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextButton(
                      onPressed: () {
                        Get.to(SignUp());
                      },
                      child: const Text(
                        'Sign Up',
                        style: FontStyles.LargeTitle_OutFif,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
