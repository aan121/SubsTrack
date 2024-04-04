import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:substrack/track/track_controller.dart';

import '../../add/subscription-model.dart';
import '../../util/color.dart';
import '../../util/fonts_styles.dart';
import '../../util/images.dart';

class TrackerList extends StatelessWidget {
  final SubscriptionModel value;
  final Function(SubscriptionModel) onChange;
  final Function() onTap;
  final TrackController controller;

  const TrackerList(
      {super.key,
      required this.value,
      required this.onTap,
      required this.onChange,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'en_US', symbol: '\$ ',decimalDigits: 0);
    double cost=double.parse( value.subscriptionCost.toString());
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(
                child: Column(
                  children: [
                    const Text(
                      "Are you sure you want to delete \n "
                      "          his subscription?  ",
                      style: FontStyles.roman_bold_black,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                                fontSize: 18, fontFamily: 'roman_bold'),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            print("ok");
                            controller.deleteData(value.subscriptionId);
                          },
                          child: const Text(
                            "Delete",
                            style: TextStyle(
                                fontSize: 18, fontFamily: 'roman_bold'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        width: double.infinity,
        height: 150,
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
              ])),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    value.subscriptionName.toLowerCase() == 'youtube' ? Images.Youtube
                        : value.subscriptionName.toLowerCase() == 'tiktok' ? Images.tiktok
                        : value.subscriptionName.toLowerCase() == 'netflix' ? Images.netflixLogo
                        : value.subscriptionName.toLowerCase() == 'amazon' ? Images.amazon
                        : value.subscriptionName.toLowerCase() == 'appletv' ? Images.appleTv
                        : value.subscriptionName.toLowerCase() == 'apple tv' ? Images.appleTv
                        : value.subscriptionName.toLowerCase() == 'camera filters' ? Images.cameraFilters
                        : value.subscriptionName.toLowerCase() == 'disney' ? Images.disneyLogo
                        : value.subscriptionName.toLowerCase() == 'hbo' ? Images.hboLogo
                        : value.subscriptionName.toLowerCase() == 'hulu' ? Images.huluLogo
                        : value.subscriptionName.toLowerCase() == 'disney' ? Images.disneyLogo
                        : value.subscriptionName.toLowerCase() == 'doordash' ? Images.doordash

                        : Images.exportICon,
                    height: 35,
                  ),
                  Column(
                    children: [
                      Text(
                        value.subscriptionName.toString(),
                        style: FontStyles.normalTextStyle1,
                      ),
                      Text(
                        "${value.subscriptionDay}/${value.subscriptionMonth}",
                        style: FontStyles.normalTextStyle1,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        value.subscriptionCategory.toString().length > 20
                            ? value.subscriptionCategory.toString().substring(0, 20) + '...'
                            : value.subscriptionCategory.toString(),
                        style: FontStyles.normalTextStyle1,

                      ),
                      Text(
                          currencyFormatter.format(cost),
                        style: FontStyles.normalTextStyle1,
                      ),
                      Text(
                        value.subscriptionCycle.toString(),
                        style: FontStyles.normalTextStyle1,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
