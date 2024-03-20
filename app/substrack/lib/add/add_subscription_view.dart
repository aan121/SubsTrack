import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:substrack/add/add_subscription_controller.dart';
import '../notification/notification_view.dart';
import '../signIn/login_view.dart';
import '../util/color.dart';
import '../util/fonts_styles.dart';
import '../util/images.dart';

class AddSubscriptionView extends StatelessWidget {
  const AddSubscriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddSubscriptionController controller =
        Get.put(AddSubscriptionController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.all(8.0),
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
                  Get.to(NotificationView());
                },
                child: Image.asset(Images.notification),
              )
            ],
          ),
        ),
        backgroundColor: ThemeColors.background,
      ),
      body: Container(
        decoration: const BoxDecoration(color: ThemeColors.background),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Subscription",
                        style: FontStyles.meduimTitle_roman_bold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 60,
                        child: TextFormField(
                          controller:
                              controller.subscriptionNameController.value,
                          decoration: InputDecoration(
                            hintText: 'Subscription name',
                            filled: true,
                            hintStyle: FontStyles.textStyleMulishSmall,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Billing Date",
                        style: FontStyles.meduimTitle_roman_bold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Obx(
                            () => Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 8, 16),
                                child: Container(
                                  height: 50,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: DropdownButton<String>(
                                    value:
                                        controller.selectedDay.value.isNotEmpty
                                            ? controller.selectedDay.value
                                            : 'Day',
                                    // Set a default value here
                                    onChanged: (String? newValue) {
                                      if (newValue != null) {
                                        controller.updateSelectedDay(newValue);
                                      }
                                    },
                                    items: <String>[
                                      'Day',
                                      '1',
                                      '2',
                                      '3',
                                      '4',
                                      '5',
                                      '6',
                                      '7',
                                      '8',
                                      '9',
                                      '10',
                                      '11',
                                      '12',
                                      '13',
                                      '14',
                                      '15',
                                      '16',
                                      '17',
                                      '18',
                                      '19',
                                      '20',
                                      '21',
                                      '22',
                                      '23',
                                      '24',
                                      '25',
                                      '26',
                                      '27',
                                      '28',
                                      '29',
                                      '30',
                                      '31'
                                    ]
                                        .map<DropdownMenuItem<String>>(
                                          (String value) =>
                                              DropdownMenuItem<String>(
                                            value: value,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                value,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    underline: Container(),
                                    style: FontStyles.textStyleMulishSmall,
                                    alignment: Alignment.center,
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 16, 8, 8),
                                    icon: const Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      // Add padding to the left of the dropdown icon
                                      child: Icon(Icons.arrow_drop_down),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                  child: DropdownButton<String>(
                                    value: controller
                                            .selectedMonth.value.isNotEmpty
                                        ? controller.selectedMonth.value
                                        : 'Month',
                                    // Set a default value here
                                    onChanged: (String? newValue) {
                                      if (newValue != null) {
                                        controller
                                            .updateSelectedMonth(newValue);
                                      }
                                    },
                                    items: <String>[
                                      'Month',
                                      '1',
                                      '2',
                                      '3',
                                      '4',
                                      '5',
                                      '6',
                                      '7',
                                      '8',
                                      '9',
                                      '10',
                                      '11',
                                      '12'
                                    ]
                                        .map<DropdownMenuItem<String>>(
                                          (String value) =>
                                              DropdownMenuItem<String>(
                                            value: value,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                value,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    underline: Container(),
                                    style: FontStyles.textStyleMulishSmall,
                                    alignment: Alignment.center,
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 16, 8, 8),
                                    icon: const Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      // Add padding to the left of the dropdown icon
                                      child: Icon(Icons.arrow_drop_down),
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
                      const Text(
                        "Cost",
                        style: FontStyles.meduimTitle_roman_bold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 60,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: controller.costController.value,
                          decoration: InputDecoration(
                            hintText: 'Number',
                            filled: true,
                            hintStyle: FontStyles.textStyleMulishSmall,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Billing cycle",
                        style: FontStyles.meduimTitle_roman_bold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: DropdownButton<String>(
                              value: controller.selectedCycles.value.isNotEmpty
                                  ? controller.selectedCycles.value
                                  : 'Weekly',
                              // Set a default value here
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  controller.updateSelectedCycles(newValue);
                                }
                              },
                              items: <String>[
                                'Weekly',
                                'Monthly',
                                '3 Months',
                                '6 Months',
                                'Yearly'
                              ]
                                  .map<DropdownMenuItem<String>>(
                                    (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: const TextStyle(
                                              color: Colors.black)),
                                    ),
                                  )
                                  .toList(),
                              underline: Container(),
                              style: FontStyles.textStyleMulishSmall,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                              icon: const Padding(
                                padding: EdgeInsets.only(left: 30),
                                // Add padding to the left of the dropdown icon
                                child: Icon(Icons.arrow_drop_down),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Category",
                        style: FontStyles.meduimTitle_roman_bold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: DropdownButton<String>(
                              value:
                                  controller.selectedCategories.value.isNotEmpty
                                      ? controller.selectedCategories.value
                                      : 'Entertainment',
                              // Set a default value here
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  controller.updateSelectedCategories(newValue);
                                }
                              },
                              items: <String>[
                                 'Entertainment', 'Health and Fitness', 'News and Magazines', 'Food and Meal Services', 'Utilities', 'Transportation', 'Shopping and Retail', 'Productivity and Software', 'Education', 'Financial', 'Streaming Music', 'Streaming Video', 'Home and Lifestyle', 'Gaming', 'Travel and Hospitality', 'Personal Care', 'Other'
                              ]
                                  .map<DropdownMenuItem<String>>(
                                    (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: const TextStyle(
                                              color: Colors.black)),
                                    ),
                                  )
                                  .toList(),
                              underline: Container(),
                              style: FontStyles.textStyleMulishSmall,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                              icon: const Padding(
                                padding: EdgeInsets.only(left: 30),
                                // Add padding to the left of the dropdown icon
                                child: Icon(Icons.arrow_drop_down),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ThemeColors.tabColor,
                      ),
                      child: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Text(
                            'Cancel',
                            style: FontStyles.smallTitle,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ThemeColors.tabColor,
                      ),
                      child: TextButton(
                        onPressed: () {
                          controller.addSubscriptionUser();
                        },
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Text(
                            'Confirm',
                            style: FontStyles.smallTitle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
