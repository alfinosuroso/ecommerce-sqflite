import 'package:ecommerce_sqflite/services/tables/user_table.dart';
import 'package:sqflite/sqflite.dart';

class ProductTable {
  static const String PRODUCTS_TABLE = 'products';
  static const String PRODUCTS_ID = 'id';
  static const String PRODUCTS_NAME = 'name';
  static const String PRODUCTS_DESCRIPTION = 'description';
  static const String PRODUCTS_IMAGE = 'image';
  static const String PRODUCTS_PRICE = 'price';
  static const String PRODUCTS_STOCK = 'stock';
  static const String PRODUCTS_USER_ID = 'userId';

  static void createTable(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $PRODUCTS_TABLE (
      $PRODUCTS_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      $PRODUCTS_NAME TEXT NOT NULL,
      $PRODUCTS_DESCRIPTION TEXT NOT NULL,
      $PRODUCTS_IMAGE TEXT NOT NULL,
      $PRODUCTS_PRICE REAL NOT NULL,
      $PRODUCTS_STOCK INTEGER NOT NULL,
      $PRODUCTS_USER_ID INTEGER NOT NULL,
      FOREIGN KEY ($PRODUCTS_USER_ID) REFERENCES ${UserTable.USERS_TABLE} (${UserTable.USERS_ID})
    )
  ''');
  }
}
