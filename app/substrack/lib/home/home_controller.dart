import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:substrack/Services/notifi_service.dart';
import 'package:substrack/add/subscription-model.dart';
import 'package:substrack/track/track_controller.dart';

import '../util/extra.dart';
import 'old_subscription.dart';


class HomeController extends GetxController {
  RxList<SubscriptionModel> subscriptionList = <SubscriptionModel>[].obs;
  RxList<SubscriptionModel> foundCategories = <SubscriptionModel>[].obs;
  RxInt totalSpendMonthValue = 0.obs;
  RxInt totalSpendBelowValue = 0.obs;
  RxInt totalSpendPreMonthValue = 0.obs;
  final totalPriceNode = FirebaseDatabase.instance.ref("TotalPrice");
  final database = FirebaseDatabase.instance.ref("Subscriptions");
  final OldSubscriptions = FirebaseDatabase.instance.ref("OldSubscriptions");
  @override
  void onInit() {
    super.onInit();
    fetchData();
    fetchDataTotalPrice();
  }

  Future<void> fetchData() async {
    try {
      DatabaseEvent event = await database.child(Extra.CURRENT_USER_ID).once();
      DataSnapshot dataSnapshot = event.snapshot;
      if (dataSnapshot.value != null) {
        Map<dynamic, dynamic> data =
            dataSnapshot.value as Map<dynamic, dynamic>;
        subscriptionList.clear();
        totalSpendMonthValue.value = 0;
        totalSpendBelowValue.value = 0;
        totalSpendPreMonthValue.value = 0;
        data.forEach((key, value) {
          DateTime now = DateTime.now();
          int currentMonth = now.month;
          int preMonth = now.month - 1;

          SubscriptionModel subscriptionModel = SubscriptionModel(
            value['subscriptionName'],
            value['subscriptionCost'],
            value['subscriptionDay'],
            value['subscriptionMonth'],
            value['subscriptionCycle'],
            value['subscriptionCategory'],
            value['currentUserID'],
            value['isDateIncrease'],
            value['subscriptionYear'],
            value['subscriptionLastMonth'],
          );
          subscriptionModel.subscriptionId = key;
          calculationSubscription(subscriptionModel);
          subscriptionList.add(subscriptionModel);
          subscriptionList.refresh();

          int subscriptionMonth = int.parse(value['subscriptionMonth']);
          if (subscriptionMonth == currentMonth &&
              subscriptionModel.isDateIncrease) {
            int cost = int.parse(subscriptionModel.subscriptionCost);
            totalSpendMonthValue.value += cost;
          } else if (preMonth > 0) {
            if (subscriptionMonth == currentMonth - 1) {
              int cost = int.parse(subscriptionModel.subscriptionCost);
              totalSpendPreMonthValue += cost;
            }
          }
        });
        totalSpendBelowValue.value =
            totalSpendPreMonthValue.value - totalSpendMonthValue.value;
        foundCategories.value = subscriptionList;
        fetchDataTotalPrice();
      }
    } catch (error) {
      print("Error fetching data from Firebase: $error");
    }
  }

  void filterPlayer(String categories) {
    if (categories.isEmpty) {
      foundCategories.value = subscriptionList;
    } else {
      foundCategories.value = foundCategories
          .where((user) => user.subscriptionName
              .toLowerCase()
              .contains(categories.toLowerCase()))
          .toList();
    }
  }

  @override
  void onReady() {
    super.onReady();
    NotificationService().initNotification();
  }

  void updateSubscriptionDateInDatabase(
      String subscriptionId, String newDay, String newMonth, String lastMonth) {
    database.child(Extra.CURRENT_USER_ID).child(subscriptionId).update({
      'subscriptionDay': newDay,
      'subscriptionMonth': newMonth,
      'isDateIncrease': true,
      'subscriptionLastMonth': lastMonth,
    }).then((_) {
      print('Subscription date updated successfully');
    }).catchError((error) {
      print('Failed to update subscription date: $error');
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

  void calculationSubscription(SubscriptionModel subscriptionModel) {
    DateTime now = DateTime.now();
    String month =
        subscriptionModel.subscriptionMonth.toString().padLeft(2, '0');
    String day = subscriptionModel.subscriptionDay.toString().padLeft(2, '0');
    String year = now.year.toString();
    String dateString = '$year-$month-$day'; // Example date string
    DateTime dateTime = DateTime.parse(dateString);

    int differenceInSixMonths =
        (dateTime.year - now.year) * 12 + dateTime.month - now.month;
    differenceInSixMonths = differenceInSixMonths ~/ 6;

    int subscriptionMonth = int.parse(subscriptionModel.subscriptionMonth);
    int subscriptionDay = int.parse(subscriptionModel.subscriptionDay);
    String CurrentDate =
        "${now.year.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    if (subscriptionModel.subscriptionCycle == "Weekly") {
      if (CurrentDate == dateString) {
        subscriptionDay += 7;
        String lastMonth = subscriptionMonth.toString();
        fetchDataTotalPriceOrUpdate(subscriptionMonth.toString(), subscriptionModel.subscriptionCost.toString());
        OldSubscriptionAdded(subscriptionModel.subscriptionCost,subscriptionMonth.toString(),DateTime.now().year.toString());

        if (subscriptionDay > 30) {
          subscriptionDay = (subscriptionDay % 30) + 1;
          subscriptionMonth++;
          if (subscriptionMonth > 12) {
            subscriptionMonth = (subscriptionMonth % 12) + 1;
          }
        }
        updateSubscriptionDateInDatabase(
            subscriptionModel.subscriptionId,
            subscriptionDay.toString(),
            subscriptionMonth.toString(),
            lastMonth);
      } else {
        subscriptionModel.subscriptionMonth = subscriptionMonth.toString();
        subscriptionModel.subscriptionDay = subscriptionDay.toString();
      }
    } else if (subscriptionModel.subscriptionCycle == "Monthly") {
      if (CurrentDate == dateString) {
        String lastMonth = subscriptionMonth.toString();
        fetchDataTotalPriceOrUpdate(subscriptionMonth.toString(), subscriptionModel.subscriptionCost);
        OldSubscriptionAdded(subscriptionModel.subscriptionCost,subscriptionMonth.toString(),DateTime.now().year.toString());

        subscriptionMonth++;
        if (subscriptionMonth > 12) {
          subscriptionMonth = (subscriptionMonth % 12) + 1;
        }
        subscriptionModel.subscriptionMonth = "$subscriptionMonth";
        subscriptionModel.subscriptionDay = "$subscriptionDay";

        updateSubscriptionDateInDatabase(
            subscriptionModel.subscriptionId,
            subscriptionDay.toString(),
            subscriptionMonth.toString(),
            lastMonth);

      } else {
        subscriptionModel.subscriptionMonth = subscriptionMonth.toString();
        subscriptionModel.subscriptionDay = subscriptionDay.toString();
      }
    } else if (subscriptionModel.subscriptionCycle == "3 Months") {
      if (CurrentDate == dateString) {
        String lastMonth = subscriptionMonth.toString();
        fetchDataTotalPriceOrUpdate(
            subscriptionMonth.toString(), subscriptionModel.subscriptionCost);
        OldSubscriptionAdded(subscriptionModel.subscriptionCost,subscriptionMonth.toString(),DateTime.now().year.toString());
        subscriptionMonth += 3;
        if (subscriptionMonth > 12) {
          subscriptionMonth = (subscriptionMonth % 12) + 1;
        }
        subscriptionModel.subscriptionMonth = "$subscriptionMonth";
        subscriptionModel.subscriptionDay = "$subscriptionDay";
        updateSubscriptionDateInDatabase(
            subscriptionModel.subscriptionId,
            subscriptionDay.toString(),
            subscriptionMonth.toString(),
            lastMonth);
      } else {
        subscriptionModel.subscriptionMonth = "$subscriptionMonth";
        subscriptionModel.subscriptionDay = "$subscriptionDay";
      }
    } else if (subscriptionModel.subscriptionCycle == "6 Months") {
      if (CurrentDate == dateString) {
        String lastMonth = subscriptionMonth.toString();
        fetchDataTotalPriceOrUpdate(subscriptionMonth.toString(), subscriptionModel.subscriptionCost);
        OldSubscriptionAdded(subscriptionModel.subscriptionCost,subscriptionMonth.toString(),DateTime.now().year.toString());

        subscriptionMonth += 6;
        if (subscriptionMonth > 12) {
          subscriptionMonth = (subscriptionMonth % 12) + 1;
        }
        updateSubscriptionDateInDatabase(
            subscriptionModel.subscriptionId,
            subscriptionDay.toString(),
            subscriptionMonth.toString(),
            lastMonth);
        subscriptionModel.subscriptionMonth = "$subscriptionMonth";
        subscriptionModel.subscriptionDay = "$subscriptionDay";
      } else {
        subscriptionModel.subscriptionMonth = subscriptionMonth.toString();
        subscriptionModel.subscriptionDay = subscriptionDay.toString();
      }
    } else if (subscriptionModel.subscriptionCycle == "Yearly") {
      if (CurrentDate == dateString) {
        String lastMonth = subscriptionMonth.toString();
        fetchDataTotalPriceOrUpdate(subscriptionMonth.toString(), subscriptionModel.subscriptionCost);
        OldSubscriptionAdded(subscriptionModel.subscriptionCost,subscriptionMonth.toString(),DateTime.now().year.toString());

        subscriptionMonth += 12;
        updateSubscriptionDateInDatabase(
            subscriptionModel.subscriptionId,
            subscriptionDay.toString(),
            subscriptionMonth.toString(),
            lastMonth);
        subscriptionModel.subscriptionMonth = "$subscriptionMonth";
        subscriptionModel.subscriptionDay = "$subscriptionDay";
      } else {
        subscriptionModel.subscriptionMonth = subscriptionMonth.toString();
        subscriptionModel.subscriptionDay = subscriptionDay.toString();
      }
    }
    subscriptionModel.subscriptionYear = now.year.toString();
  }

  Future<void> fetchDataTotalPrice() async {
    try {
      DatabaseEvent event = await totalPriceNode
          .child(Extra.CURRENT_USER_ID)
          .child('totalPrice')
          .child(DateTime.now().year.toString())
          .child(DateTime.now().month.toString())
          .once();

      DataSnapshot dataSnapshot = event.snapshot;
      if (dataSnapshot.value != null) {
        totalSpendMonthValue.value = int.parse(dataSnapshot.value.toString());
      }
    } catch (error) {
      print("Error fetching data from Firebase: $error");
    }
  }

  Future<void> fetchDataTotalPriceOrUpdate(String month, String cost) async {
    try {
      DatabaseEvent event = await totalPriceNode
          .child(Extra.CURRENT_USER_ID)
          .child('totalPrice')
          .child(DateTime.now().year.toString())
          .child(month)
          .once();

      DataSnapshot dataSnapshot = event.snapshot;
      int getPrice = int.parse(cost);

      if (dataSnapshot.value != null) {
        String totalPrice = dataSnapshot.value.toString();
        int priceSubscription = int.parse(totalPrice);
        int updatedPrice = priceSubscription + getPrice;

        updateMonthPrice(month, updatedPrice.toString());
        updatedPrice = 0;
      } else {
        updateMonthPrice(month, getPrice.toString());
      }
    } catch (error) {
      print("Error fetching data from Firebase: $error");
    }
  }

  void updateMonthPrice(String date, String price) {
    totalPriceNode
        .child(Extra.CURRENT_USER_ID)
        .child('totalPrice')
        .child(DateTime.now().year.toString())
        .child(date)
        .set(price)
        .then((_) {})
        .catchError((error) {
      print('Error adding total price: $error');
    });
    print('Total Price not found');
  }

  void deleteData(String subscriptionId) {
    database
        .child(Extra.CURRENT_USER_ID)
        .child(subscriptionId)
        .remove()
        .then((_) {
      subscriptionList.removeWhere(
          (subscription) => subscription.subscriptionId == subscriptionId);
      subscriptionList.refresh();
      subscriptionList.clear();
      fetchData();
      Get.back();
      if (subscriptionList.isEmpty) {
        TrackController trackController = Get.put(TrackController());
        trackController.subscriptionList.clear();
      }
    });
  }
}
