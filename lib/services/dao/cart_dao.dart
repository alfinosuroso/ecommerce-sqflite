import 'package:ecommerce_sqflite/models/cart.dart';
import 'package:ecommerce_sqflite/models/cart_detail.dart';
import 'package:ecommerce_sqflite/services/database/db_helper.dart';
import 'package:ecommerce_sqflite/services/tables/cart_table.dart';
import 'package:ecommerce_sqflite/services/tables/product_table.dart';
import 'package:ecommerce_sqflite/services/tables/user_table.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

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
    try {
      final db = await dbProvider.database;
      List<CartDetail> cartDetails = [];

      final result = await db.rawQuery('''
    SELECT 
      c.id AS cart_id, 
      c.quantity AS cart_quantity,
      c.productId AS cart_product_id,
      c.userId AS cart_user_id,
      p.id AS product_id, 
      p.name AS product_name,
      p.description AS product_description,
      p.image AS product_image,
      p.price AS product_price,
      p.stock AS product_stock,
      p.userId AS user_id,
      u.id AS user_id,
      u.username AS user_username,
      u.email AS user_email,
      u.role AS user_role
    FROM ${CartTable.CART_TABLE} c
    INNER JOIN ${ProductTable.PRODUCTS_TABLE} p
    ON c.${CartTable.CART_PRODUCT_ID} = p.${ProductTable.PRODUCTS_ID}
    INNER JOIN ${UserTable.USERS_TABLE} u
    ON p.${ProductTable.PRODUCTS_USER_ID} = u.${UserTable.USERS_ID}
    WHERE c.${CartTable.CART_USER_ID} = ?
  ''', [userId]);

      debugPrint('Cart query result: $result');

      for (var item in result) {
        // If the product stock is 0, delete the cart row associated with that product
        if (item['product_stock'] == 0) {
          await db.delete(
            CartTable.CART_TABLE,
            where: '${CartTable.CART_ID} = ?',
            whereArgs: [item['cart_id']],
          );
          debugPrint(
              'Deleted cart item with id: ${item['cart_id']} due to zero product stock');
        } else {
          // If the product stock is not zero, add the item to the cart details list
          cartDetails.add(CartDetail.fromQueryRow(item));
        }
      }

      return cartDetails;
    } on DatabaseException catch (e) {
      debugPrint('Error fetching cart: $e');
      return [];
    }
  }

  // get all cart
  Future<List<CartDetail>> getAllCart() async {
    final db = await dbProvider.database;
    final result = await db.query(CartTable.CART_TABLE);
    return result.map((item) => CartDetail.fromQueryRow(item)).toList();
  }

  Future<bool> updateCart(Cart cart) async {
    final db = await dbProvider.database;

    debugPrint('Updating cart: ${cart.id}');
    final productResult = await db.query(
      ProductTable.PRODUCTS_TABLE,
      columns: [ProductTable.PRODUCTS_STOCK],
      where: '${ProductTable.PRODUCTS_ID} = ?',
      whereArgs: [cart.productId],
    );

    int productStock = productResult.first[ProductTable.PRODUCTS_STOCK] as int;

    if (cart.quantity > productStock) {
      debugPrint('Product stock is not enough');
      return false;
    }

    if (cart.quantity == 0) {
      debugPrint('Quantity must be greater than 0');
      final deleteResult = await db.delete(
        CartTable.CART_TABLE,
        where: '${CartTable.CART_ID} = ?',
        whereArgs: [cart.id],
      );
      return deleteResult != 0;
    }

    final updateResult = await db.update(CartTable.CART_TABLE, cart.toMap(),
        where: '${CartTable.CART_ID} = ?', whereArgs: [cart.id]);
    return updateResult != 0; // Return true if update was successful
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

  Future<bool> checkoutCart(int userId) async {
    final db = await dbProvider.database;

    final cartItems = await db.query(
      CartTable.CART_TABLE,
      where: '${CartTable.CART_USER_ID} = ?',
      whereArgs: [userId],
    );

    for (var item in cartItems) {
      int productId = item[CartTable.CART_PRODUCT_ID] as int;
      int quantity = item[CartTable.CART_QUANTITY] as int;

      await db.rawUpdate('''
      UPDATE ${ProductTable.PRODUCTS_TABLE}
      SET ${ProductTable.PRODUCTS_STOCK} = ${ProductTable.PRODUCTS_STOCK} - ?
      WHERE ${ProductTable.PRODUCTS_ID} = ?
    ''', [quantity, productId]);
    }

    final result = await db.delete(
      CartTable.CART_TABLE,
      where: '${CartTable.CART_USER_ID} = ?',
      whereArgs: [userId],
    );

    return result != 0;
  }
}
