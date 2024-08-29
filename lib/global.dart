// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:liquid_swipe/liquid_swipe.dart';
// import 'package:qouteapp_database/Controller/homeController.dart';
// import 'package:qouteapp_database/Modal/Modal.dart';
// import 'package:qouteapp_database/view/category.dart';
// import 'package:qouteapp_database/view/setting.dart';
//
// class Homepage extends StatelessWidget {
//   Homepage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     HomeController controller = Get.put(HomeController());
//     return Scaffold(
//       body: FutureBuilder(
//         future: controller.loadData(),
//         builder: (context, snapshot) {
//           if(snapshot.hasError)
//           {
//             return Center(
//               child: Text(snapshot.error.toString()),
//             );
//           }
//           if(snapshot.hasData)
//           {
//
//             List<QuotesModel>? quoteList = [];
//             List<String>? imgList = [];
//
//             (quoteList,imgList) = snapshot.data!;
//
//             return  Obx(() {
//               return LiquidSwipe.builder(
//                 itemCount: quoteList!.length,
//                 itemBuilder: (context, index) {
//                   // final quote = snapshot.data![index];
//                   return Container(
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         image: DecorationImage(
//                           fit: BoxFit.cover,
//                           opacity: 4,
//                           image: AssetImage(imgList![index]),
//                         ),
//                       ),
//                       child: Padding(
//                           padding:
//                           const EdgeInsets.symmetric(horizontal: 16.0),
//                           child: Column(children: [
//                             Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       showModalBottomSheet(
//                                         isScrollControlled: true,
//                                         context: context,
//                                         builder: (context) {
//                                           return Container(
//                                             height: MediaQuery.of(context)
//                                                 .size
//                                                 .height -
//                                                 120,
//                                             width: double.infinity,
//                                             child: SingleChildScrollView(
//                                               child: Column(
//                                                 children: [
//                                                   Row(
//                                                     crossAxisAlignment:
//                                                     CrossAxisAlignment
//                                                         .start,
//                                                     children: [
//                                                       Padding(
//                                                         padding:
//                                                         const EdgeInsets
//                                                             .all(8.0),
//                                                         child: InkWell(
//                                                             onTap: () {
//                                                               Navigator.of(
//                                                                   context)
//                                                                   .push(
//                                                                   MaterialPageRoute(
//                                                                     builder:
//                                                                         (context) =>
//                                                                         Settingpage(),
//                                                                   ));
//                                                             },
//                                                             child: Icon(
//                                                               CupertinoIcons
//                                                                   .multiply,
//                                                               size: 40,
//                                                               color: Colors
//                                                                   .black,
//                                                             )),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       Text(
//                                                         '   Categories ',
//                                                         style: TextStyle(
//                                                             fontSize: 30,
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .bold),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Wrap(
//                                                     children: [
//                                                       ...List.generate(
//                                                         controller
//                                                             .category.length,
//                                                             (index) => Stack(
//                                                           children: [
//                                                             Container(
//                                                               height: 150,
//                                                               width: 180,
//                                                               margin:
//                                                               EdgeInsets
//                                                                   .all(
//                                                                   10),
//                                                               decoration:
//                                                               BoxDecoration(
//                                                                   color: Colors
//                                                                       .black12,
//                                                                   borderRadius:
//                                                                   BorderRadius.circular(
//                                                                       10),
//                                                                   image:
//                                                                   DecorationImage(
//                                                                     fit: BoxFit
//                                                                         .cover,
//                                                                     image:
//                                                                     AssetImage(controller.category[index]['image']),
//                                                                   )),
//                                                               child: Padding(
//                                                                   padding: EdgeInsets.only(
//                                                                       top:
//                                                                       120,
//                                                                       left:
//                                                                       20),
//                                                                   child: Text(
//                                                                     controller
//                                                                         .category[index]
//                                                                     [
//                                                                     'category'],
//                                                                     style: TextStyle(
//                                                                         color: Colors
//                                                                             .white,
//                                                                         fontSize:
//                                                                         20,
//                                                                         fontWeight:
//                                                                         FontWeight.bold),
//                                                                   )),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       );
//                                     },
//                                     child: Container(
//                                         alignment: Alignment.center,
//                                         margin: EdgeInsets.only(top: 40),
//                                         height: 40,
//                                         width: 100,
//                                         decoration: BoxDecoration(
//                                             color: Colors.white54,
//                                             borderRadius:
//                                             BorderRadius.circular(10)),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                           children: [
//                                             Icon(Icons.category),
//                                             InkWell(
//                                                 onTap: () {
//                                                   Navigator.of(context)
//                                                       .push(MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         CategoryPage(),
//                                                   ));
//                                                 },
//                                                 child: Text('category')),
//                                           ],
//                                         )),
//                                   ),
//                                 ),
//                                 Container(
//                                   alignment: Alignment.center,
//                                   margin: EdgeInsets.only(top: 40),
//                                   height: 40,
//                                   width: 100,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white54,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: InkWell(
//                                       onTap: () {
//                                         Navigator.of(context).push(
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     Settingpage()));
//                                       },
//                                       child: Icon(Icons.settings)),
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: 250,
//                             ),
//                             ListTile(
//                               title: Text(quoteList![index].quote,
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold)),
//                               subtitle: Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(quoteList[index].author,
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.white)),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                           ])));
//                 },
//               );
//             });
//           }
//
//           return Center(child: CircularProgressIndicator(),);
//         },
//       ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.only(top: 150),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Container(
//               alignment: Alignment.center,
//               height: 40,
//               width: 40,
//               decoration: BoxDecoration(
//                 color: Colors.white54,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(CupertinoIcons.down_arrow),
//             ),
//             Container(
//               alignment: Alignment.center,
//               height: 40,
//               width: 40,
//               decoration: BoxDecoration(
//                 color: Colors.white54,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(Icons.favorite_border),
//             ),
//             Container(
//               alignment: Alignment.center,
//               height: 40,
//               width: 40,
//               decoration: BoxDecoration(
//                 color: Colors.white54,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(Icons.share),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
//
//
// import '../Controller/homeController.dart';


// class CategoryPage extends StatelessWidget {
//   const CategoryPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     HomeController controller = Get.put(HomeController());
//     return Scaffold(
//       appBar: AppBar(
//         bottom: PreferredSize(
//             preferredSize: Size.fromHeight(30),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 onChanged: (value) {},
//                 decoration: InputDecoration(prefixIcon: Icon(CupertinoIcons.search),label: Text('search')),
//               ),
//             )),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 40,),
//             Row(
//               children: [
//                 Text(
//                   '   Categories ',
//                   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             Wrap(
//               children: [
//                 ...List.generate(
//                     controller.category.length,
//                         (index) => InkWell(
//                       onTap: () {
//                         if (controller.category[index]['category'] == 'General') {
//                           controller.quotes.value = controller.quoteList;
//                           controller.quotes.refresh();
//                           controller.initialImagesDeclare();
//                           controller.liquidController = LiquidController();
//                           Get.back();
//                           Future.delayed(const Duration(milliseconds: 500), () {
//                             Get.snackbar(
//                               'Quotes Category',
//                               'Showing general quotes',
//                               snackPosition: SnackPosition.BOTTOM,
//                               duration: const Duration(seconds: 3),
//                             );
//                           });
//                         } else {
//                           controller.quotes.value = controller.c
//                               .where(
//                                   (quote) => quote.category == controller.category[index]['category']).toList();
//                           controller.quotes.refresh();
//                           controller.liquidController = LiquidController();
//                           controller.initialImagesDeclare();
//                           Get.back();
//                           Future.delayed(const Duration(milliseconds: 500), () {
//                             Get.snackbar(
//                               'Quotes Category Changed',
//                               snackPosition: SnackPosition.BOTTOM,
//                               'Showing ${controller.category[index]['category']} quotes',
//                               duration: const Duration(seconds: 3),
//                             );
//                           });
//                         }
//
//                       },
//                       child: Stack(children: [
//                         Container(
//                           height: 110,
//                           width: 180,
//                           margin: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                               color: Colors.black12,
//                               borderRadius: BorderRadius.circular(10),
//                               image: DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: AssetImage(
//                                     controller.category[index]['image']),
//                               )),
//                           child: Padding(
//                               padding: EdgeInsets.only(top: 65, left: 20),
//                               child: Text(
//                                 controller.category[index]['category'],
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold),
//                               )),
//                         ),
//                       ]),
//                     ))
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

