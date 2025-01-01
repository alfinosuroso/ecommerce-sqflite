import 'package:ecommerce_sqflite/models/cart.dart';
import 'package:ecommerce_sqflite/models/cart_detail.dart';
import 'package:ecommerce_sqflite/services/database/db_helper.dart';
import 'package:ecommerce_sqflite/services/tables/cart_table.dart';
import 'package:ecommerce_sqflite/services/tables/product_table.dart';
import 'package:ecommerce_sqflite/services/tables/user_table.dart';

class CartDao {
  final DBHelper dbProvider;

  CartDao([DBHelper? dbProvider])
      : dbProvider = dbProvider ?? DBHelper.dbProvider;

  Future<bool> addToCart(Cart cart) async {
    final db = await dbProvider.database;
    final insertResult = await db.insert(CartTable.CART_TABLE, cart.toMap());
    return insertResult != 0;
  }

  Future<List<CartDetail>> getCartByUserId(int userId) async {
    final db = await dbProvider.database;

    final result = await db.rawQuery('''
    SELECT 
      c.id AS cart_id, 
      c.quantity AS cart_quantity,
      p.id AS product_id, 
      p.name AS product_name,
      p.description AS product_description,
      p.image AS product_image,
      p.price AS product_price,
      p.stock AS product_stock,
      p.userId AS user_id,
      u.id AS user_id,
      u.username AS user_name,
      u.email AS user_email,
      u.role AS user_role
    FROM ${CartTable.CART_TABLE} c
    INNER JOIN ${ProductTable.PRODUCTS_TABLE} p
    ON c.${CartTable.CART_PRODUCT_ID} = p.${ProductTable.PRODUCTS_ID}
    INNER JOIN ${UserTable.USERS_TABLE} u
    ON p.${ProductTable.PRODUCTS_USER_ID} = u.${UserTable.USERS_ID}
    WHERE c.${CartTable.CART_USER_ID} = ?
  ''', [userId]);

    return result.map((item) => CartDetail.fromQueryRow(item)).toList();
  }

  Future<bool> updateCart(Cart cart) async {
    final db = await dbProvider.database;
    final result = await db.update(CartTable.CART_TABLE, cart.toMap(),
        where: '${CartTable.CART_ID} = ?', whereArgs: [cart.id]);
    return result != 0;
  }

  Future<bool> deleteCart(int cartId) async {
    final db = await dbProvider.database;
    final result = await db.delete(CartTable.CART_TABLE,
        where: '${CartTable.CART_ID} = ?', whereArgs: [cartId]);
    return result != 0;
  }

  Future<bool> deleteCartByUserId(int userId) async {
    final db = await dbProvider.database;
    final result = await db.delete(CartTable.CART_TABLE,
        where: '${CartTable.CART_USER_ID} = ?', whereArgs: [userId]);
    return result != 0;
  }
}
