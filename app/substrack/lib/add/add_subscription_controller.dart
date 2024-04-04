import 'dart:async';
import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:substrack/add/subscription-model.dart';
import 'package:substrack/util/extra.dart';

import '../bottom_navaigation/bottom_navigation_view.dart';
import '../home/old_subscription.dart';
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
  final totalPriceNode = FirebaseDatabase.instance.ref("TotalPrice");
  final OldSubscriptions = FirebaseDatabase.instance.ref("OldSubscriptions");
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
    int lastMonth;
    bool isDateIncrease = false;
    if (name.isEmpty) {
      cancelSnackBar("Error!", "Please add subscription name!");
      return;
    } else if (day.isEmpty) {
      cancelSnackBar("Error!", "Please add subscription day!");
      return;
    } else if (selectedMonth.value.isEmpty) {
      cancelSnackBar("Error!", "Please add subscription month!");
      return;
    } else if (cost.isEmpty) {
      cancelSnackBar("Error!", "Please add subscription cost!");
      return;
    }else if(currentDay > int.parse(day) && currentMonth< int.parse(month)){
      addSubscriptionInDataBase(name,cost);
      successfullySnackBar("Congratulation!", "Subscription added Successfully!");
      return;
    }
    else if (currentDay > int.parse(day)) {
      cancelSnackBar("Error!",
          "Please select a current/future Day $currentDay   $day");
      return;
    } else if (currentMonth > int.parse(month)) {
      cancelSnackBar("Error!", "Select a current/future Month");
      return;
    } else if (currentDay.toString() == day) {
      isDateIncrease = true;
      lastMonth=currentMonth;
      if (selectedCycles.value.toString() == "Weekly") {
        currentDay += 7;
        if(currentDay>30){
          currentDay=(currentDay%30)+1;
          currentMonth++;
          if(currentMonth>12){
            currentMonth=(currentMonth%12)+1;
          }
        }
      } else if (selectedCycles.value.toString() == "Monthly") {
        currentMonth += 1;
        if(currentMonth>12){
          currentMonth=(currentMonth%12)+1;
        }
      } else if (selectedCycles.value.toString() == "3 Months") {
        currentMonth += 3;
        if(currentMonth>12){
          currentMonth=(currentMonth%12)+1;
        }
      } else if (selectedCycles.value.toString() == "6 Months") {
        currentMonth += 6;
        if(currentMonth>12){
          currentMonth=(currentMonth%12)+1;
        }
      } else if (selectedCycles.value.toString() == "Yearly") {
        currentMonth += 12;
        if(currentMonth>12){
          currentMonth=(currentMonth%12)+1;
        }
      }
      if(DateTime.now().day.toString()==selectedDay.value && DateTime.now().month.toString()==selectedMonth.value){
        isDateIncrease=true;
        updateSubscription(name,cost,currentDay,currentMonth,true,lastMonth);
        OldSubscriptionAdded(cost,lastMonth.toString(),DateTime.now().year.toString());
      }
      return;
      }else {
      addSubscriptionInDataBase(name, cost);
    }
  }

  void successfullySnackBar(String title, String message) {
    Get.snackbar(title, message, backgroundColor: ThemeColors.tabColor);
      Get.off(BottomNavigation());
  }

  void cancelSnackBar(String title, String message) {
    Get.snackbar(title, message,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white);
  }

  void addSubscriptionInDataBase(String name, String cost) {
    SubscriptionModel subscriptionModel = SubscriptionModel(
        name,
        cost,
        selectedDay.value.toString(),
        selectedMonth.value.toString(),
        selectedCycles.value.toString(),
        selectedCategories.value.toString(),
        Extra.CURRENT_USER_ID.trim(),
        false,
        DateTime.now().year.toString(),selectedMonth.value.toString(),);
    Map<String, dynamic> userSubscription = subscriptionModel.toJson();
    database
        .child(Extra.CURRENT_USER_ID)
        .push()
        .set(userSubscription)
        .then((value) {
      if(DateTime.now().day.toString()==selectedDay.value && DateTime.now().month.toString()==selectedMonth.value){
        fetchData();
      }
      successfullySnackBar("Congratulation!", "Subscription added successfully!");

    });
  }


  Future<void> fetchData() async {
    try {
      DatabaseEvent event = await totalPriceNode
          .child(Extra.CURRENT_USER_ID)
          .child('totalPrice')
          .child(DateTime.now().year.toString())
          .child(selectedMonth.value.toString())
          .once();

      DataSnapshot dataSnapshot = event.snapshot;
      int getPrice=int.parse(costController.value.text.toString());

      if (dataSnapshot.value != null) {
        String totalPrice = dataSnapshot.value.toString();
        int priceSubscription=int.parse(totalPrice);
        int updatedPrice=priceSubscription+getPrice;

        updateMonthPrice(selectedMonth.value.toString(),updatedPrice.toString());
        updatedPrice=0;

      } else {
        updateMonthPrice(selectedMonth.value.toString(),getPrice.toString());

      }
    } catch (error) {
      print("Error fetching data from Firebase: $error");
    }
  }
  void updateMonthPrice(String date,String price){
    totalPriceNode
        .child(Extra.CURRENT_USER_ID)
        .child('totalPrice')
        .child(DateTime.now().year.toString())
        .child(date)
        .set(price)
        .then((_) {
      successfullySnackBar(
          "Congratulation!", "Subscription added successfully!");
    }).catchError((error) {
      print('Error adding total price: $error');
    });
    print('Total Price not found');
  }

  void updateSubscription(String name,String cost,int currentDay,int currentMonth,bool isDateIncrease,int lastMonth) {
    SubscriptionModel subscriptionModel = SubscriptionModel(
        name,
        cost,
        currentDay.toString(),
        currentMonth.toString(),
        selectedCycles.value.toString(),
        selectedCategories.value.toString(),
        Extra.CURRENT_USER_ID.trim(),
        isDateIncrease,
        DateTime.now().year.toString(),
        lastMonth.toString());
    Map<String, dynamic> userSubscription = subscriptionModel.toJson();

    database
        .child(Extra.CURRENT_USER_ID)
        .push()
        .set(userSubscription)
        .then((value) {
      if(DateTime.now().day.toString()==selectedDay.value && DateTime.now().month.toString()==selectedMonth.value){
        fetchData();
      }
      successfullySnackBar("Congratulation!", "Subscription added successfully!");

    });
  }
  void OldSubscriptionAdded(String cost , String month , String Year ){

    OldSubscriptionModel oldSubscriptionModel = OldSubscriptionModel(cost,month,Year);
    Map<String, dynamic> oldSubscription = oldSubscriptionModel.toJson();
    OldSubscriptions
        .child(Extra.CURRENT_USER_ID)
        .push()
        .set(oldSubscription)
        .then((value) {

    });

  }
}

