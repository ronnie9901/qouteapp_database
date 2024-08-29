 import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';

import 'package:qouteapp_database/database/sql.dart';
import 'package:qouteapp_database/helper/api.dart';

import '../Modal/Modal.dart';

class HomeController extends GetxController {


  RxList<QuotesModel> mainQuotes = <QuotesModel>[].obs;
  RxList<QuotesModel> allQuotes = <QuotesModel>[].obs;
  RxList<QuotesModel> quotes = <QuotesModel>[].obs;
  RxList<String> preImages = <String>[].obs;

  LiquidController liquidController = LiquidController();

  @override
  void onInit() {
    super.onInit();
    loadData();

  }

  Future<RxList<QuotesModel>> loadData() async {

    List json = await ApiHelper.apiServices.fatchData();

    mainQuotes.value = json.map((e) => QuotesModel.fromJson(e)).toList();
    mainQuotes.shuffle();
    quotes.value= mainQuotes;
    randomImages();
    return quotes;

  }

  void filteredQuotes(){

  }


  List category = [
    {
      "category": "Affirmation",
      "image": 'assets/affirmatiom/image4.jpeg',
    },
    {
      "category": "Deep",
      "image": 'assets/catimg/myqoute.jpeg',
    },
    {
      "category": "Love",
      "image": 'assets/catimg/mymood.jpeg',
    },
    {
      "category": "Positive",
      "image": 'assets/catimg/mymood.jpeg',
    },
    {
      "category": "Motivation",
      "image": 'assets/catimg/mymood.jpeg',
    },
    {
      "category": "Mental Health",
      "image": 'assets/catimg/mymood.jpeg',
    },
    {
      "category": "Powerful",
      "image": 'assets/catimg/mymood.jpeg',
    },
    {
      "category": "Discipline",
      "image": 'assets/catimg/mymood.jpeg',
    },
    {
      "category": "Broken",
      "image": 'assets/catimg/mymood.jpeg',
    },
    {
      "category": "Patience",
      "image": 'assets/catimg/mymood.jpeg',
    },
    {
      "category": "Ego",
      "image": 'assets/catimg/mymood.jpeg',
    },
    {
      "category": "Gratitude",
      "image": 'assets/catimg/mymood.jpeg',
    },
    {
      "category": "Hope",
      "image": 'assets/catimg/mymood.jpeg',
    },
    {
      "category": "Sad",
      "image": 'assets/catimg/mymood.jpeg',
    },

  ];
  Map categoryImages = {
    'Life': [
      'assets/catimg/3.jpeg',
      'assets/catimg/10.jpeg',
      'assets/catimg/14.jpg',
      'assets/catimg/17.jpeg',
    ],
    'Love': [
      'assets/catimg/love.jpeg',
      'assets/catimg/3.jpeg',
      'assets/catimg/general.jpeg',
      'assets/catimg/3.jpeg',
    ],
    'Success': [
      'assets/catimg/success.jpeg',
      'assets/catimg/3.jpeg',
      'assets/catimg/3.jpeg',
      'assets/catimg/3.jpeg',
    ],
    'Motivation': [
      'assets/catimg/discipline.jpeg',
      'assets/catimg/image1.jpeg',
      'assets/catimg/image22.jpeg',
      'assets/catimg/3.jpeg',
    ],
    'Happiness': [
      'assets/catimg/mycol.jpeg',
      'assets/catimg/grat.jpeg',
      'assets/catimg/self.jpeg',
      'assets/catimg/3.jpeg',
    ],
    'Powerful': [
      'assets/catimg/ego.jpeg',
      'assets/catimg/fd.jpeg',
      'assets/catimg/3.jpeg',
      'assets/catimg/3.jpeg',
    ],
    'Friendship': [
      'assets/affirmatiom/img1.jpg',
      'assets/affirmatiom/image4.jpeg',
      'assets/affirmatiom/image5.jpeg',
      'assets/affirmatiom/image6.jpeg',
    ],
    'Humor': [
      'aassets/catimg/mymood.jpeg',
      'assets/catimg/loyalty.jpeg',
      'assets/catimg/mycol.jpeg',
      'assets/catimg/3.jpeg',
    ]
  };


  randomImages() async {
    final random = Random();

    preImages.value = List.generate(quotes.length, (index) {
      final category = quotes[index].category;
      final images = categoryImages[category];
      if (images == null || images.isEmpty) return '';
      return images[random.nextInt(images.length)];});
    print(
        "--------------------------------------------------------------------------------------------------\n\n");
    print(preImages);
    print(
        "--------------------------------------------------------------------------------------------------\n\n");
  }
  Future<void>  search( String value) async {

    mainQuotes.value = (await Datahelper.dbHelper.selectcategoty(value)).cast<QuotesModel>();

  }


}



