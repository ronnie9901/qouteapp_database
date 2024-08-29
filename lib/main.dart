import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qouteapp_database/view/category.dart';
import 'package:qouteapp_database/view/homepage.dart';

void main() {
  runApp(const MyApp());
}

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
      // themeMode: Provider.of <homeproviderr>(context).isdark?ThemeMode.dark:ThemeMode.light,
     home: Homepage(),
    );
  }
}

