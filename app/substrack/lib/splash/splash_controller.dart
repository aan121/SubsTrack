import 'dart:async';
import 'package:get/get.dart';

import '../bottom_navaigation/bottom_navigation_view.dart';
import '../signIn/login_view.dart';


class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 3), () {
      Get.off(Login());
    });
  }
}
