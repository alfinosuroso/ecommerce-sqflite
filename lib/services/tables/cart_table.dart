import 'package:sqflite/sqflite.dart';
import 'package:ecommerce_sqflite/services/tables/user_table.dart';
import 'package:ecommerce_sqflite/services/tables/product_table.dart';

class CartTable {
  static const String CART_TABLE = "carts";
  static const String CART_ID = "id";
  static const String CART_USER_ID = "userId";
  static const String CART_PRODUCT_ID = "productId";
  static const String CART_QUANTITY = "quantity";

  static Future<void> createTable(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $CART_TABLE (
      $CART_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      $CART_USER_ID INTEGER NOT NULL,
      $CART_PRODUCT_ID INTEGER NOT NULL,
      $CART_QUANTITY INTEGER NOT NULL,
      FOREIGN KEY ($CART_USER_ID) REFERENCES ${UserTable.USERS_TABLE} (${UserTable.USERS_ID}),
      FOREIGN KEY ($CART_PRODUCT_ID) REFERENCES ${ProductTable.PRODUCTS_TABLE} (${ProductTable.PRODUCTS_ID}) ON DELETE CASCADE
    )
  ''');
  }
}
