 import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:qouteapp_database/helper/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Modal/Modal.dart';
import '../database/sql.dart';

class HomeController extends GetxController {


  RxList<QuotesModel> mainQuotes = <QuotesModel>[].obs,likedQuotes = <QuotesModel>[].obs;
  RxList<QuotesModel> allQuotes = <QuotesModel>[].obs;
  RxList<QuotesModel> quotes = <QuotesModel>[].obs;
  RxList<String> preImages = <String>[].obs;
  RxList<QuotesModel> favouriteQuotes = <QuotesModel>[].obs;
  RxList<String> favouriteCategories = <String>[].obs;
  RxInt indexForGlobalUse = 0.obs;
  int check = 0;
  var saveCategoryName = ''.obs;
  RxList data = [].obs;
  var selectQuotes=0.obs;


///////////////////////////////////
  var likedQuotes1 = <String>[].obs;

  Future<void> likeSave(String category,String img) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String quoteString = "$category-$img";

    if (!likedQuotes1.contains(quoteString))
    {
      likedQuotes1.add(quoteString);
      await prefs.setStringList('items', likedQuotes1);
    }
    else
    {

    }
  }


  LiquidController liquidController = LiquidController();

  @override
  void onInit() {
    super.onInit();
    loadData();
    likeGet();
    initDb();
    randomImages();
  }

  Future<RxList<QuotesModel>> loadData() async {

    List json = await ApiHelper.apiServices.fatchData();

    mainQuotes.value = json.map((e) => QuotesModel.fromJson(e)).toList();
    mainQuotes.shuffle();
    quotes.value= mainQuotes;
    randomImages();
    return quotes;

  }

  List category = [
    {
      "category": "Deep",
      "image": 'assets/img/IMG_20240830_223040_011.webp',
    },
    {
      "category": "Love",
      "image": 'assets/img/IMG_20240830_223040_011.webp',
    },

    {
      "category": "Motivation",
      "image": 'assets/img/IMG_20240830_223115_952.webp',
    },

    {
      "category": "Powerful",
      "image": 'assets/affirmatiom/image4.jpeg',
    },
    {
      "category": "Discipline",
      "image": 'assets/img/IMG_20240830_223143_667.webp',
    },


    {
      "category": "Ego",
      "image": 'assets/affirmatiom/img1.jpg',
    },

    {
      "category": "Hope",
      "image": 'assets/img/IMG_20240830_223040_011.webp',
    },
    {
      "category": "Sad",
      "image": 'assets/img/IMG_20240830_223115_952.webp',
    },

  ];
  Map categoryImages = {
    'Motivation': [
      'assets/affirmatiom/img1.jpg',
      'assets/img/IMG_20240830_223040_011.webp',
      'assets/img/IMG_20240830_223115_952.webp',
    '  assets/affirmatiom/image4.jpeg',


    ],
    'Love': [
      'assets/img/IMG_20240830_223040_011.webp',
      'assets/img/IMG_20240830_223115_952.webp',
      'assets/img/IMG_20240830_223143_667.webp',
      'assets/img/IMG_20240830_223436_210.webp',
    ],
    'Deep': [
      'assets/img/IMG_20240830_223040_011.webp',
      'assets/img/IMG_20240830_223115_952.webp',
      'assets/img/IMG_20240830_223143_667.webp',
      'assets/img/IMG_20240830_223436_210.webp',
    ],

    'Ego': [
      'assets/affirmatiom/img1.jpg',
      'assets/affirmatiom/img1.jpg',
      'assets/img/IMG_20240830_223226_453.webp',
      'assets/img/IMG_20240830_223337_120.webp',
    ],
    'Sad': [
      'assets/affirmatiom/img1.jpg',
      'assets/img/IMG_20240830_223143_667.webp',
      'assets/img/IMG_20240830_223436_210.webp',
     ' assets/affirmatiom/img1.jpg',
    ],
    'Powerful': [
      'assets/img/IMG_20240830_223040_011.webp',
      'assets/img/IMG_20240830_223115_952.webp',
      'assets/img/IMG_20240830_223226_453.webp',
      'assets/img/IMG_20240830_223337_120.webp',
    ],
    'Discipline': [
      'assets/img/IMG_20240830_223040_011.webp',
      'assets/img/IMG_20240830_223115_952.webp',
      'assets/img/IMG_20240830_223226_453.webp',
      'assets/img/IMG_20240830_223337_120.webp',
    ],
    'Hope': [
      'assets/img/IMG_20240830_223226_453.webp',
      'assets/img/IMG_20240830_223337_120.webp',
      'assets/img/IMG_20240830_223040_011.webp',
      'assets/img/IMG_20240830_223115_952.webp',
    ]
  };
  List qoutList=[
    'assets/img/IMG_20240830_223040_011.webp',
    'assets/img/IMG_20240830_223115_952.webp',
    'assets/img/IMG_20240830_223143_667.webp',
    'assets/img/IMG_20240830_223436_210.webp',
    'assets/affirmatiom/img1.jpg',
    'assets/affirmatiom/img1.jpg',
    'assets/img/IMG_20240830_223226_453.webp',
    'assets/img/IMG_20240830_223337_120.webp',
    'assets/affirmatiom/image3.jpeg',
    'assets/affirmatiom/image4.jpeg',
    'assets/affirmatiom/image5.jpeg',
    'assets/img/IMG_20240830_223115_952.webp',
    'assets/img/IMG_20240830_223143_667.webp',
    'assets/img/IMG_20240830_223436_210.webp',
    'assets/affirmatiom/img1.jpg',
    'assets/affirmatiom/img1.jpg',
    'assets/img/IMG_20240830_223226_453.webp',
    'assets/img/IMG_20240830_223337_120.webp',
    'assets/affirmatiom/image3.jpeg',
    'assets/affirmatiom/image4.jpeg',
    'assets/affirmatiom/image5.jpeg',
  ];

  randomImages() async {
    final random = Random();

    preImages.value = List.generate(quotes.length, (index) {
      final category = quotes[index].category;
      print("Processing quote at index $index with category: $category");

      final images = categoryImages[category];
      if (images == null || images.isEmpty) {
        print("No images found for category: $category");
        return '';
      }

      final selectedImage = images[random.nextInt(images.length)];
      print("Selected image for category $category: $selectedImage");
      return selectedImage;
    });

    print("Generated preImages:");
    print(preImages);
  }




  Future<void> likedQuotesRemove(int index) async {
    likedQuotes1.removeAt(index);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('items', likedQuotes1);
  }

  Future<void> likeGet() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    likedQuotes1.value = prefs.getStringList('items') ?? [];
  }
  Future<void> readCategoryRecord(String category)
  async {
    saveCategoryName.value=category;
    data.value = await DbHelper.dbHelper.readCategoryData(category);
  }
  Future getRecords()
  async {
    data.value =  await DbHelper.dbHelper.readData();
    return data;
  }
  void selectQuote(var value)
  {
    selectQuotes.value=value;
  }
  Future removeRecord(int id)
  async {
    await DbHelper.dbHelper.deleteData(id);
    await getRecords();
  }
  Future initDb()
  async {
    await DbHelper.dbHelper.database;
    await getRecords();
  }



  Future insertRecord(String quote,String author,String category,String image)
  async {
    await DbHelper.dbHelper.insertData(quote,author,category,image);
    await getRecords();
  }






}




