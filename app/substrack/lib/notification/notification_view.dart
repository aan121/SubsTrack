import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:substrack/notification/notification_controller.dart';
import 'package:substrack/util/color.dart';
import 'package:substrack/util/fonts_styles.dart';

import '../Services/notifi_service.dart';
import '../bottom_navaigation/bottom_navigation_view.dart';
import '../signIn/login_view.dart';
import '../util/images.dart';

class NotificationView extends StatelessWidget {
  NotificationView({Key? key}) : super(key: key);
  NotificationController notificationController =
  Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await notificationController.fetchData();
    });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.off(const Login());
                },
                child: Image.asset(Images.setting),
              ),
              const Text(
                "Substrack",
                style: FontStyles.Main_Home_Title,
              ),
              Stack(
                children: [
                  Icon(Icons.notifications,color: Colors.white,size: 35,),
                  Positioned(
                    bottom: 19,
                    left: 18,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 8,
                      child: Obx(() => Text(
                        notificationController.totalNotification.value
                            .toString(),
                        style: FontStyles.verySmallTitle,
                      )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        backgroundColor: ThemeColors.background,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: ThemeColors.background,
        ),
        child: Obx(
              () => Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: notificationController.notifyModelList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, ThemeColors.background],
                        ),
                        border:
                        Border.all(color: ThemeColors.tabColor, width: 0.5),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Text(
                                "your ${notificationController.notifyModelList[index].notifyMessage} Subscription is due in",
                                style: FontStyles.smallTitle,
                              ),
                            ),
                            Text(
                              "${notificationController.notifyModelList[index].expireDay}",
                              style: FontStyles.smallTitle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Center(
                            child: Column(
                              children: [
                                const Text(
                                  "Are you sure you want to delete \n "
                                      "          this notification?  ",
                                  style: FontStyles.roman_bold_black,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Close the dialog
                                      },
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'roman_bold'),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        notificationController.deleteData(index);
                                        Get.back();
                                      },
                                      child: const Text(
                                        "Delete",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'roman_bold'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        padding: EdgeInsets.all(18),
        color: ThemeColors.tabColor,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24,0,24,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){
                      Get.off(BottomNavigation(),arguments: 0);
                    },
                    child: Image.asset(Images.house)),
                GestureDetector(
                    onTap: (){
                      Get.off(BottomNavigation(),arguments: 1);
                    },
                    child: Image.asset(Images.wallet)),
                GestureDetector(
                    onTap: (){
                      Get.off(BottomNavigation(),arguments: 2);
                    },
                    child: Image.asset(Images.person_fill)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
