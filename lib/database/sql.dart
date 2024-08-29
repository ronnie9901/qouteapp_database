import 'package:path/path.dart';
import 'package:qouteapp_database/Modal/Modal.dart';
import 'package:sqflite/sqflite.dart';


class Datahelper {
  Database? _datebase;

  static Datahelper dbHelper = Datahelper._();


  Datahelper._();

  Future<Database?> get database async => _datebase ?? await initDatabase();

  Future initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'QoutesData.db');

    _datebase = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        String sql = '''CREATE TABLE QoutesData (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            quote TEXT,
            author TEXT,
            category TEXT,
      
       );
        ''';
        await db.execute(sql);
      },
    );
    return _datebase;
  }

  Future<void> insertData(QuotesModel qoute) async {
    Database? db = await database;
    await db!.insert(
      'QoutesData',
      qoute.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<List<Map<String, Object?>>> selectcategoty(String category) async {

    Database? db =  await database ;

    String sql =" SELECT * FROM  budget  WHERE category LIKE '%$category%' ";
    return await db!.rawQuery(sql,);


  }



}






