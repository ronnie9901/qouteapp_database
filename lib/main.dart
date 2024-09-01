import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qouteapp_database/view/homepage.dart';
import 'package:qouteapp_database/view/setting.dart';
import 'package:qouteapp_database/view/splacescreen.dart';


void main() {
  runApp(const MyApp());
}
ThemeController themeController = Get.put(ThemeController());
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
        colorScheme: ColorScheme.light(
          primary: Colors.amber,
          onPrimary: Colors.pink,
          secondary: Colors.blue,
          onSecondary: Colors.green,
        )
      ),
      darkTheme:  ThemeData(
        brightness: Brightness.dark,
          colorScheme: ColorScheme.dark(
            primary: Colors.purple,
            onPrimary: Colors.blue,
            secondary: Colors.green,
            onSecondary: Colors.redAccent,

          )
      ),
      themeMode : themeController.isDark? ThemeMode.dark: ThemeMode.light,
     home: SplashScreen(),
    );
  }
}

