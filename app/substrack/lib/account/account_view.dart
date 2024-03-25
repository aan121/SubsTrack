import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:substrack/account/account_controller.dart';

import '../notification/notification_view.dart';
import '../signIn/login_view.dart';
import '../util/color.dart';
import '../util/fonts_styles.dart';
import '../util/images.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AccountController controller = Get.put(AccountController());
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await controller.fetchData();
    });
    bool _switchValueEmail = true;
    bool _switchValueSMS = false;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  Get.off(const Login());
                },
                child: Image.asset(Images.setting),
              ),
              const Text(
                "Substrack",
                style: FontStyles.Main_Home_Title,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(NotificationView());
                },
                child: Image.asset(Images.notification),
              )
            ],
          ),
        ),
        backgroundColor: ThemeColors.background,
      ),
      body: Container(
        decoration: const BoxDecoration(color: ThemeColors.background),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 46,left: 15),
                            child: const Text(
                              "Email",
                              style: FontStyles.roman_bold,
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: controller.emailController.value,
                                style: TextStyle(color: Colors.black),
                                readOnly: true,
                                enabled: false,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  filled: true,
                                  fillColor: ThemeColors.backgroundGray,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:0,right: 20),
                            child: const Text(
                              "First Name",
                              style: FontStyles.roman_bold,
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: controller.firstNameController.value,
                                decoration: InputDecoration(
                                  hintText: 'First Name ',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0,right: 20),
                            child: const Text(
                              "Last Name",
                              style: FontStyles.roman_bold,
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: controller.lastNameController.value,
                                decoration: InputDecoration(
                                  hintText: 'Last Name',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 48),
                            child: const Text(
                              "phone",
                              style: FontStyles.roman_bold,
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: controller.phoneController.value,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'phone',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(height: 30),
                      const Text(
                        "Notifications",
                        style: FontStyles.HeadingTitleWithStyle,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 10.0,left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Email",
                              style: FontStyles.roman_bold,
                            ),
                            Text(
                              "SMS",
                              style: FontStyles.roman_bold,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 6,left: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Switch(
                              value: _switchValueEmail,
                              onChanged: (value) {},
                              activeColor: ThemeColors.tabColor,
                              inactiveThumbColor: Colors.white,
                            ),
                            Switch(
                              value: _switchValueSMS,
                              onChanged: (value) {},
                              activeColor: ThemeColors.tabColor,
                              inactiveThumbColor: Colors.white,
                            ),
                          ],
                        ),
                      ),

                      // Notification rows and switches go here
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ThemeColors.tabColor,
                      ),
                      child: TextButton(
                        onPressed: () {
                         Get.back();
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Text(
                            'Cancel',
                            style: FontStyles.smallTitle,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ThemeColors.tabColor,
                      ),
                      child: TextButton(
                        onPressed: () {
                          controller.updateUserData();
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Text(
                            'Save',
                            style: FontStyles.smallTitle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
