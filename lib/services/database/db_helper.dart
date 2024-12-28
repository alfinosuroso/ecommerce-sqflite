import 'dart:io';

import 'package:ecommerce_sqflite/services/tables/product_table.dart';
import 'package:ecommerce_sqflite/services/tables/user_table.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBHelper {

  static final DBHelper dbProvider = DBHelper();
  static const DATABASE_NAME = "ecommerce_sqflite.db";
  static const DATABASE_VERSION = 2;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await createDatabase();
    return _database!;
  }

  Future<Database> createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DATABASE_NAME);

    var database = await openDatabase(path, version: DATABASE_VERSION, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    UserTable.createTable(database, version);
    ProductTable.createTable(database, version);
  }
}