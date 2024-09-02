import 'dart:developer';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:qouteapp_database/view/setting.dart';
import '../Controller/homeController.dart';
import '../Utils/globle.dart';
import 'category.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: controller.loadData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasData) {
              final data = snapshot.data!;

              if (controller.quotes.isEmpty) {
                return Center(
                  child: Text(
                    'No quotes available',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                );
              }

              return Obx(() {
                return LiquidSwipe.builder(
                  itemCount: controller.quotes.length,
                  itemBuilder: (context, index) {
                    final quote = controller.quotes[index];
                    // index = index % controller.quotes.length;
                    // var image = controller.preImages.isNotEmpty &&
                    //         index < controller.preImages.length
                    //     ? controller.preImages[index]
                    //     : 'assets/img/love1.jpg';
                    log(controller.preImages[index]);
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          opacity: 4,
                          image: AssetImage(controller.qoutList[index]),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 40),
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white54,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.category),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                CategoryPage(),
                                          ));
                                        },
                                        child: Text(
                                          'Category',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: 40),
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white54,
                                  shape: BoxShape.circle,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Settingpage(),
                                      ),
                                    );
                                  },
                                  child: Icon(Icons.settings),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 200),
                          ListTile(
                            title: Text(
                              controller.quotes[index].quote,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    ' - ${controller.quotes[index].author}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 300),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white54,
                                      shape: BoxShape.circle,
                                    ),
                                    child: GestureDetector(onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,showDragHandle: true,
                                        backgroundColor: Colors.white,
                                        builder: (BuildContext context) {
                                          return Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(' Background color  ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Row(
                                                  children: [

                                                    ...List.generate(colorlist.length, (index) => InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          c1= colorlist[index];
                                                        });
                                                        Navigator.of(context).pushNamed('/home');
                                                      }, child: Container(
                                                        margin: EdgeInsets.all(5),
                                                        height: 150,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                          color: colorlist[index],
                                                        )
                                                    ),
                                                    )),

                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(' Affirmation ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Row(
                                                  children: [

                                                    ...List.generate(5, (index) => InkWell(
                                                      onTap: () {

                                                        setState(() {
                                                          imgbg = imagelist[index];
                                                        });

                                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Homepage(),));

                                                      }, child: Container(
                                                        margin: EdgeInsets.all(5),
                                                        height: 150,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            color: Colors.black12,
                                                            image: DecorationImage(
                                                                fit: BoxFit.cover,
                                                                image: AssetImage(
                                                                    imagelist[index]
                                                                )
                                                            )
                                                        )
                                                    ),
                                                    )),

                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(' most favorites',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Row(
                                                  children: [

                                                    ...List.generate(imagelist2.length, (index) => InkWell(
                                                      onTap: () {

                                                        setState(() {
                                                          imgbg =imagelist2[index];
                                                        });
                                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Homepage(),));

                                                      }, child: Container(
                                                        margin: EdgeInsets.all(5),
                                                        height: 150,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            color: Colors.black12,
                                                            image: DecorationImage(
                                                                fit: BoxFit.cover,
                                                                image: AssetImage(
                                                                    imagelist2[index]
                                                                )
                                                            )
                                                        )
                                                    ),
                                                    )),

                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(' all type photos  ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Row(
                                                  children: [

                                                    ...List.generate(imagelis3.length, (index) => InkWell(
                                                      onTap: () {

                                                        setState(() {
                                                          imgbg = imagelis3[index];
                                                        });

                                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Homepage(),));

                                                      }, child: Container(
                                                        margin: EdgeInsets.all(5),
                                                        height: 150,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            color: Colors.black12,
                                                            image: DecorationImage(
                                                                fit: BoxFit.cover,
                                                                image: AssetImage(
                                                                    imagelis3[index]
                                                                )
                                                            )
                                                        )
                                                    ),
                                                    )),

                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },child: Icon(CupertinoIcons.down_arrow)),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => const Settingpage(),
                                          transition: Transition.rightToLeftWithFade);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white54,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: IconButton(
                                          onPressed: () {
                                            // controller.toggleIsFavourite(index);
                                            if (controller.quotes[index].category ==
                                                'Deep') {
                                              controller.likeSave(
                                                  controller.quotes[index].category,
                                                  'assets/img/IMG_20240830_223040_011.webp');
                                            }
                                            if (controller.quotes[index].category ==
                                                'Discipline') {
                                              controller.likeSave(
                                                  controller.quotes[index].category,
                                                  'assets/img/IMG_20240830_223040_011.webp');
                                            }
                                            if (controller.quotes[index].category ==
                                                'Love') {
                                              controller.likeSave(
                                                  controller.quotes[index].category,
                                                  'assets/img/IMG_20240830_223040_011.webp');
                                            }
                                            if (controller.quotes[index].category ==
                                                'Ego') {
                                              controller.likeSave(
                                                  controller.quotes[index].category,
                                                  'assets/img/IMG_20240830_223040_011.webp');
                                            }
                                            if (controller.quotes[index].category ==
                                                'Motivation') {
                                              controller.likeSave(
                                                  controller.quotes[index].category,
                                                  'assets/img/IMG_20240830_223040_011.webp');
                                            }
                                            if (controller.quotes[index].category ==
                                                'Hope') {
                                              controller.likeSave(
                                                  controller.quotes[index].category,
                                                  'assets/img/IMG_20240830_223040_011.webp');
                                            }
                                            if (controller.quotes[index].category ==
                                                'Powerful') {
                                              controller.likeSave(
                                                  controller.quotes[index].category,
                                                  'assets/img/IMG_20240830_223040_011.webp');
                                            }
                                            if (controller.quotes[index].category ==
                                                'Sad') {
                                              controller.likeSave(
                                                  controller.quotes[index].category,
                                                  'assets/img/IMG_20240830_223040_011.webp');
                                            }
                                            print(controller.likedQuotes1);
                                            controller.insertRecord(
                                                controller.quotes[index].quote,
                                                controller.quotes[index].author,
                                                controller.quotes[index].category,
                                                'assets/img/IMG_20240830_223040_011.webp');
                                            favBottomSheet(context);
                                          },
                                          icon: (controller
                                              .quotes[
                                          controller.indexForGlobalUse.value]
                                              .fav)
                                              ? Icon(
                                            Icons.favorite_outlined,
                                            color: Colors.red,
                                          )
                                              : Icon(
                                            Icons.favorite_outline,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white54,
                                      shape: BoxShape.circle,
                                    ),
                                    child: InkWell(
                                        onTap: () {
                                          FlutterClipboard.copy(
                                              controller.quotes[index].quote);
                                          Get.snackbar(
                                              'Copied!', 'Quote copied to clipboard',
                                              snackPosition: SnackPosition.BOTTOM,
                                              colorText: CupertinoColors.white);
                                        },
                                        child: Icon(Icons.content_copy)),
                                  ),
                                ]),
                          ),
                        ]),
                      ),
                    );
                  },
                );
              });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        )

    );
  }
}
int selectindex = 0;
String imgbg = 'assets/affirmatiom/image6.jpeg';
