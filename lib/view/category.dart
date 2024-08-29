import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import '../Controller/homeController.dart';
class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(30),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  controller.search(value);
                },
                decoration: InputDecoration(prefixIcon: Icon(CupertinoIcons.search),label: Text('search')),
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Row(
              children: [
                Text(
                  '   Categories ',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Wrap(
              children: [
                ...List.generate(
                    controller.category.length,
                    (index) => InkWell(
                          onTap: () {
                            if (controller.category[index]['category'] == 'General') {
                              controller.quotes.value = controller.mainQuotes;
                              controller.quotes.refresh();
                              controller.preImages();
                              controller.liquidController = LiquidController();
                              Get.back();
                              // Future.delayed(const Duration(milliseconds: 500), () {
                              //   Get.snackbar(
                              //     'Quotes Category',
                              //     'Showing general quotes',
                              //     snackPosition: SnackPosition.BOTTOM,
                              //     duration: const Duration(seconds: 3),
                              //   );
                              // });
                            } else {
                              controller.quotes.value = controller.mainQuotes
                                  .where(
                                      (quote) => quote.category == controller.category[index]['category']).toList();
                              controller.quotes.refresh();
                              controller.liquidController = LiquidController();
                              controller.preImages();
                              Get.back();
                              // Future.delayed(const Duration(milliseconds: 500), () {
                              //   Get.snackbar(
                              //     'Quotes Category Changed',
                              //     snackPosition: SnackPosition.BOTTOM,
                              //     'Showing ${controller.category[index]['category']} quotes',
                              //     duration: const Duration(seconds: 3),
                              //   );
                              // });
                            }
                          },
                          child: Stack(children: [
                            Container(
                              height: 110,
                              width: 180,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        controller.category[index]['image']),
                                  )),
                              child: Padding(
                                  padding: EdgeInsets.only(top: 65, left: 20),
                                  child: Text(
                                    controller.category[index]['category'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
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
  }
}
