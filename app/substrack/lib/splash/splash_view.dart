import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:substrack/track/track_controller.dart';
import 'package:substrack/util/extra.dart';
import 'package:substrack/util/fonts_styles.dart';
import '../notification/notification_controller.dart';
import '../util/color.dart';
import 'splash_controller.dart'; // Import the splash controller

class Splash extends StatelessWidget {
  final SplashController splashController = Get.put(SplashController());

  Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context)
            .size
            .height, // Set height to full screen height
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ThemeColors.background, ThemeColors.tabColor],
          ),
        ),
        child: const Center(
          child:
              Text('S',style: FontStyles.Splash_Text,),
        ),
      ),
    );
  }
}
