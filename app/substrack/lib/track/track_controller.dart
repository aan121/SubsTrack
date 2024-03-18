import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:substrack/track/road_data.dart';
import 'package:substrack/util/color.dart';
import '../add/subscription-model.dart';
import '../util/extra.dart';

class TrackController extends GetxController {
  RxList<SubscriptionModel> subscriptionList = <SubscriptionModel>[].obs;
  RxList<SubscriptionModel> filterData = <SubscriptionModel>[].obs;
  final database = FirebaseDatabase.instance.ref("Subscriptions");
  var selectedCategories = ''.obs;

  List<BarChartGroupData> get barGroups {
    return _chartGroups();
  }

  Future<void> fetchData() async {
    try {
      DatabaseEvent event = await database.child(Extra.CURRENT_USER_ID).once();
      DataSnapshot dataSnapshot = event.snapshot;
      if (dataSnapshot.value != null) {
        Map<dynamic, dynamic> data =
            dataSnapshot.value as Map<dynamic, dynamic>;
        subscriptionList.clear();
        data.forEach((key, value) {
          SubscriptionModel subscriptionModel = SubscriptionModel(
            value['subscriptionName'],
            value['subscriptionCost'],
            value['subscriptionDay'],
            value['subscriptionMonth'],
            value['subscriptionCycle'],
            value['subscriptionCategory'],
            value['currentUserID'],
            value['isDateIncrease'],
            value['subscriptionYear']
          );

          subscriptionModel.subscriptionId = key;
          subscriptionList.add(subscriptionModel);
          subscriptionModel.subscriptionId;

        });
        filterData.value = subscriptionList;
      }
    } catch (error) {
      print("Error fetching data from Firebase: $error");
    }
  }

  void deleteData(String subscriptionId) {
    database
        .child(Extra.CURRENT_USER_ID)
        .child(subscriptionId)
        .remove()
        .then((_) {
      subscriptionList.removeWhere((subscription) => subscription.subscriptionId == subscriptionId);
      filterData.removeWhere((subscription) => subscription.subscriptionId == subscriptionId);

      Get.back();
      successfullySnackBar("Done!", "Subscription has been deleted!");
    });
  }

  void updateSelectedCategories(String newCategories) {
    selectedCategories.value = newCategories;
    filterPlayer(newCategories);
  }

  void filterPlayer(String categories) {
    if (categories == "All") {
      filterData.value = subscriptionList;
    } else {
      filterData.value = filterData
          .where((user) => user.subscriptionCategory
              .toLowerCase()
              .contains(categories.toLowerCase()))
          .toList();
    }
  }

  void successfullySnackBar(String title, String message) {
    Get.snackbar(title, message,
        backgroundColor: Colors.amber, colorText: Colors.white);
  }

  void cancelSnackBar(String title, String message) {
    Get.snackbar(title, message,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white);
  }

  List<BarChartGroupData> _chartGroups() {

    List<BarChartGroupData> list = [];
    List<MyGroupData> groupData = [];

    groupData.add(MyGroupData("1", 0));
    groupData.add(MyGroupData("2", 0));
    groupData.add(MyGroupData("3", 0));
    groupData.add(MyGroupData("4", 0));
    groupData.add(MyGroupData("5", 0));
    groupData.add(MyGroupData("6", 0));
    groupData.add(MyGroupData("7", 0));
    groupData.add(MyGroupData("8", 0));
    groupData.add(MyGroupData("9", 0));
    groupData.add(MyGroupData("10", 0));
    groupData.add(MyGroupData("11", 0));
    groupData.add(MyGroupData("12", 0));

    for (final subscription in subscriptionList) {
      for (final data in groupData) {
        if (data.month == subscription.subscriptionMonth) {
          data.totalCost += double.parse(subscription.subscriptionCost);
        }
      }
    }
    for(final group in groupData) {
      list.add(BarChartGroupData(
        x: int.parse(group.month)-1,
        barRods: [
          BarChartRodData(
            toY: group.totalCost,
            color: ThemeColors.tabColor,
          )
        ],
      ));
    }
    return list;
  }

  void updateSubscriptionDateInDatabase(
      String subscriptionId, String newDay, String newMonth) {
    database.child(Extra.CURRENT_USER_ID).child(subscriptionId).update({
      'subscriptionDay': newDay,
      'subscriptionMonth': newMonth,
    }).then((_) {
      print('Subscription date updated successfully!');
    }).catchError((error) {
      print('Failed to update subscription date: $error');
    });
  }
}
