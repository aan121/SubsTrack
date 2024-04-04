import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:substrack/add/subscription-model.dart';
import 'package:substrack/notification/notification_model.dart';

import '../Services/notifi_service.dart';
import '../util/extra.dart';

class NotificationController extends GetxController {
  RxList<SubscriptionModel> subscriptionList = <SubscriptionModel>[].obs;
  RxList<NotificationModel> notifyModelList = <NotificationModel>[].obs;
  RxInt totalNotification = 0.obs;
  RxBool isOneTimeFetch=true.obs;
  final database = FirebaseDatabase.instance.ref("Subscriptions");
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late SubscriptionModel subscriptionModel;

  Future<void> fetchData() async {
    try {
      if(isOneTimeFetch.isTrue) {
        isOneTimeFetch.value=false;
        DatabaseEvent event = await database.child(Extra.CURRENT_USER_ID)
            .once();
        DataSnapshot dataSnapshot = event.snapshot;
        if (dataSnapshot.value != null) {
          Map<dynamic, dynamic> data =
          dataSnapshot.value as Map<dynamic, dynamic>;
          subscriptionList.clear();
          data.forEach((key, value) {
            subscriptionModel = SubscriptionModel(
                value['subscriptionName'],
                value['subscriptionCost'],
                value['subscriptionDay'],
                value['subscriptionMonth'],
                value['subscriptionCycle'],
                value['subscriptionCategory'],
                value['currentUserID'],
                value['isDateIncrease'],
                value['subscriptionYear']
              , value['subscriptionLastMonth'],
            );
            subscriptionList.add(subscriptionModel);
            checkDayAndMonth();
          });
        }
      }
    } catch (error) {
      print("Error fetching data from Firebase: $error");
    }
  }
  void deleteData(int index){
    notifyModelList.removeAt(index);
    notifyModelList.refresh();
  }

  void checkDayAndMonth() {
    DateTime now = DateTime.now();
    String month = subscriptionModel.subscriptionMonth.toString().padLeft(2, '0');
    String day = subscriptionModel.subscriptionDay.toString().padLeft(2, '0');
    String year=now.year.toString();
    String dateString = '$year-$month-$day'; // Example date string
    DateTime dateTime = DateTime.parse(dateString);

    Duration difference = dateTime.difference(now);

    int differenceInDays = difference.inDays;
    int differenceInWeeks = difference.inDays ~/ 7;
    int differenceInMonths =
        (dateTime.year - now.year) * 12 + dateTime.month - now.month;
    int differenceInYears = difference.inDays ~/ 365;
    int differenceInSixMonths =
        (dateTime.year - now.year) * 12 + dateTime.month - now.month;
    differenceInSixMonths = differenceInSixMonths ~/ 6;

    if (subscriptionModel.subscriptionCycle == "Weekly") {
      if (differenceInDays >= 0 && differenceInDays <= 3) {
        totalNotification++;
        NotificationService().showNotification(
            title: 'Subscription Expire with in day $differenceInWeeks',
            body:
                'please ready For Subscription${subscriptionModel.subscriptionCycle}');
      }
    } else if (subscriptionModel.subscriptionCycle == "Monthly") {
      if (differenceInDays >= 0 && differenceInDays <= 3) {
        totalNotification++;
        NotificationService().showNotification(
            title: 'Subscription Expire with in day $differenceInMonths',
            body:
                'please ready For Subscription${subscriptionModel.subscriptionCycle}');
      }
    } else if (subscriptionModel.subscriptionCycle == "3 Months") {
      if (differenceInDays >= 0 && differenceInDays <= 3) {
        totalNotification++;
        NotificationService().showNotification(
            title: 'Subscription Expire with in day $differenceInDays',
            body:
                'please ready For Subscription${subscriptionModel.subscriptionCycle}');
      }
    } else if (subscriptionModel.subscriptionCycle == "6 Months") {
      if (differenceInDays >= 0 && differenceInDays <= 3) {
        totalNotification++;
        NotificationService().showNotification(
            title: 'Subscription Expire with in day $differenceInDays',
            body:
                'please ready For Subscription ${subscriptionModel.subscriptionCycle}');
      }
    } else if (subscriptionModel.subscriptionCycle == "Yearly") {
      if (differenceInDays >= 0 && differenceInDays <= 3) {
        totalNotification++;
        NotificationService().showNotification(
            title: 'Subscription Expire with in day $differenceInDays',
            body: 'please ready For Subscription${subscriptionModel.subscriptionCycle}');
      }

    }
    NotificationModel notificationModel = NotificationModel(
        subscriptionModel.subscriptionDay,
        subscriptionModel.subscriptionMonth,
        subscriptionModel.subscriptionName,
        differenceInDays);

    notifyModelList.add(notificationModel);
    update();
  }
  void isOneTime(){
    if(isOneTimeFetch.isFalse){
     fetchData();
    }
  }
}
