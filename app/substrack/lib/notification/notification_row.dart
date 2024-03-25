import 'package:flutter/material.dart';
import 'package:substrack/notification/notification_model.dart';

import '../util/color.dart';
import '../util/fonts_styles.dart';

class NotificationRow extends StatelessWidget {

  final NotificationModel value;
  final Function(NotificationModel) onChange;
  final Function() onTap;
  const NotificationRow( {required this.value, required this.onChange, required this.onTap,super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, ThemeColors.background],
          ),
          border: Border.all(color: ThemeColors.tabColor,width: 0.5),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(
                  "your ${value.notifyMessage} Subscription is due in",
                  style: FontStyles.smallTitle,
                ),
              ),
               Text(
                " ${value.expireDay}",
                style: FontStyles.smallTitle,
              ),
            ],
          ),
        ),
      ),
    );
  }


}
