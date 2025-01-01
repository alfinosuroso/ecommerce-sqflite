import 'package:sqflite/sqflite.dart';
import 'package:ecommerce_sqflite/services/tables/user_table.dart';
import 'package:ecommerce_sqflite/services/tables/product_table.dart';

class CartTable {
  static const String CART_TABLE = "cart_table";
  static const String CART_ID = "cart_id";
  static const String CART_USER_ID = "cart_user_id";
  static const String CART_PRODUCT_ID = "cart_product_id";
  static const String CART_QUANTITY = "cart_quantity";

  static void createTable(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $CART_TABLE (
      $CART_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      $CART_USER_ID INTEGER NOT NULL,
      $CART_PRODUCT_ID INTEGER NOT NULL,
      $CART_QUANTITY INTEGER NOT NULL,
      FOREIGN KEY ($CART_USER_ID) REFERENCES ${UserTable.USERS_TABLE} (${UserTable.USERS_ID}),
      FOREIGN KEY ($CART_PRODUCT_ID) REFERENCES ${ProductTable.PRODUCTS_TABLE} (${ProductTable.PRODUCTS_ID})
    )
  ''');
  }
}
