import 'dart:io';

import 'package:ecommerce_sqflite/services/tables/cart_table.dart';
import 'package:ecommerce_sqflite/services/tables/product_table.dart';
import 'package:ecommerce_sqflite/services/tables/user_table.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper dbProvider = DBHelper();
  static const DATABASE_NAME = "ecommerce_sqflite.db";
  static const DATABASE_VERSION = 10;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await createDatabase();
    return _database!;
  }

  Future<Database> createDatabase() async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, DATABASE_NAME);

      return await openDatabase(path,
          version: DATABASE_VERSION,
          onCreate: initDB,
          onUpgrade: onUpgrade,
          onConfigure: onConfigure);
    } catch (e) {
      debugPrint("Database creation failed: $e");
      rethrow;
    }
  }

  Future<void> onUpgrade(
      Database database, int oldVersion, int newVersion) async {
    if (newVersion > oldVersion) {
      // update tables
      // debugPrint("update tables");
      // await database.execute('''DROP TABLE IF EXISTS carts''');
      // CartTable.createTable(database, newVersion);
    }
  }

  void deleteAllTables(Database database) async {
    await database.execute('''DROP TABLE IF EXISTS ${UserTable.USERS_TABLE}''');
    await database
        .execute('''DROP TABLE IF EXISTS ${ProductTable.PRODUCTS_TABLE}''');
    await database.execute('''DROP TABLE IF EXISTS ${CartTable.CART_TABLE}''');
  }

  void initDB(Database database, int version) async {
    UserTable.createTable(database, version);
    ProductTable.createTable(database, version);
    CartTable.createTable(database, version);
  }

  void onConfigure(Database db) async {
    // Add support for cascade delete
    await db.execute("PRAGMA foreign_keys = ON");
  }
}
