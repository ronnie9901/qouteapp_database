import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../view/category.dart';

void favBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 5,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 5.0, right: 5, top: 5, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {
                    Get.back();
                  }, icon: Icon(Icons.close)),
                  Text('Favorite',
                    style: TextStyle(
                        fontFamily: 'f1',
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: Colors.white),),
                  IconButton(onPressed: () {
                    Get.back();
                  }, icon: Icon(Icons.done)),
                ],
              ),
            ),
            controller.likedQuotes1.isEmpty?Lottie.network(
                'https://lottie.host/f1168197-847e-441b-823f-d2551f20500e/Zkd3fXAqQd.json',width: 300,height: 300):Expanded(
              child: GridView.builder(
                // controller: scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4 / 4,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: controller.likedQuotes1.length,
                itemBuilder: (context, index) {
                  String category = controller.likedQuotes1[index]
                      .split('-')
                      .sublist(0, 1)
                      .join(' ');
                  String img = controller.likedQuotes1[index].split('-')
                      .sublist(1, 2)
                      .join(' ');
                  return GestureDetector(
                    onLongPress: () {
                      controller.likedQuotesRemove(index);
                      Get.back();
                    },
                    onTap: () async {
                      await controller.readCategoryRecord(category);
                      _favCategoryBottomSheet(context);

                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        // color: Colors.blue,
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: AssetImage(img), fit: BoxFit.cover)
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        alignment: Alignment.center,
                        child: Text(category,
                          style: TextStyle(
                              fontFamily: 'f1',
                              letterSpacing: 1,
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: Colors.white),),
                      ),
                    ),
                  );
                },
                padding: EdgeInsets.all(10),
                physics: BouncingScrollPhysics(),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void _favCategoryBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,showDragHandle: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 5,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 5.0, right: 5, top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {
                    Get.back();
                  }, icon: Icon(Icons.close)),
                  Text(controller.saveCategoryName.toString(),
                    style: TextStyle(
                        fontFamily: 'f1',
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: Colors.white),),
                  IconButton(onPressed: () {
                    Get.back();
                  }, icon: Icon(Icons.done)),
                ],
              ),
            ),
            controller.data.isEmpty?Lottie.network(
                'https://lottie.host/f1168197-847e-441b-823f-d2551f20500e/Zkd3fXAqQd.json',width: 300,height: 300):Expanded(
              child: GridView.builder(
                // controller: scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 9 / 16,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: controller.data.length,
                itemBuilder: (context, index) {
                  if (index >= controller.data.length) {
                    return Container();
                  }
                  return GestureDetector(
                    onLongPress: () {
                      controller.removeRecord(controller.data[index]['id']);
                      Get.back();
                    },
                    onTap: () {
                      controller.selectQuote(index);

                    },
                    child: Obx(
                          () => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage(controller.data[index]['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.format_quote_outlined, color: Colors.white),
                              Text(
                                controller.data[index]['quote'],
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '- ${controller.data[index]['author']} -',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 5,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                padding: EdgeInsets.all(10),
                physics: BouncingScrollPhysics(),
              ),
            ),
          ],
        ),
      );
    },
  );
}