import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:substrack/notification/notification_controller.dart';
import 'package:substrack/util/color.dart';
import 'package:substrack/util/fonts_styles.dart';

import '../Services/notifi_service.dart';
import '../bottom_navaigation/bottom_navigation_view.dart';
import '../notification/notification_view.dart';
import '../signIn/login_view.dart';
import '../util/images.dart';

class SettingView extends StatelessWidget {
  SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {

                },
                child: Icon(Icons.settings,color: Colors.white,size: 35,),
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
        color: ThemeColors.background,
        child: Column(
          children: [
            Spacer(),
            Container(
              width: double.infinity, // Set button width to match the container
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    print("ok");
                    Get.off(Login());
                  },
                  style: ElevatedButton.styleFrom(
                   backgroundColor: ThemeColors.tabColor
                  ),
                  child: Text("Sign Out",style: FontStyles.LargeTitle_OutFif_white,),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        padding: EdgeInsets.all(18),
        color: ThemeColors.tabColor,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.off(BottomNavigation(), arguments: 0);
                  },
                  child: Image.asset(Images.house),
                ),
                GestureDetector(
                  onTap: () {
                    Get.off(BottomNavigation(), arguments: 1);
                  },
                  child: Image.asset(Images.wallet),
                ),
                GestureDetector(
                  onTap: () {
                    Get.off(BottomNavigation(), arguments: 2);
                  },
                  child: Image.asset(Images.person_fill),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


