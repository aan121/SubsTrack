import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:substrack/Services/notifi_service.dart';
import 'package:substrack/add/subscription-model.dart';

import '../util/extra.dart';
import 'User.dart';

class HomeController extends GetxController {
  RxList<SubscriptionModel> subscriptionList = <SubscriptionModel>[].obs;
  RxList<SubscriptionModel> foundCategories = <SubscriptionModel>[].obs;
  RxInt totalSpendMonthValue = 0.obs;
  RxInt totalSpendBelowValue = 0.obs;
  RxInt totalSpendPreMonthValue = 0.obs;

  final database = FirebaseDatabase.instance.ref("Subscriptions");

  Future<void> fetchData() async {
    try {
      DatabaseEvent event = await database.child(Extra.CURRENT_USER_ID).once();
      DataSnapshot dataSnapshot = event.snapshot;
      if (dataSnapshot.value != null) {
        Map<dynamic, dynamic> data =
            dataSnapshot.value as Map<dynamic, dynamic>;
        subscriptionList.clear();
        totalSpendMonthValue.value = 0;
        totalSpendBelowValue.value=0;
        totalSpendPreMonthValue.value=0;
        data.forEach((key, value) {
          DateTime now = DateTime.now();
          int currentMonth = now.month;
          int preMonth = now.month-1;

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
          );
          subscriptionModel.subscriptionId = key;
          calculationSubscription(subscriptionModel);
          subscriptionList.add(subscriptionModel);
          subscriptionList.refresh();

          int subscriptionMonth = int.parse(value['subscriptionMonth']);
          if (subscriptionMonth == currentMonth && subscriptionModel.isDateIncrease) {
            int cost = int.parse(subscriptionModel.subscriptionCost);
            totalSpendMonthValue.value += cost;
          }else if(preMonth>0){
            if(subscriptionMonth==currentMonth-1){
              int cost = int.parse(subscriptionModel.subscriptionCost);
              totalSpendPreMonthValue +=cost;
            }
          }
        });
        totalSpendBelowValue.value=totalSpendPreMonthValue.value-totalSpendMonthValue.value;
        foundCategories.value = subscriptionList;

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
      String subscriptionId, String newDay, String newMonth) {
    database.child(Extra.CURRENT_USER_ID).child(subscriptionId).update({
      'subscriptionDay': newDay,
      'subscriptionMonth': newMonth,
      'isDateIncrease':true,
    }).then((_) {
      print('Subscription date updated successfully');
    }).catchError((error) {
      print('Failed to update subscription date: $error');
    });
  }

  void calculationSubscription(SubscriptionModel subscriptionModel) {
    DateTime now = DateTime.now();
    String month = subscriptionModel.subscriptionMonth.toString().padLeft(2, '0');
    String day = subscriptionModel.subscriptionDay.toString().padLeft(2, '0');
    String year = now.year.toString();
    String dateString = '$year-$month-$day'; // Example date string
    DateTime dateTime = DateTime.parse(dateString);

    Duration difference = dateTime.difference(now);
    int differenceInSixMonths = (dateTime.year - now.year) * 12 + dateTime.month - now.month;
    differenceInSixMonths = differenceInSixMonths ~/ 6;

    int subscriptionMonth = int.parse(subscriptionModel.subscriptionMonth);
    int subscriptionDay = int.parse(subscriptionModel.subscriptionDay);
    String CurrentDate="${now.year.toString().padLeft(2,'0')}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')}";
    if (subscriptionModel.subscriptionCycle == "Weekly") {
      if (CurrentDate ==dateString) {
        subscriptionDay += 7;
        updateSubscriptionDateInDatabase(subscriptionModel.subscriptionId,
            subscriptionDay.toString(), subscriptionMonth.toString());
      } else {
        subscriptionModel.subscriptionMonth = subscriptionMonth.toString();
        subscriptionModel.subscriptionDay = subscriptionDay.toString();
      }
    } else if (subscriptionModel.subscriptionCycle == "Monthly") {
      if (CurrentDate ==dateString) {
        subscriptionMonth++;
        subscriptionModel.subscriptionMonth = "$subscriptionMonth";
        subscriptionModel.subscriptionDay = "$subscriptionDay";
      } else {
        subscriptionModel.subscriptionMonth = subscriptionMonth.toString();
        subscriptionModel.subscriptionDay = subscriptionDay.toString();
      }
    } else if (subscriptionModel.subscriptionCycle == "3 Months") {
      if (CurrentDate ==dateString) {
        subscriptionMonth += 3;
        subscriptionModel.subscriptionMonth = "$subscriptionMonth";
        subscriptionModel.subscriptionDay = "$subscriptionDay";
      } else {
        subscriptionModel.subscriptionMonth = "$subscriptionMonth";
        subscriptionModel.subscriptionDay = "$subscriptionDay";
      }
    } else if (subscriptionModel.subscriptionCycle == "6 Months") {
      if (CurrentDate ==dateString) {
        subscriptionMonth += 6;
        subscriptionModel.subscriptionMonth = "$subscriptionMonth";
        subscriptionModel.subscriptionDay = "$subscriptionDay";
      } else {
        subscriptionModel.subscriptionMonth = subscriptionMonth.toString();
        subscriptionModel.subscriptionDay = subscriptionDay.toString();
      }
    } else if (subscriptionModel.subscriptionCycle == "Yearly") {
      if (CurrentDate ==dateString) {
        subscriptionMonth += 12;
        subscriptionModel.subscriptionMonth = "$subscriptionMonth";
        subscriptionModel.subscriptionDay = "$subscriptionDay";
      } else {
        subscriptionModel.subscriptionMonth = subscriptionMonth.toString();
        subscriptionModel.subscriptionDay = subscriptionDay.toString();
      }
    } else if (subscriptionDay > 28) {
      subscriptionDay = (subscriptionDay % 28) + 1;
      subscriptionModel.subscriptionMonth = subscriptionMonth.toString();
      subscriptionModel.subscriptionDay = subscriptionDay.toString();
    } else if (subscriptionMonth > 12) {
      subscriptionMonth = (subscriptionMonth % 12) + 1;
      subscriptionModel.subscriptionMonth = subscriptionMonth.toString();
      subscriptionModel.subscriptionDay = subscriptionDay.toString();
    }
    subscriptionModel.subscriptionYear = now.year.toString();
  }
}
