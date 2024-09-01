import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {

  static DbHelper dbHelper = DbHelper._();
  DbHelper._();

  Database? _db;
  Future get database async => _db ?? await initDatabase();


  Future initDatabase() async {

    final path = await getDatabasesPath();
    final dbPath = join(path, 'quotes.db');

    _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        String sql = '''CREATE TABLE quotes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        quote TEXT,
        author TEXT,
        image TEXT,
        category TEXT);
        ''';
        await db.execute(sql);
      },
    );
    return _db;
  }

  Future insertData(String quote,String author,String category,String image)
  async {
    Database? db = await database;
    String sql = '''INSERT INTO quotes (quote,author,category,image)
    VALUES (?,?,?,?);
    ''';
    List args = [quote,author,category,image];
    await db!.rawInsert(sql,args);
  }

  Future<List<Map>> readData()
  async {
    Database? db = await database;
    String sql = '''SELECT * FROM quotes''';
    return await db!.rawQuery(sql);
  }

  Future<List<Map<String, Object?>>> readCategoryData(String category)
  async {
    Database? db = await database;
    String sql ='''
    SELECT * FROM quotes WHERE category = ?
    ''';
    List args = [category];
    return await db!.rawQuery(sql,args);
  }

  Future deleteData(int id)
  async {
    Database? db = await database;
    String sql = '''DELETE FROM quotes WHERE id = ?''';
    List args = [id];
    await db!.rawDelete(sql,args);
  }

}



// import 'package:path/path.dart';
// import 'package:qouteapp_database/Modal/Modal.dart';
// import 'package:sqflite/sqflite.dart';
//
// class Datahelper {
//   Database? _datebase;
//
//   static final Datahelper dbHelper = Datahelper._();
//   static Database? _database;
//
//   Datahelper._();
//
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await initDatabase();
//     return _database!;
//   }
//
//   Future<Database> initDatabase() async {
//     String path = join(await getDatabasesPath(), 'quotes_database.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute(
//           'CREATE TABLE QoutesData ('
//               'id INTEGER PRIMARY KEY AUTOINCREMENT, '
//               'quote TEXT, '
//               'author TEXT, '
//               'category TEXT, '
//               'is_favorite INTEGER DEFAULT 0'
//               ')',
//         );
//       },
//     );
//   }
//
//
//   Future<List<Map<String, Object?>>> selectcategoty(String category) async {
//     Database? db = await database;
//
//     String sql =
//         " SELECT * FROM  budget  WHERE  LIKE QoutesData '%$category%' ";
//     return await db!.rawQuery(
//       sql,
//     );
//   }
//
//   Future<void> insertLikedQuote(QuotesModel quote) async {
//     final db = await database;
//     await db!.insert(
//       'QoutesData',
//       quote.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//
//   Future<void> deleteLikedQuotes(int id) async {
//     final db = await database;
//     await db?.delete('QoutesData', where: 'id = ?', whereArgs: [id]);
//   }
//
//   Future<int?> getQuoteId(QuotesModel quote) async {
//     final db = await database;
//
//     final maps = await db!.query(
//       'Quotes',
//       where: 'quote = ? AND author = ?',
//       whereArgs: [quote.quote, quote.author],
//     );
//
//     if (maps.isNotEmpty) {
//       return maps.first['id'] as int;
//     }
//     return null;
//   }
//
//   Future<List<String>> getFavoriteCategories() async {
//     final db = await database;
//
//     final maps = await db!.rawQuery('''
//     SELECT DISTINCT category
//     FROM Quotes
//     WHERE is_favorite = 1
//   ''');
//
//     return maps.map((map) => map['category'] as String).toList();
//   }
//
//   Future<bool> doesQuoteExist(QuotesModel quote) async {
//     final db = await database;
//
//     final maps = await db!.query(
//       'Quotes',
//       where: 'quote = ? AND author = ?',
//       whereArgs: [quote.quote, quote.author],
//     );
//
//     return maps.isNotEmpty;
//   }
// }
