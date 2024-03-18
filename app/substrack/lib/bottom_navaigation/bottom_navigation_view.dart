import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:substrack/add/add_subscription_view.dart';

import '../account/account_view.dart';
import '../home/home_view.dart';
import '../track/track_view.dart';
import '../util/color.dart';
import '../util/images.dart';
import 'botton_navigation_controller.dart';


class BottomNavigation extends StatelessWidget {
  BottomNavigation({Key? key}) : super(key: key);
  BottomNavigationController controller = Get.put(BottomNavigationController());
  final tabs = [
    const Center(
      child: Home(),
    ),
    const Center(
      child: Track()
    ),
    const Center(
      child: Account()
    ),
  ];
  int currentIndex = Get.arguments??0;

  double widthOrHeight=35;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Obx(() => tabs[
        controller.currentIndex.value
      ]),
      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          backgroundColor: ThemeColors.tabColor,
          currentIndex: controller.currentIndex.value,
          fixedColor: ThemeColors.tabColor,
              showSelectedLabels: false,
              showUnselectedLabels: false,
          items:  [
            BottomNavigationBarItem(
              icon:Image.asset(controller.currentIndex.value==0 ? Images.house_fill:Images.house,width: widthOrHeight,height: widthOrHeight,),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(controller.currentIndex.value==1?Images.wallet_fill:Images.wallet,width: widthOrHeight,height: widthOrHeight,),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(controller.currentIndex.value==2?Images.person:Images.person_fill,width: widthOrHeight,height: widthOrHeight,),
              label: '',
            ),
          ],
          onTap: (index) {
            controller.changePage(index);
          },
        ),
      ),
    );
  }
}
