import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class BottomNavigationController extends GetxController {
  final currentIndex = 0.obs;
  RxBool selectedHome = false.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
  void selectHome(){
    selectedHome.value=true;
  }
}
