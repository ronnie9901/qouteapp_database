import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../Controller/homeController.dart';
import 'homepage.dart';

class Settingpage extends StatelessWidget {
  const Settingpage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    ThemeController themeController = Get.put(ThemeController());

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(CupertinoIcons.back),
        ),
      ),
      body: Column(
        children: [
          ListTile(
              title: themeController.isDark
                  ? Text(' dark mode',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                  : Text(' light mode',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              trailing: Switch(
                inactiveThumbColor: Theme.of(context).colorScheme.primary,
                activeColor: Theme.of(context).colorScheme.primary,
                value: themeController.isDark,
                onChanged: (value) {
                  themeController.setTheme();
                },
              )),
          ListTile(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Container(
                    height: MediaQuery.of(context).size.height - 120,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => Settingpage(),
                                      ));
                                    },
                                    child: Icon(
                                      CupertinoIcons.multiply,
                                      size: 40,
                                      color: Colors.black,
                                    )),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '   Favorites ',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Wrap(
                            children: [
                              ...List.generate(
                                  controller.category.length,
                                  (index) => InkWell(
                                        onTap: () {

                                        },
                                        child: Stack(children: [
                                          Container(
                                            height: 150,
                                            width: 180,
                                            margin: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Colors.black12,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      controller.category[index]
                                                          ['image']),
                                                )),
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 120, left: 20),
                                                child: Text(
                                                  controller.category[index]
                                                      ['category'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ),
                                        ]),
                                      ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('favorites list',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                Icon(
                  Icons.favorite,
                  size: 30,
                ),
              ],
            ),

          ),
        ],
      ),
    );
  }
}

class ThemeController extends GetxController {
  SharedPreferences? sharedPreferences;
  bool isDark = false;

  void setTheme() {
    isDark = !isDark;
    setSharedPreferences(isDark);
  }

  Future<void> setSharedPreferences(bool value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setBool('theme', value);
  }

  ThemeProvider(bool theme) {
    isDark = theme;
  }
}
