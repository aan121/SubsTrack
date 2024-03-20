import 'dart:async';
import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:substrack/add/subscription-model.dart';
import 'package:substrack/util/extra.dart';

import '../bottom_navaigation/bottom_navigation_view.dart';
import '../util/color.dart';

class AddSubscriptionController extends GetxController {
  var selectedDay = 'Day'.obs;
  var selectedDateDefault = 'Day'.obs;
  var selectedMonth = 'Month'.obs;
  var selectedCycles = 'Weekly'.obs;
  var selectedCategories = 'Health and Fitness'.obs;
  Rx<TextEditingController> subscriptionNameController =
      TextEditingController().obs;
  Rx<TextEditingController> costController = TextEditingController().obs;
  final database = FirebaseDatabase.instance.ref("Subscriptions");

  void updateSelectedDay(String newDate) {
    selectedDay.value = newDate;
  }

  void updateSelectedMonth(String newMonth) {
    selectedMonth.value = newMonth;
  }

  void updateSelectedCycles(String newCycle) {
    selectedCycles.value = newCycle;
  }

  void updateSelectedCategories(String newCategories) {
    selectedCategories.value = newCategories;
  }

  void addSubscriptionUser() {
    DateTime now = DateTime.now();
    int currentMonth = now.month;
    int currentDay = now.day;

    String name = subscriptionNameController.value.text.toString().trim();
    String cost = costController.value.text.toString().trim();
    String day = selectedDay.value.toString();
    String month = selectedMonth.value.toString();
    bool isDateIncrease=false;
    if (name.isEmpty) {
      cancelSnackBar("Error!", "Please add the name of subscription!.");
      return;
    } else if (day.isEmpty) {
      cancelSnackBar("Error!", "Please add the day of subscription!.");
      return;
    } else if (selectedMonth.value.isEmpty) {
      cancelSnackBar("Error!", "Please add the month of subscription!.");
      return;
    } else if (cost.isEmpty) {
      cancelSnackBar("Error!", "Please add the cost of subscription!");
      return;
    }else if(currentDay > int.parse(day) && currentMonth< int.parse(month)){
      addSubscriptionInDataBase(name,cost);
      successfullySnackBar("Congratulation!", "Subscription added Successfully!");
      return;
    }

    else if (currentDay > int.parse(day)) {
      cancelSnackBar("Error!", "Please select a future date");
      return;
    } else if (currentMonth > int.parse(month)) {
      cancelSnackBar("Error!", "Please select a future date");
      return;
    } else if (currentDay.toString() == day) {
      isDateIncrease=true;
      if (selectedCycles.value.toString() == "Weekly") {
        currentDay += 7;
      } else if (selectedCycles.value.toString() == "Monthly") {
        currentMonth += 1;
      } else if (selectedCycles.value.toString() == "3 Months") {
        currentMonth += 3;
      } else if (selectedCycles.value.toString() == "6 Months") {
        currentMonth += 6;
      } else if (selectedCycles.value.toString() == "Yearly") {
        currentMonth += 12;
      } else if (currentDay > 30) {
        currentDay = (currentDay % 12) + 1;
      } else if (currentMonth > 12) {
        currentMonth = (currentMonth % 12) + 1;
      }
      SubscriptionModel subscriptionModel = SubscriptionModel(
          name,
          cost,
          currentDay.toString(),
          currentMonth.toString(),
          selectedCycles.value.toString(),
          selectedCategories.value.toString(),
          Extra.CURRENT_USER_ID.trim(),isDateIncrease,now.year.toString());
      Map<String, dynamic> userSubscription = subscriptionModel.toJson();

      database
          .child(Extra.CURRENT_USER_ID)
          .push()
          .set(userSubscription)
          .then((value) {
        successfullySnackBar(
            "Congratulation", "Subscription added Successfully!");
      });
      return;
    } else {
      addSubscriptionInDataBase(name,cost);
    }
  }

  void successfullySnackBar(String title, String message) {
    Get.snackbar(title, message, backgroundColor: ThemeColors.tabColor);
    Timer(const Duration(seconds: 2), () {
      Get.off(BottomNavigation());
    });
  }

  void cancelSnackBar(String title, String message) {
    Get.snackbar(title, message,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white);
  }

  void addSubscriptionInDataBase(String name,String cost) {
    SubscriptionModel subscriptionModel = SubscriptionModel(
        name,
        cost,
        selectedDay.value.toString(),
        selectedMonth.value.toString(),
        selectedCycles.value.toString(),
        selectedCategories.value.toString(),
        Extra.CURRENT_USER_ID.trim(),false,
        DateTime.now().year.toString());
    Map<String, dynamic> userSubscription = subscriptionModel.toJson();

    database
        .child(Extra.CURRENT_USER_ID)
        .push()
        .set(userSubscription)
        .then((value) {
      successfullySnackBar(
          "Congratulation", "Subscription added Successfully!");
    });
  }
}
