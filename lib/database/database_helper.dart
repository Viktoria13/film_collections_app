
import 'dart:io';
import 'package:film_collections_app/database/constant.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "movie_db.db";
  static final _databaseVersion = 2;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE ${Constant.table} (
            ${Constant.columnId} INTEGER PRIMARY KEY,
            ${Constant.columnTitle} TEXT NOT NULL,
            ${Constant.columnYear} INTEGER,
            ${Constant.columnRating} NUMERIC,
            ${Constant.columnOverview} TEXT,
            ${Constant.columnPosterPath} TEXT,
            ${Constant.columnWatchList} INTEGER,
            ${Constant.columnSeen} INTEGER
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(Constant.table, row, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>> get(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> data = await db.query(Constant.table, where: "${Constant.columnId} = ?", whereArgs: [id]);
    return data != null && data.isNotEmpty ? data[0] : null;
  }

  Future<List<Map<String, dynamic>>> getWatchList() async {
    Database db = await instance.database;
    return await db.query(Constant.table, where: "${Constant.columnWatchList} = ?", whereArgs: [1]);
  }

  Future<List<Map<String, dynamic>>> getSeenList() async {
    Database db = await instance.database;
    return await db.query(Constant.table, where: "${Constant.columnSeen} = ?", whereArgs: [1]);
  }

  Future<List<Map<String, dynamic>>> getAllRows() async {
    Database db = await instance.database;
    return await db.query(Constant.table);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[Constant.columnId];
    return await db.update(Constant.table, row, where: '${Constant.columnId} = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(Constant.table, where: '${Constant.columnId} = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    Database db = await instance.database;
    return await db.delete(Constant.table);
  }
}