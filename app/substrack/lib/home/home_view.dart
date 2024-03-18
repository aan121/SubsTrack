import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:substrack/add/add_subscription_view.dart';
import 'package:substrack/home/home_controller.dart';
import 'package:substrack/home/subscription_list/subscription_list_view.dart';
import 'package:substrack/notification/notification_view.dart';
import 'package:substrack/util/fonts_styles.dart';
import '../signIn/login_view.dart';
import '../util/color.dart';
import '../util/images.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.fetchData();
    });
    final currencyFormatter =
        NumberFormat.currency(locale: 'en_US', symbol: '\$ ', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
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
                  Get.to( NotificationView());
                },
                child: Image.asset(Images.notification),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black, ThemeColors.background],
                            ),
                            borderRadius: BorderRadius.circular(15),
                            border: const GradientBoxBorder(
                                width: 1,
                                gradient: LinearGradient(colors: [
                                  ThemeColors.tabColor,
                                  Colors.indigo,
                                ]))),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Current spend this month",
                                style: FontStyles.romanSmallTitleBlack,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Obx(
                                () => Text(
                                    currencyFormatter.format(
                                        controller.totalSpendMonthValue.value),
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        fontFamily: 'roman_bold')),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Obx(
                                    () => Text(
                                  controller.totalSpendBelowValue.value > controller.totalSpendMonthValue.value
                                      ? currencyFormatter.format(controller.totalSpendBelowValue.value)
                                      : "No previous costs available",
                                  style: FontStyles.romanSmallTitleBlack,
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Subscriptions",
                              style: FontStyles.meduimTitle_roman_bold,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(const AddSubscriptionView());
                              },
                              child: const Icon(
                                Icons.add_circle_outline_rounded,
                                color: Colors.white,
                                size: 32,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: const GradientBoxBorder(
                                width: 1,
                                gradient: LinearGradient(colors: [
                                  ThemeColors.tabColor,
                                  Colors.indigo,
                                ]))),
                        height: 180,
                        width: double.infinity,
                        child: Obx(
                          () => ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const ScrollPhysics(),
                            // Disable scrolling
                            itemCount: controller.subscriptionList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SubscriptionList(
                                  value: controller.subscriptionList[index],
                                  onTap: () {
                                    // Handle item tap
                                  },
                                  onChange: (value) {
                                    controller.subscriptionList[index] = value;
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0, right: 30),
                            child: Text(
                              "Search",
                              style: FontStyles.meduimTitle_roman_bold,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SizedBox(
                                height: 40,
                                child: TextFormField(
                                  onChanged: (value) {
                                    controller.filterPlayer(value);
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Search',
                                    hintStyle: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                        fontFamily: 'roman_bold'),
                                    alignLabelWithHint: true,
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.only(left: 30),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: const GradientBoxBorder(
                                width: 1,
                                gradient: LinearGradient(colors: [
                                  ThemeColors.tabColor,
                                  Colors.indigo,
                                ]))),
                        height: 180,
                        width: double.infinity,
                        child: Obx(
                          () => ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const ScrollPhysics(),
                            // Disable scrolling
                            itemCount: controller.foundCategories.value.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SubscriptionList(
                                  value: controller.foundCategories[index],
                                  onTap: () {
                                    // Handle item tap
                                  },
                                  onChange: (value) {
                                    controller.foundCategories[index] = value;
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
