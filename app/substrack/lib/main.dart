import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:substrack/bottom_navaigation/bottom_navigation_view.dart';
import 'package:substrack/firebase_options.dart';
import 'package:substrack/signup/signup_view.dart';
import 'package:substrack/splash/splash_view.dart';
import 'package:substrack/util/color.dart';


Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    runApp(const MyApp());
  } catch (e) {
    print(e);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: EasyLoading.init(),
        theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: ThemeColors.background),
            useMaterial3: true,
            backgroundColor: ThemeColors.background),
        debugShowCheckedModeBanner: false,
        home: Splash());
  }
}
