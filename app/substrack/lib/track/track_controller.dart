import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:substrack/home/home_controller.dart';
import 'package:substrack/track/road_data.dart';
import 'package:substrack/util/color.dart';
import '../add/subscription-model.dart';
import '../home/old_subscription.dart';
import '../util/extra.dart';

class TrackController extends GetxController {

  RxList<SubscriptionModel> subscriptionList = <SubscriptionModel>[].obs;
  RxList<SubscriptionModel> filterData = <SubscriptionModel>[].obs;
  final database = FirebaseDatabase.instance.ref("Subscriptions");
  var selectedCategories = ''.obs;
  late double totalPrice;
  final totalPriceNode = FirebaseDatabase.instance.ref("TotalPrice");
  final OldSubscriptions = FirebaseDatabase.instance.ref("OldSubscriptions");
  RxList<OldSubscriptionModel> oldSubscriptionList = <OldSubscriptionModel>[].obs;
  List<BarChartGroupData> get barGroups {
    return _chartGroups();
  }
  @override
  void onInit() {
    super.onInit();
    fetchDataOld();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      database.child(Extra.CURRENT_USER_ID).onValue.listen((event) {
        DataSnapshot dataSnapshot = event.snapshot;
        if (dataSnapshot.value != null) {
          Map<dynamic, dynamic> data = dataSnapshot.value as Map<dynamic, dynamic>;
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
              value['subscriptionYear'],
              value['subscriptionLastMonth'],
            );

            subscriptionModel.subscriptionId = key;
            subscriptionList.add(subscriptionModel);
            subscriptionModel.subscriptionId;
          });
          filterData.value = subscriptionList;
        }
      });
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
      subscriptionList.refresh();
      if(subscriptionList.isEmpty){
        HomeController homeController = Get.put(HomeController());
        homeController.subscriptionList.clear();
      }
      Get.back();
      successfullySnackBar("Congratulations!", "Deleted successful");
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
    List<BarChartGroupData> list =[];
    List<MyGroupData> groupData =[];
    list.clear();
    groupData.clear();
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

    for (final subscription in oldSubscriptionList) {
      for (final data in groupData) {
        if (data.month == subscription.subscriptionMonth && subscription.subscriptionYear==DateTime.now().year.toString()) {
          data.totalCost += double.parse(subscription.oldSubscriptionCost);
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

  Future<void> fetchDataTotalPriceOrUpdate() async {
    try {
      DatabaseEvent event = await totalPriceNode
          .child(Extra.CURRENT_USER_ID)
          .child('totalPrice')
          .child(DateTime.now().year.toString())
          .once();

      DataSnapshot dataSnapshot = event.snapshot;

      if (dataSnapshot.value != null) {
         totalPrice = double.parse(dataSnapshot.value.toString());
         print(totalPrice);

      } else {
      }
    } catch (error) {
      print("Error fetching data from Firebase: $error");
    }
  }

  Future<void> fetchDataOld() async {
    try {
      OldSubscriptions.child(Extra.CURRENT_USER_ID).onValue.listen((event) {
        DataSnapshot dataSnapshot = event.snapshot;
        if (dataSnapshot.value != null) {
          Map<dynamic, dynamic> data = dataSnapshot.value as Map<dynamic, dynamic>;
          oldSubscriptionList.clear();
          data.forEach((key, value) {
            OldSubscriptionModel oldSubscriptionModel = OldSubscriptionModel(
              value['oldSubscriptionCost'],
              value['subscriptionMonth'],
              value['subscriptionYear'],
            );
            oldSubscriptionList.add(oldSubscriptionModel);
          });
        }
      });
    } catch (error) {
      print("Error fetching data from Firebase: $error");
    }
  }

}
