import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:substrack/add/subscription-model.dart';

import '../../util/color.dart';
import '../../util/fonts_styles.dart';
import '../../util/images.dart';
import '../User.dart';

class SubscriptionList extends StatelessWidget {
  final SubscriptionModel value;
  final Function(SubscriptionModel) onChange;
  final Function() onTap;

  const SubscriptionList(
      {super.key,
      required this.value,
      required this.onTap,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'en_US', symbol: '\$ ',decimalDigits: 0);
    double cost = double.parse(value.subscriptionCost);
    return Container(
      width: 110,
      height: 150,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, ThemeColors.background],
        ),
        borderRadius: BorderRadius.circular(15),
        border:GradientBoxBorder(
            width: 1,
            gradient: LinearGradient(colors: [
              ThemeColors.tabColor, Colors.indigo,
            ])),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
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
                : value.subscriptionName.toLowerCase() == 'hulu' ? Images.huluLogo


                : Images.exportICon,
            height: 20,
          ),

          const SizedBox(
            height: 10,
          ),
          Text(
            value.subscriptionName.toString(),
            style: FontStyles.normalTextStyle,
          ),
          Text(
            "${value.subscriptionDay}/${value.subscriptionMonth}",
            style: FontStyles.normalTextStyle,
          ),
          Text(
            currencyFormatter.format(cost),
            style: FontStyles.normalTextStyle,
          ),
          Text(
            value.subscriptionCycle.toString(),
            style: FontStyles.normalTextStyleSmall,
          ),
        ],
      ),
    );
  }
}
